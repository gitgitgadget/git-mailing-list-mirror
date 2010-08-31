From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC 06/17] gettext: localize the main git-init message
Date: Tue, 31 Aug 2010 10:10:44 -0500
Message-ID: <20100831151044.GF2315@burratino>
References: <1283203703-26923-1-git-send-email-avarab@gmail.com>
 <1283203703-26923-7-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Marcin Cieslak <saper@saper.info>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 31 17:12:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqSVp-0000OK-BH
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 17:12:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932402Ab0HaPMc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Aug 2010 11:12:32 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64850 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932359Ab0HaPMb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Aug 2010 11:12:31 -0400
Received: by fxm13 with SMTP id 13so3969664fxm.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 08:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=XADnNNu9831m6usa9y24W1/YknZ3fDFz8hImnIvj/W8=;
        b=oaHmW2PFBYX8ZZlLgPeQ3CFe+bJAH87o6WmwXtGf+CI5+pooAu/T9U2HIUfP2OIb96
         q8a1V9xNLle32CYBqyVliYFBDphhQF+MDuvG2cjw2KpZYVf2aSQO4nH7JJgGxtLvKXiV
         I74QOT3mrPuuCzHXKOL/cHop67QxUyidIQzYg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=btqxlWOfGZLEDusd94oSrB2tx/r846azzKHX9iIUNfroX16bOtsBC70Zz+dWRyfxC3
         18oGw3WPg4FuRK3DPLXcGUCsQd597+F805Gn3IUSRpmBK5K1+x61kaBmnEiCawQibRjv
         FGab4RDLxbxSKt6lthUryTyy+69+096UixpMc=
Received: by 10.223.106.8 with SMTP id v8mr5472266fao.104.1283267550563;
        Tue, 31 Aug 2010 08:12:30 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id a7sm2653103faa.21.2010.08.31.08.12.27
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 31 Aug 2010 08:12:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1283203703-26923-7-git-send-email-avarab@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154909>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Note that the TRANSLATORS comment doesn't use the usual Git
> style. This is because everything from "/* TRANSLATORS: " to "*/" wil=
l
> extracted as-is xgettext(1) and presented to translators, including
> newlines and leading "*"'s.

How would it cope with the following?

	/* TRANSLATORS:
	 * The first '%s' is either "Reinitialized existing" or
	 * "Initialized empty", the second " shared" or "", and
	 * the last '%s%s' is the verbatim directory name.
	 */

The leading column of stars makes it easier to distinguish code
from comments.  (Plus I am not too happy to read code with two
inconsistent comment styles used.)
