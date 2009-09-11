From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [PATCH v2] Re: add documentation for mailinfo.scissors and
	'--no-scissors'
Date: Fri, 11 Sep 2009 22:08:49 +0200
Message-ID: <20090911200849.GB18684@vidovic>
References: <33445216edc4c4e1976cdd81521922042955e6eb.1252626034.git.nicolas.s.dev@gmx.fr> <f63e8402656c02fc2ecdcce8a37cc1d60a61aa1d.1252628643.git.nicolas.s.dev@gmx.fr> <7veiqe0x05.fsf@alter.siamese.dyndns.org> <20090911134112.GA18684@vidovic> <7vws45wbxq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 11 22:09:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmCQZ-00054Q-Hq
	for gcvg-git-2@lo.gmane.org; Fri, 11 Sep 2009 22:09:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756475AbZIKUIw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2009 16:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755939AbZIKUIv
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Sep 2009 16:08:51 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:65511 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756475AbZIKUIv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2009 16:08:51 -0400
Received: by ewy2 with SMTP id 2so1416725ewy.17
        for <git@vger.kernel.org>; Fri, 11 Sep 2009 13:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=yWxrvrT26oK+6clf8Pc7rvKc2lbviE6e5DDXWFcy+uo=;
        b=qnDLi4HxezJtGxdKYYqnWNC2caeUZK27IVXD1PsBd85xj5FKeJTG8bI71Lxf2mFaiJ
         DxNHAqJx3Ju3c9XHLSKBXKIoKn4X2I9dXykr+85czmSQiQPMdh1R59KwtlMFGtdcLSnC
         REbLrQ2JKzMi8iJWSgtBiiLby1Hud9f8NdArQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ogMyoYL3xbHUwSaS9grApLEADoI+QsspRmSEG54AugXwaFe8tZf7Dsdo0FJCkXtjO/
         1MfEOol1Jhawx5c8ZBu3zWAoLE+e7YYYMIxDaHS/l1++MrgiqxLHf3a5N5BxxfBQuUjq
         3n+6cxtkep30NEF7akVPl7THLVOf2B/+chmwQ=
Received: by 10.211.173.11 with SMTP id a11mr3727170ebp.42.1252699733140;
        Fri, 11 Sep 2009 13:08:53 -0700 (PDT)
Received: from @ (91-165-134-53.rev.libertysurf.net [91.165.134.53])
        by mx.google.com with ESMTPS id 7sm1893310eyg.34.2009.09.11.13.08.51
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 11 Sep 2009 13:08:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vws45wbxq.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128216>

The 11/09/09, Junio C Hamano wrote:
> Nicolas Sebrecht <nicolas.s.dev@gmx.fr> writes:
> 
> As scissors is not marked with ! (see PARSEOPT section in the rev-parse
> documentation), no-scissors is already available without that hunk, and
> that is why your patch is unnecessary.
> 
> Your patch did not mark no-scissors with ! either, so it makes the call to
> rev-parse --parseopt to process your OPTIONS_SPEC pass --no-no-scissors.

Ok. So, the fact that the usage of git-am doesn't tell about
--no-scissors is the expected behaviour?

Without changing the current implementation of rev-parse, I can't see a
smart way to add --no-scissors in the 'git am' usage. Yes, there's still
the possibility to negate both "c,scissors" and "no-scissors" but this
would defeate some of the PARSE_OPT_NONEG purpose, right?

Oh, and I still feel a bit disoriented by this "rev-parse --parseopt"
thing. I guess I need to read the code. :-)

-- 
Nicolas Sebrecht
