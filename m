From: Christian MICHON <christian.michon@gmail.com>
Subject: Re: [msysGit] Git for Windows 1.6.4
Date: Thu, 30 Jul 2009 00:03:45 +0200
Message-ID: <46d6db660907291503o6979ef9fvbef5d25fa4318e37@mail.gmail.com>
References: <alpine.DEB.1.00.0907292331090.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 30 00:03:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWHFc-000485-2M
	for gcvg-git-2@gmane.org; Thu, 30 Jul 2009 00:03:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754141AbZG2WDs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Jul 2009 18:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754125AbZG2WDs
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 18:03:48 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:59495 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051AbZG2WDr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jul 2009 18:03:47 -0400
Received: by bwz19 with SMTP id 19so255360bwz.37
        for <git@vger.kernel.org>; Wed, 29 Jul 2009 15:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=10LnxclsxwMGmYtgG6iiXX6Ww8bPXKbDtjAu5pnjKuc=;
        b=MXaVN6/H/9qEQ86aqn2uIVrDOhg5E+TIRQOUXnU0QCNDdw9SoxTrkYDIe6ODCgw2ef
         J6qdmlYYSs/JEOC04cnFyw4nvY48aDXr7p8Sp5YgiVi/y4qffw1pYgUtyTCbrX+9rPCm
         dHcT+difgm2nZ/JgG3Hxz8icIE2l8+pDN2Rso=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=B3WcGE3HRPGUZxJiyogQFsuf7WeMot+3/rtGAgBpJifVHSztqNqJPTlCXA+2LP7i2+
         vhq2ri9oGYGB/WaOE29OTwCRnuZtlt387ZwxYC40dHMvX2FC1zD618xOoTzSLeCGKDGB
         uQN+u/uDztYOMTl1fo7apZ+shH85Bo9dK0DMY=
Received: by 10.204.71.68 with SMTP id g4mr292404bkj.135.1248905025904; Wed, 
	29 Jul 2009 15:03:45 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0907292331090.8306@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124395>

On Wed, Jul 29, 2009 at 11:40 PM, Johannes
Schindelin<Johannes.Schindelin@gmx.de> wrote:
>
> Hi,
>
> this mail informs you that Git for Windows 1.6.4 is out. =A0It is les=
s well
> tested than the previous versions, mainly because I was busy with oth=
er
> things and asked for help with testing on the msysGit mailing list an=
d I
> am very impatient.

I'm still too busy, but since I saw your email arriving live and I've
Vista here, I kept some minutes for you :)

>
> Git Release Notes (Git-1.6.4-preview20090729)
> Last update: 29 July 2009
>

bad news: here the installation complains around the end (all default a=
nswers)

"Could not set CR/LF behavior: core.autoCRLF true"

Using git gui works, calling gitk from it works.
But git bash initiates a shell complaining:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-------------------------------------------------------
Building and Installing Git
-------------------------------------------------------
sh.exe": cd: /git: No such file or directory


-------------------------
Hello, dear Git developer.

This is a minimal MSYS environment to work on Git.

Your build failed...  Please fix it, and give feedback on the Git list.

Welcome to Git (version 1.6.4-preview20090729)


Run 'git help git' to display the help index.
Run 'git help <command>' to display help for specific commands.
Run '/share/Git (version 1.6.4-preview20090729)/add-shortcut.tcl' to ad=
d a short
cut to msysGit.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Apparently, git binaries are not in the path. I'll check on a winXP
and win2003 environments asap.

--=20
Christian
--
http://detaolb.sourceforge.net/, a linux distribution for Qemu with Git=
 inside !
