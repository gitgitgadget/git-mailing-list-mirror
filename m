From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Roadmap to better handle big files?
Date: Wed, 24 Feb 2010 15:51:00 -0800 (PST)
Message-ID: <m3fx4qmbwr.fsf@localhost.localdomain>
References: <B85968F5-E7C2-499D-A8BE-0160BA575F10@perceptivepixel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Nick Triantos <nick@perceptivepixel.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 00:51:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkR0Z-0001vL-2w
	for gcvg-git-2@lo.gmane.org; Thu, 25 Feb 2010 00:51:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758622Ab0BXXvH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 18:51:07 -0500
Received: from mail-bw0-f209.google.com ([209.85.218.209]:53949 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758420Ab0BXXvF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 18:51:05 -0500
Received: by bwz1 with SMTP id 1so2425527bwz.21
        for <git@vger.kernel.org>; Wed, 24 Feb 2010 15:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=mQAVRdHIN1b/xC1QgT1FFTf+ytmk+Vx1dBBlreE/r7E=;
        b=R8hqnzYkLnyLjH8Ej8ratxdPuIKB9jAUu/3CDv3aGkBLFO+2jU1pLjrXUcxbc1GYqR
         /coMUNMAIPKKpc73zYzAMqM+Lm2bZzeAoU2PC3Os8GOCe18InRVIxH2dHHYzQtzf1Mza
         00xUULBCiDMf4vP/STJkiTejinbdKSRc6UzVU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=QmLoKHgiJsWXl3Kpe82AfeH+1r3bpe3ctsERFY/My4YZ9vJYOMiXUtVDElyLkH34QQ
         wfBQO6ufgmi1VqDcPhIPC7wgYrEhso940biAejfHghcDsakE3r4yqYYLmlZm+UDmj+xJ
         41/eKcMCRRGJ6nLKVY/BU9LNB/BdZOnb4AMTI=
Received: by 10.204.3.216 with SMTP id 24mr326507bko.30.1267055461392;
        Wed, 24 Feb 2010 15:51:01 -0800 (PST)
Received: from localhost.localdomain (abwm143.neoplus.adsl.tpnet.pl [83.8.236.143])
        by mx.google.com with ESMTPS id 14sm3066734bwz.14.2010.02.24.15.50.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Feb 2010 15:51:00 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o1ONoTYL026080;
	Thu, 25 Feb 2010 00:50:39 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o1ONoDbu026076;
	Thu, 25 Feb 2010 00:50:13 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <B85968F5-E7C2-499D-A8BE-0160BA575F10@perceptivepixel.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141012>

Nick Triantos <nick@perceptivepixel.com> writes:

> Is there any planned functionality to better support large files in
> git?  (> 100MB / file)
> 
> We've been happily using git but we now have some files which we'd
> very much like to have under the same version control as our source
> code, and some of those files have been as large as 450MB/file.  We
> are looking at chunking the file up before commiting it to git, but
> is there any plan to better support chunking of these files during
> repacks or other operations?  Right now, it appears either the whole
> file, or the whole collection of files in a commit (not sure which)
> can need to be resident in memory up to twice, from reading various
> places on the web.  Our poor 32-bit server is barfing on this.  We
> are going to put more RAM and a 64bit OS on the machine, but this
> still seems like an unnecessary design decision.

Git has a roadmap???

More seriously, take a look at git-bigfiles project (fork):
http://caca.zoy.org/wiki/git-bigfiles

HTH
-- 
Jakub Narebski
Poland
ShadeHawk on #git
