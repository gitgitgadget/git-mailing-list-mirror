From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: t6200: avoid path mangling issue on Windows
Date: Sat, 20 Apr 2013 17:05:22 -0700
Message-ID: <20130421000522.GB10043@elie.Belkin>
References: <1365348344-1648-1-git-send-email-ralf.thielow@gmail.com>
 <1365348344-1648-2-git-send-email-ralf.thielow@gmail.com>
 <516F95D1.5070209@viscovery.net>
 <7v38un93br.fsf@alter.siamese.dyndns.org>
 <5170DA96.9000300@viscovery.net>
 <7vr4i632fp.fsf@alter.siamese.dyndns.org>
 <51719F18.3020508@kdbg.org>
 <7va9ouz04y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>,
	Ralf Thielow <ralf.thielow@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 21 02:05:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UThmi-00080n-2Z
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 02:05:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756024Ab3DUAFb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Apr 2013 20:05:31 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:37290 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756018Ab3DUAFb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Apr 2013 20:05:31 -0400
Received: by mail-pa0-f47.google.com with SMTP id bj1so966139pad.6
        for <git@vger.kernel.org>; Sat, 20 Apr 2013 17:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=gI0ECl/GgOEPjRGsty/YgDBpzaBkkiTM9F3yCq1VP7E=;
        b=ZrtmMcn6IbSNfQDcZwPMgwE1MdvLcGVRxnb/meDo4Z9/fyCyZgYV6YdTEMYhdQA2ON
         /PNa0mbZlTHmCGGQDY8WDFHzP1B6wHUj9x5hhQF+wVRlm1PoUr2CRrUR1UWqCeXHPZwC
         li4diufsoEkmI9x40d95ss6CwR1ykxTOFPzSdUBcjsufxcVk5qQ6sfsO8MKDi81Qve+w
         56JheoKKJAGNSb+uF1D4TPy5RR43UxNbTf6GPBjCj09HHXiinkloX40LR/O5nkFv1Lc6
         AeT0bH+fy/WJxI+0Z15J9/w9sUu/FTsMGeb/k7J8kjaNqq/fQGpGFiQ2BAx8aWRNRFEY
         0W7w==
X-Received: by 10.68.221.200 with SMTP id qg8mr25527517pbc.58.1366502730695;
        Sat, 20 Apr 2013 17:05:30 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id vv6sm20521106pab.6.2013.04.20.17.05.28
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 20 Apr 2013 17:05:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7va9ouz04y.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221884>

Junio C Hamano wrote:

> But a _real user_ who wants to use a slash there has no way of doing
> so.

Doesn't foo=// do that in the msys world?  If I am reading
mingw/msys/rt/src/winsup/cygwin/path.cc correctly then the way to pass
a true double-slash is foo=///.

Jonathan
