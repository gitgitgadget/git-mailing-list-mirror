From: "Caleb Cushing" <xenoterracide@gmail.com>
Subject: Re: trouble getting git cvsimport working
Date: Sat, 10 Jan 2009 09:35:28 -0500
Message-ID: <81bfc67a0901100635i4d33c294x393a8d2dfc2b0e0d@mail.gmail.com>
References: <81bfc67a0901100516w10ea77e8n8734713b071d69b9@mail.gmail.com>
	 <alpine.DEB.1.00.0901101524310.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jan 10 15:37:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLexV-0002jT-0S
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 15:37:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753409AbZAJOfb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2009 09:35:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753383AbZAJOfb
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jan 2009 09:35:31 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:53475 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753324AbZAJOfa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2009 09:35:30 -0500
Received: by bwz14 with SMTP id 14so30221565bwz.13
        for <git@vger.kernel.org>; Sat, 10 Jan 2009 06:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=STxNTNZpV1I93NdcthjW8I93T5rZC9kGrw5SuWLaLN4=;
        b=iQwm1416QT6H3oO3+Ys8Zl/1Y2l29kz9HePGSJr7Mmv8Zi2yIJSeOxwhtFilLpfyv4
         BGjwT4Vc6e0nqKcIBpnHJBTYv/MUAyMbvHHhZ1B/Esv+JXn9ZXXV7hR8qlTgm14eKp/J
         zLoKtdqo2R8JMW46yVF8F5ZjDCA6msudFPbxk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=oHuRToO1si6YCqdeP3pT4WpOUE8m/az4Mb67cAYPkxiHgJIdoExLyKg/Dv6osTT6Fk
         Ui853i0/mkr9eLu6u3wBBsChO8673wCpZJYqgG0Btm5YDy3CltWPKdloyY8KBr2MVG/T
         djpw0KzbhWzPXgHBx3iSwSUlpOzWvGBwDM1Ko=
Received: by 10.223.116.10 with SMTP id k10mr19418830faq.101.1231598128490;
        Sat, 10 Jan 2009 06:35:28 -0800 (PST)
Received: by 10.223.108.12 with HTTP; Sat, 10 Jan 2009 06:35:28 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0901101524310.30769@pacific.mpi-cbg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105116>

>  > sh: cvs: command not found
>
>
> What's this?

does git need more than cvsps to work (I assumed my package manager
had installed all needed deps)? I installed cvs after you pointed that
out...

git cvsimport -a -v -d
:pserver:anonymous@anoncvs.gentoo.org/var/cvsroot/ gentoo-x86 -C
portage
Initialized empty Git repository in /home/portdev/cvs/portage/.git/
Running cvsps...
parse error on third token
WARNING: malformed CVS version str: Server: (unknown)
WARNING: Your CVS client version:
[Client: Concurrent Versions System (CVS) 1.12.12 (client)]
and/or server version:
[Server: (unknown)]
are too old to properly support the rlog command.
This command was introduced in 1.11.1.  Cvsps
will use log instead, but PatchSet numbering
may become unstable due to pruned empty
directories.

cvs log: warning: failed to open /home/portdev/.cvspass for reading:
No such file or directory
cvs log: in directory .:
cvs [log aborted]: there is no version here; run 'cvs checkout' first
DONE; creating master branch
fatal: refs/heads/origin: not a valid SHA1
fatal: master: not a valid SHA1
fatal: You are on a branch yet to be born
checkout failed: 32768
-- 
Caleb Cushing

http://xenoterracide.blogspot.com
