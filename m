From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Dumb idea on git library for script languages
Date: Mon, 28 Apr 2008 00:31:02 -0700 (PDT)
Message-ID: <m38wyyphai.fsf@localhost.localdomain>
References: <1209366216.17090.4.camel@prosumer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: tsgates <tsgatesv@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 09:32:02 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqNqC-000519-FU
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 09:32:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765516AbYD1HbM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 03:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763654AbYD1HbM
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 03:31:12 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:42270 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765506AbYD1HbL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 03:31:11 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1830804nfb.21
        for <git@vger.kernel.org>; Mon, 28 Apr 2008 00:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=oi6jYyZ1Z+pNs5HT4tiuMORdfofJGYAlBoxduc88Nd4=;
        b=o1rajtfV61f9mKrcPzz1BoEpMOqkALNNsa/cXrobbQrTjDjgfwlWlHnbiLOWxVKHIt6DYgap01L/EFIIiG+Zhwmd2ZCajtbsiBmWtwRaiy5dkg5JBKpRMTbYvevGmVkSFa5NSkKjIklzOjLhp08oM0t51HThMnLqQ1/kteH2fOE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=TvmpNgr6Yw1uxXwpm4SyF3TkozUTOKnehdygE1O3r2FLyOI2panTR2tSG2Cs7F3Hevslh5e9qBDVTB0AwGxDWwYwQYr+cbH1UpBr+BhMlFGJCScblNywMGsmtCAMuagvY1fR2SWeugccnzaKJ4HrwYW4aqzMHiFPNi4vtENBGPE=
Received: by 10.210.61.8 with SMTP id j8mr5364447eba.199.1209367867301;
        Mon, 28 Apr 2008 00:31:07 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.207.149])
        by mx.google.com with ESMTPS id g17sm7982024nfd.10.2008.04.28.00.31.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 Apr 2008 00:31:02 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m3S7V3M7021017;
	Mon, 28 Apr 2008 09:31:04 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m3S7V2Cn021014;
	Mon, 28 Apr 2008 09:31:02 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1209366216.17090.4.camel@prosumer>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80506>

tsgates <tsgatesv@gmail.com> writes:

> When I try to use git in python, there are no fancy ways not to fork any
> processes.  (except not active git library) I know it is design policy
> of git, one job for one process.
> 
> Anyhow, I need to call git in python and perl, so I try to think.
[...]
> If there are any other good suggestions or recommendations on it, please
> recommend it.

Please take a look at libgit-thin project, which was Google Summer of
Code 2007 project; it was meant to create PyGit, git bindings for
Python.  I don't know how far it is/got advanced.

InterfacesFrontendsAndTools page on Git Wiki mentions it.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
