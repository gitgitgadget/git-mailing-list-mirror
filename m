From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Implementations of Git (was: re-licensing pkt-line.c code)
Date: Thu, 25 Sep 2008 10:49:09 -0700 (PDT)
Message-ID: <m3od2c2k29.fsf@localhost.localdomain>
References: <d411cc4a0809251017h5509bbdmaef935c61cc0929@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git list" <git@vger.kernel.org>
To: "Scott Chacon" <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 25 19:50:29 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kiuyw-00043s-8k
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 19:50:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753681AbYIYRtR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2008 13:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755453AbYIYRtQ
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 13:49:16 -0400
Received: from mu-out-0910.google.com ([209.85.134.188]:45005 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753681AbYIYRtO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 13:49:14 -0400
Received: by mu-out-0910.google.com with SMTP id g7so436627muf.1
        for <git@vger.kernel.org>; Thu, 25 Sep 2008 10:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=+EzVYRqIw/v1Bc984D3dnWg68ihrf4mk4v6pe36j4Lw=;
        b=ek/gMTI8x/Wqe+bIbGZ3ZBW8MnhzpgEroeaOv5yFDlvjLAWYLgjvQG+Z6RqBXLOjYI
         prIoGg2LT9eA9fLLiTDOqG1sApilbDdgn93J2DL9l5WhYuOWnX0xM4OTfZEjNzZUHAm0
         XpZtoyxn/ktiiZWk2C8ExUTcij0DcFLC2e9rQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=aY+e5Ptg3rruchuyCcn1cVHdiPiMWtreYvb8+KroE9h7tjcLHjSdKCWIJQ/3P74QuS
         1NYp+xe87l+1pJKnQxYE4i3MWXNZfHXttDItrDKsgN3uq0EqyleoRcZUXy6fMQtsYtbA
         kdEsuuwY3h35OJuooZkbZCWZlbJEAtpFvNiuU=
Received: by 10.180.246.10 with SMTP id t10mr29567bkh.104.1222364951317;
        Thu, 25 Sep 2008 10:49:11 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.235.56])
        by mx.google.com with ESMTPS id l12sm2401898fgb.6.2008.09.25.10.49.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Sep 2008 10:49:09 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m8PHmgs2000322;
	Thu, 25 Sep 2008 19:48:52 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m8PHmVpB000318;
	Thu, 25 Sep 2008 19:48:31 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <d411cc4a0809251017h5509bbdmaef935c61cc0929@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96786>

"Scott Chacon" <schacon@gmail.com> writes:

> I am writing a partial implementation of git in Objective-C so I can
> get a git server running on an iphone, and hopefully it could
> eventually be used in a mac desktop app that could be distributed
> without the git binary. If anyone is interested in the project, you
> can get it here:
> 
> http://github.com/schacon/objective-git

Could you add it to "Interfaces to other programming languages"
section[1] at http://git.or.cz/gitwiki/InterfacesFrontendsAndTools
if you feel it is quite ready?

[1] Perhaps it should be renamed to "Interfaces to and implementations
    in other programming languages"...


P.S. Do you know what is the status of git#, implementation of Git in
C#, which was one of this year Google Summer of Code projects?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
