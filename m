From: James Blackburn <jamesblackburn@gmail.com>
Subject: Issue fetching tags error: unable to find eb03b... ; git fsck shows
 no problem...
Date: Wed, 7 Sep 2011 17:14:58 +0100
Message-ID: <CACyv8dcTi0pG_GPvxD1zoTf6iRG81KbaY43FA-pbxYJz2UVJcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 07 18:15:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1KmM-0007Q8-18
	for gcvg-git-2@lo.gmane.org; Wed, 07 Sep 2011 18:15:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755403Ab1IGQPB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Sep 2011 12:15:01 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:51703 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753772Ab1IGQPA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Sep 2011 12:15:00 -0400
Received: by vxj15 with SMTP id 15so483963vxj.19
        for <git@vger.kernel.org>; Wed, 07 Sep 2011 09:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=rtorBXU3YSZDIjJr0COtdPuni56cTTMcnN91oU68D/M=;
        b=FiHaqe6PQM2piRGZMWyH+X7Pq9dB/Ba4lOwxUH0e2rfPNWNPhtVsfhHfMQK4W5Hj7M
         izl/OphsL3spycOKbB2ki7+FmJcWsOSg/mdSeg+UJrxw8nxFUmgqUqZwGuhhtP076Uzj
         TJpuFEcgF1mPy4JgJVmjBzTqVv3Cj6pibDQ6k=
Received: by 10.220.120.12 with SMTP id b12mr1939261vcr.111.1315412098994;
 Wed, 07 Sep 2011 09:14:58 -0700 (PDT)
Received: by 10.220.202.12 with HTTP; Wed, 7 Sep 2011 09:14:58 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180860>

Hi All,

I've got an error I can't seem to resolve. Fsck reports both my
repositories are OK, but git fetch --tags tells me it can't find an
object.

bash:jamesb:xl-cbga-20:32867> git --version
git version 1.7.6
bash:jamesb:xl-cbga-20:32864> git remote add old_tags ../old_tags/
bash:jamesb:xl-cbga-20:32865> git fetch old_tags
=46rom ../old_tags
* [new branch] =A0 =A0 =A0master =A0 =A0 -> old_tags/master
=2E..
bash:jamesb:xl-cbga-20:32866> git fetch --tags old_tags
remote: Counting objects: 33613, done.
remote: Compressing objects: 100% (11778/11778), done.
remote: Total 33529 (delta 18473), reused 30013 (delta 15779)
Receiving objects: 100% (33529/33529), 28.59 MiB | 8.06 MiB/s, done.
Resolving deltas: 100% (18473/18473), completed with 17 local objects.
error: unable to find eb03ba0f40fb2b6a3287036d851d2506e4ea4f8f
fatal: object eb03ba0f40fb2b6a3287036d851d2506e4ea4f8f not found

git fsck --full shows no errors in old_tags.
git show eb03ba0f40fb2b6a3287036d851d2506e4ea4f8f in old_tags seems to =
work:

commit eb03ba0f40fb2b6a3287036d851d2506e4ea4f8f
Author: (no author) <(no author)@e3bda1c8-b8c7-484d-b8f9-8c0514bc73ff>
Date: =A0 Tue Oct 10 09:44:47 2006 +0000

=A0 =A0This commit was manufactured by cvs2svn to create tag 'releases/=
3_2_0-5'.

=A0 =A0git-svn-id: svn://eng-cbga-2/tools/eclipse/tags/releases/3_2_0-5=
@39
e3bda1c8-b8c7-484d-b8f9-8c0514bc73ff

diff --git a/org.eclipse.cdt/org.eclipse.cdt.doc.isv/reference/api/allc=
lasses-frame.html
b/org.eclipse.cdt/org.eclipse.cdt.doc.isv/reference/api/
allclasses-frame.html
=2E..


Any ideas how to resolve this?

Cheers,
James
