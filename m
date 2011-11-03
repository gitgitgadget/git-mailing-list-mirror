From: Eugene Sajine <euguess@gmail.com>
Subject: Re: Folder level Acces in git
Date: Thu, 3 Nov 2011 15:28:53 -0400
Message-ID: <CAPZPVFY15AqCpWcRbv0tjXBz4G2kQTm+nMGpsYzCKe0niHV_dA@mail.gmail.com>
References: <1320300655224-6958047.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: redhat1981 <redhat1981@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 03 20:29:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RM2yA-0005wS-RG
	for gcvg-git-2@lo.gmane.org; Thu, 03 Nov 2011 20:28:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934508Ab1KCT2y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Nov 2011 15:28:54 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:34091 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755060Ab1KCT2x convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Nov 2011 15:28:53 -0400
Received: by iage36 with SMTP id e36so1690560iag.19
        for <git@vger.kernel.org>; Thu, 03 Nov 2011 12:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=HMAuj7OVkzTU5XzFfspI2XOjWNKpOidQXzYtqO4X37Q=;
        b=GiCnp3eKVM2eYffq7vzJk1C23GKyHH623HF3J7GeRu2RHcHdjseb3C9oASNDc3M7i+
         ODoPtTmmw0YGAvsvnyzXcPrvmg3U0xWkspg7lure7Q/iCJOz25yghtyk/PNKipkolJ4U
         FNAGIwfBgVsXPH6p7gLODG/DKBbfdh5jCtMMc=
Received: by 10.231.21.211 with SMTP id k19mr2690104ibb.13.1320348533345; Thu,
 03 Nov 2011 12:28:53 -0700 (PDT)
Received: by 10.231.103.6 with HTTP; Thu, 3 Nov 2011 12:28:53 -0700 (PDT)
In-Reply-To: <1320300655224-6958047.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184741>

On Thu, Nov 3, 2011 at 2:10 AM, redhat1981 <redhat1981@gmail.com> wrote=
:
> Hi,
>
> I am using Gitosis, Adding the gitosis conf file
>
> [group testabc]
> writable =3D testabc
> members =3D =C2=A0 shrii Abhijeet premkumar
> add cgit =3D yes
> gitweb =3D yes
>
>
> [group testabc-readonly]
> readonly =3D testabc
> members =3D =C2=A0Ganesh Shweta
> add cgit =3D yes
> gitweb =3D yes
>
> Inside the repository, testabc let us say there are folders folder1, =
folder
> 2 etc, I want some users to have read/write, read or no access to the
> folder1 or folder2, Is this possible in Git, I have done it in SVN, P=
lease
> help!!
>
> redhat1981@gmail.com
>


Are you sure that the way your have organized the repository is
actually correct? If you need to manage the access on folder level why
don't you simply split up the project into several
repositories/projects which each team is going to work with
independently?

This seems to me to be much simpler and cleaner solution then any
other alternative.

Thanks,
Eugene
