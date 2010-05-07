From: Eugene Sajine <euguess@gmail.com>
Subject: git log -M -- filename is not working?
Date: Fri, 7 May 2010 14:07:53 -0400
Message-ID: <z2w76c5b8581005071107w79d30963g725269febe746f0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eugene Sajine <euguess@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 07 20:08:01 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OARxx-0001ii-6Q
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 20:08:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757269Ab0EGSHz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 May 2010 14:07:55 -0400
Received: from mail-qy0-f195.google.com ([209.85.221.195]:53033 "EHLO
	mail-qy0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757098Ab0EGSHz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 May 2010 14:07:55 -0400
Received: by qyk33 with SMTP id 33so2223142qyk.24
        for <git@vger.kernel.org>; Fri, 07 May 2010 11:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=QhD2/2uKILZC2OwOJqkkNoehFPnQL6JPdnDkVSgGz+4=;
        b=Fhuwy2GrTJ6bBpt7ruxjRuLNlgqm0Qdec0eIMmwQibpKLtb7fX/uTttvoF/z5JnHMw
         hF1k3awqTvbSozlZA6PU+whgDYzl9DX4OMslzjBilkSut3DWUcHYX9ps/VcbJKyezKUQ
         81AlyOEoy7jhC4qtf6tqrOmSnWCJpHG6447Ak=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=AtgHuGeTA361xAp3FU0QXQ12OhnQUu2svPk0WXteUNUZLp2JYhzXkUQSfVboHTv0jf
         1j2A4LdwHZfDecWFGvYeKra3YoBS21PzRaNtziZBSsVU2aa2TZiXJgu2qUpJNdmRMygh
         lIRF2LrBuFh3wfhRrzVpmS4UgHAZDz7/GGrZc=
Received: by 10.224.58.78 with SMTP id f14mr148287qah.385.1273255673777; Fri, 
	07 May 2010 11:07:53 -0700 (PDT)
Received: by 10.229.229.6 with HTTP; Fri, 7 May 2010 11:07:53 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146547>

Hi!

I tried it in both git 1.6.5.6 and git 1.7.0.5

The file has been moved:

=46rom
Src/folder1/folder2/File.java

To src/main/java/folder1/folder2/File.java

I don=E2=80=99t think it is relevant but just in case: The author has
committed the new file first, then the commit was amended with the
deletion of the source file.
So we ended up with the rename correctly detected.

Now
$ git log =E2=80=93M -- src/main/java/folder1/folder2/File.java

Shows only one last commit and doesn=E2=80=99t show the history when th=
e file
was in source folder. Same thing happens with

$ git log =E2=80=93C =C2=A0-- src/main/java/folder1/folder2/File.java

What gives?

Thanks,
Eugene
