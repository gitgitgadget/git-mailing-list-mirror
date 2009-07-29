From: Christian MICHON <christian.michon@gmail.com>
Subject: Re: [msysGit] Git for Windows 1.6.4
Date: Thu, 30 Jul 2009 00:22:40 +0200
Message-ID: <46d6db660907291522t142ea972uc60472af7065d33a@mail.gmail.com>
References: <alpine.DEB.1.00.0907292331090.8306@pacific.mpi-cbg.de>
	 <46d6db660907291503o6979ef9fvbef5d25fa4318e37@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 30 00:22:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWHXw-0002Yv-6G
	for gcvg-git-2@gmane.org; Thu, 30 Jul 2009 00:22:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754607AbZG2WWm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Jul 2009 18:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754577AbZG2WWm
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 18:22:42 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:63699 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754247AbZG2WWl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jul 2009 18:22:41 -0400
Received: by bwz19 with SMTP id 19so262332bwz.37
        for <git@vger.kernel.org>; Wed, 29 Jul 2009 15:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9UOGYmhPlIHUP9BPRBJLMIpMTq4YDrLwg8HW/b2Cwgk=;
        b=JQcNNhUJWFvyfwwltj8GEiK645Fu3+7XuhwK/Qme9QL4wC4pXgtGDycm2qQO/K3+gR
         TnrMdkeQ1bVRgi4E7jsFl0C06M+yq+WEngV734IQwPeoRqGsPBn48/g+s2rhGh+AZyoU
         WYJNt7/Zhe9vHVeFCGHl6r+TsDApSq6qX3iqw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Ex00DBJ4ikMbCWb/rnMxgVQIhQ320c8cQcMEqK+qyed5E9e4HXxo3ynsNt6tiUBcWC
         DA5X5FbiXL/dej9MTxFlTDQImHvPkU3sBq4PRisjsMG6M+sHg6j1xuOSm1e9XfQDoCXe
         7p6tRoiPnyuV6+oIWGyCz8gYtdtto0FRYS9gk=
Received: by 10.204.102.133 with SMTP id g5mr294634bko.180.1248906160316; Wed, 
	29 Jul 2009 15:22:40 -0700 (PDT)
In-Reply-To: <46d6db660907291503o6979ef9fvbef5d25fa4318e37@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124399>

On Thu, Jul 30, 2009 at 12:03 AM, Christian
MICHON<christian.michon@gmail.com> wrote:
>> Git Release Notes (Git-1.6.4-preview20090729)
>> Last update: 29 July 2009
>>
>
> bad news: here the installation complains around the end (all default=
 answers)
>
> "Could not set CR/LF behavior: core.autoCRLF true"
>
> Using git gui works, calling gitk from it works.
> But git bash initiates a shell complaining:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -------------------------------------------------------
> Building and Installing Git
> -------------------------------------------------------
> sh.exe": cd: /git: No such file or directory
>
>
> -------------------------
> Hello, dear Git developer.
>
> This is a minimal MSYS environment to work on Git.
>
> Your build failed... =A0Please fix it, and give feedback on the Git l=
ist.
>
> Welcome to Git (version 1.6.4-preview20090729)
>
>
> Run 'git help git' to display the help index.
> Run 'git help <command>' to display help for specific commands.
> Run '/share/Git (version 1.6.4-preview20090729)/add-shortcut.tcl' to =
add a short
> cut to msysGit.
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Apparently, git binaries are not in the path. I'll check on a winXP
> and win2003 environments asap.
>

I confirm I see the same problems on Vista and Windows 2003 (it was a
fresh install of the OS).

I see you're replying now. I'll move my answers to next email.

--=20
Christian
--
http://detaolb.sourceforge.net/, a linux distribution for Qemu with Git=
 inside !
