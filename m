From: Michael Witten <mfwitten@gmail.com>
Subject: Re: File Systems and a Theory of Edits
Date: Sun, 31 Jul 2011 17:21:27 +0000
Message-ID: <CAMOZ1BtrgO1XhJfR2-1Mpd8Ytrz4pjVyhbPdbNxDP84hhiip+A@mail.gmail.com>
References: <CADo4Y9hG=-Bye5g7OWROJNbbUOcnH0hj0f3csws5V+YzEUKAMg@mail.gmail.com>
 <CACBZZX48aDN_Njm+qMvovfz1tjdhnmXe5-bbJe=0_Q3LbLWoPA@mail.gmail.com>
 <4E350F15.9050009@lsrfire.ath.cx> <CADo4Y9gU_Z73gCPCESvVZhLOJUJg+mTqHkeqpNv2L8xLJvKxEQ@mail.gmail.com>
 <CADo4Y9gECLJ45g_r-uZBRnfEVXBRw2EoF2HkRu=0-eJ2YCuBLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: mike@nahas.com
X-From: git-owner@vger.kernel.org Sun Jul 31 19:22:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnZir-0000Qp-AY
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jul 2011 19:22:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752735Ab1GaRV7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Jul 2011 13:21:59 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:40078 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752373Ab1GaRV6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Jul 2011 13:21:58 -0400
Received: by iyb12 with SMTP id 12so5960720iyb.19
        for <git@vger.kernel.org>; Sun, 31 Jul 2011 10:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Xb5umwBVq0zz4R+t827R8KKYsvf9gOlVG9gLGXdbJmA=;
        b=BGuCsvvwgzffj5t3ZbaZkj7AHhrgQshBJazBGdzd+JFWAND8Nv8dkuEu8AMifWDCPC
         olII/dFWFZz/7c8hormlZLmfnZKPp9uIjwPg8sNiy6xe15G7QpHBUdJ4ExIhcL7+Yxu0
         gLXokY4FvpWWmVPL/qmzM/rGjtaWtEAzqHAyM=
Received: by 10.42.95.137 with SMTP id f9mr2517587icn.376.1312132917167; Sun,
 31 Jul 2011 10:21:57 -0700 (PDT)
Received: by 10.43.52.136 with HTTP; Sun, 31 Jul 2011 10:21:27 -0700 (PDT)
In-Reply-To: <CADo4Y9gECLJ45g_r-uZBRnfEVXBRw2EoF2HkRu=0-eJ2YCuBLA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178265>

On Sun, Jul 31, 2011 at 14:15, Michael Nahas <mike.nahas@gmail.com> wro=
te:
> I believe the solution for xargs may be John D.'s solution - to
> "mount" the snapshot as a file system.=C2=A0 And the "mount" command =
in git
> is "git checkout".=C2=A0 (Now, I almost want to rename "git checkout"=
 to
> "git remount"!)

Why not just `git mount', though? We could have different mount points
too, so that it's easy to work with multiple `snapshots' at once (in
the spirit of bazaar and mercurial, as well).

Perhaps `git umount' could be used to make the repository bare.

In any case, I always find myself wishing that the standard interfaces
would make it easier to base an operation on a snapshot that is not
yet mounted as the working tree. It can be quite cumbersome to switch
the contents of the working tree.
