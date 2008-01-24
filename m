From: Mitch Tishmack <mitcht.git@gmail.com>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Thu, 24 Jan 2008 12:17:05 -0600
Message-ID: <2C31D645-2BB3-4832-BA46-47B441F530EC@gmail.com>
References: <34103945-2078-4983-B409-2D01EF071A8B@sb.org> <alpine.LFD.1.00.0801230808440.1741@woody.linux-foundation.org> <98F90EB6-1930-4643-8C6C-CA11CB123BAA@sb.org> <76718490801231218i53c19e22lda34f2eec88627f8@mail.gmail.com> <1DC841ED-634F-412C-9560-F37E4172A4CD@sb.org> <76718490801231421l7b6552f8sec13f570360198b@mail.gmail.com> <4F906435-A186-4E98-8865-F185D75F14D4@sb.org> <76718490801231517h6d57e5bfkc19d394d38ad19db@mail.gmail.com> <DE7B2DE6-03B1-4781-92C7-096E591369A1@sb.org> <7vk5lzc3yr.fsf@gitster.siamese.dyndns.org> <46a038f90801232037t76e103edt1585d49b2ed19862@mail.gmail.com> <C3E61435-AAF8-4F30-ACD6-B083165B5441@sb.org> <DADD259A-504E-4D98-9C26-5CD9B35B59C1@zib.de>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kevin Ballard <kevin@sb.org>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Jay Soffian" <jaysoffian@gmail.com>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Theodore Tso" <tytso@mit.edu>, "Mike Hommey" <mh@glandium.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Thu Jan 24 19:18:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JI6eg-0007BZ-Gr
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 19:18:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753469AbYAXSR4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jan 2008 13:17:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752549AbYAXSRz
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 13:17:55 -0500
Received: from wr-out-0506.google.com ([64.233.184.225]:50153 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753469AbYAXSRy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Jan 2008 13:17:54 -0500
Received: by wr-out-0506.google.com with SMTP id c49so161110wra.1
        for <git@vger.kernel.org>; Thu, 24 Jan 2008 10:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to:in-reply-to:content-type:content-transfer-encoding:mime-version:subject:date:references:x-mailer;
        bh=CE9eGfKGqmDn4vqy3DhSYDrqRi+6PYXoDpKt3wSkOZQ=;
        b=VarKufSF0ZIDswN1f5NsAMzPjsYVZroUqyyaTuG3KJ5zdafk2XpDUGIbucjkbxgVFuZvDYtAhdR9JAsewWA7XfVOvNPDOORsrVRhvbTiQ3AoUiP637XoBQP8N03/J/8TGeasv6UzqcubrNo/oi7pgkCJXzeGuNe0oVmVEnwBlqA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type:content-transfer-encoding:mime-version:subject:date:references:x-mailer;
        b=pDiKfks41RiCpykTbXPuDO+kmioqm9hRWf+fxM1N3NSNwMT5R4npzaOvydjT84mbx7mCm1xScHax921aAzJnl79mwMhMT16wsjBB1SLjq1Rk9yCr/kX5qqu2RuKotjz/1Kkteh/Um/sI9NnCpdXzH6VCjtaiXbvP3vfW62SBQXo=
Received: by 10.142.76.4 with SMTP id y4mr599220wfa.31.1201198671928;
        Thu, 24 Jan 2008 10:17:51 -0800 (PST)
Received: from ?192.168.3.124? ( [71.216.112.176])
        by mx.google.com with ESMTPS id i38sm788531wxd.16.2008.01.24.10.17.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 24 Jan 2008 10:17:50 -0800 (PST)
In-Reply-To: <DADD259A-504E-4D98-9C26-5CD9B35B59C1@zib.de>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71641>

Here is a start maybe, I was just testing all of the HFS variants for =20
fun. I will write up a test case later tonight when I am out  done =20
with work.

#!/bin/sh
#
# Test git behavior on OSX's multitudes of HFS types
# So far UFS, HFS, HFS+, HFSX, HFS+J, UFS is the only sane FS =20
available...
#

#cloneurl=3D"git://git.kernel.org/pub/scm/git/git.git"
cloneurl=3D"/Volumes/gitufs/git"
ramdiskdir=3D"/private/tmp/gitramdisk"
results=3D"/private/tmp/fsresults"

echo "Creating 100M UFS ramdisk for clone operation."
rawdev=3D`hdid -nomount ram://102400`
newfs $rawdev > /dev/null 2>&1
mkdir $ramdiskdir > /dev/null 2>&1
mount -t ufs $rawdev $ramdiskdir > /dev/null 2>&1
cd $ramdiskdir && git clone $cloneurl > /dev/null 2>&1
cd $ramdiskdir/git
if [ -f $results ] ; then
   echo "Removing old results."
   rm $results
fi

echo "Creating HFS image"
hdiutil create -size 50m -fs HFS -attach -volname "hfs" /tmp/hfs.dmg =20
 > /dev/null 2>&1
echo "Creating HFS+ image"
hdiutil create -size 50m -fs HFS+ -attach -volname "hfsplus" /tmp/=20
hfsplus.d > /dev/null 2>&1
echo "Creating HFS+J image"
hdiutil create -size 50m -fs HFS+J -attach -volname "hfsplusJ" /tmp/=20
hfsplusjournal.dmg > /dev/null 2>&1
echo "Creating HFSX image"
hdiutil create -size 50m -fs HFSX -attach -volname "hfsx" /tmp/=20
hfsx.dmg > /dev/null 2>&1
echo "Creating UFS image"
hdiutil create -size 50m -fs UFS -attach -volname "hfsu" /tmp/hfsu.dmg =
=20
 > /dev/null 2>&1

for x in `ls -d /Volumes/hfs*`;do
   echo "Testing $x clone."
   echo "Results for $x:" >> $results
   (echo "-- git clone results --" && cd ${x} && /usr/bin/time git =20
clone $ramdiskdir/git) >> $results 2>&1
   (echo "-- git status results --" && cd ${x}/git && /usr/bin/time =20
git status) >> $results 2>&1
   cd ${x} && perl -CO -e 'print pack("U",0x00E4)."\n"' | xargs touch =20
# umlauted a
   cd ${x} && perl -CO -e 'print pack("U",0x0061).pack("U",=20
0x0308)."\n"' | xargs touch # umlauted a by combining diareses
   ls -d ${x}/* | xxd >> $results
   cd && hdiutil eject ${x} > /dev/null 2>&1
done

# cleanup
cd $HOME
umount -f $ramdiskdir > /dev/null 2>&1
hdiutil detach $rawdev > /dev/null 2>&1
rm -Rf $ramdiskdir /tmp/hfs*.dmg
more $results

My results on leopard:
$ cat /tmp/fsresults
Results for /Volumes/hfs:
-- git clone results --
Initialized empty Git repository in /Volumes/hfs/git/.git/
cpio: Unable to create /Volumes/hfs/git/.git/objects/pack/=20
pack-06100ef5fbd98d07358505696e2e0c5600a9b279.pack: Invalid argument
cpio: Unable to create /Volumes/hfs/git/.git/objects/pack/=20
pack-06100ef5fbd98d07358505696e2e0c5600a9b279.idx: Invalid argument
cpio: Unable to create /Volumes/hfs/git/.git/objects/pack/=20
pack-401a5ae571eb23ec896d7e441deae4e313d0de9c.pack: Invalid argument
cpio: Unable to create /Volumes/hfs/git/.git/objects/pack/pack-=20
ab8844b63fcb4fc5896e9d75b0d10c566d5ce5bb.pack: Invalid argument
cpio: Unable to create /Volumes/hfs/git/.git/objects/pack/pack-=20
ab8844b63fcb4fc5896e9d75b0d10c566d5ce5bb.idx: Invalid argument
cpio: Unable to create /Volumes/hfs/git/.git/objects/pack/=20
pack-9ffbf58084280a496aef6849fe3effe742a99d77.pack: Invalid argument
cpio: Unable to create /Volumes/hfs/git/.git/objects/pack/=20
pack-9ffbf58084280a496aef6849fe3effe742a99d77.idx: Invalid argument
cpio: Unable to create /Volumes/hfs/git/.git/objects/pack/=20
pack-401a5ae571eb23ec896d7e441deae4e313d0de9c.idx: Invalid argument
cpio: Unable to create /Volumes/hfs/git/.git/objects/=20
03/4ee24912da0a700ba27109825710fd84d64591: Invalid argument
         0.20 real         0.02 user         0.05 sys
-- git status results --
git_fs.sh: line 39: cd: /Volumes/hfs/git: No such file or directory
0000000: 2f56 6f6c 756d 6573 2f68 6673 2f61 cc88  /Volumes/hfs/a..
0000010: 0a                                       .
Results for /Volumes/hfsplus:
-- git clone results --
Initialized empty Git repository in /Volumes/hfsplus/git/.git/
         2.56 real         0.47 user         0.94 sys
-- git status results --
# On branch master
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#	gitweb/test/M=E4rchen
nothing added to commit but untracked files present (use "git add" to =20
track)
         0.46 real         0.27 user         0.08 sys
0000000: 2f56 6f6c 756d 6573 2f68 6673 706c 7573  /Volumes/hfsplus
0000010: 2f61 cc88 0a2f 566f 6c75 6d65 732f 6866  /a.../Volumes/hf
0000020: 7370 6c75 732f 6769 740a                 splus/git.
Results for /Volumes/hfsplusJ:
-- git clone results --
Initialized empty Git repository in /Volumes/hfsplusJ/git/.git/
         2.29 real         0.45 user         0.91 sys
-- git status results --
# On branch master
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#	gitweb/test/M=E4rchen
nothing added to commit but untracked files present (use "git add" to =20
track)
         0.57 real         0.31 user         0.10 sys
0000000: 2f56 6f6c 756d 6573 2f68 6673 706c 7573  /Volumes/hfsplus
0000010: 4a2f 61cc 880a 2f56 6f6c 756d 6573 2f68  J/a.../Volumes/h
0000020: 6673 706c 7573 4a2f 6769 740a            fsplusJ/git.
Results for /Volumes/hfsu:
-- git clone results --
Initialized empty Git repository in /Volumes/hfsu/git/.git/
         5.08 real         0.48 user         0.94 sys
-- git status results --
# On branch master
nothing to commit (working directory clean)
         0.26 real         0.20 user         0.05 sys
0000000: 2f56 6f6c 756d 6573 2f68 6673 752f 61cc  /Volumes/hfsu/a.
0000010: 880a 2f56 6f6c 756d 6573 2f68 6673 752f  ../Volumes/hfsu/
0000020: 6769 740a 2f56 6f6c 756d 6573 2f68 6673  git./Volumes/hfs
0000030: 752f c3a4 0a                             u/...
Results for /Volumes/hfsx:
-- git clone results --
Initialized empty Git repository in /Volumes/hfsx/git/.git/
         2.49 real         0.46 user         0.88 sys
-- git status results --
# On branch master
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#	gitweb/test/M=E4rchen
nothing added to commit but untracked files present (use "git add" to =20
track)
         0.25 real         0.20 user         0.04 sys
0000000: 2f56 6f6c 756d 6573 2f68 6673 782f 61cc  /Volumes/hfsx/a.
0000010: 880a 2f56 6f6c 756d 6573 2f68 6673 782f  ../Volumes/hfsx/
0000020: 6769 740a                                git.


On Jan 24, 2008, at 12:39 AM, Steffen Prohaska wrote:

>
> On Jan 24, 2008, at 6:30 AM, Kevin Ballard wrote:
>
>> On Jan 23, 2008, at 11:37 PM, Martin Langhoff wrote:
>>
>>> Kevin, other people have already started posting nice nuggets of =20
>>> test
>>> cases. Where are *your* test cases? That would be a nice way to =20
>>> "have
>>> the last word" on this ;-)
>>
>>
>> I'm planning on devoting time this weekend to learning enough about =
=20
>> git to be able to start hacking. I'm just too busy during the week =20
>> to be able to devote the dedicated time necessary to this stuff. =20
>> Hopefully I'll actually be able to start producing stuff this =20
>> weekend.
>
> You do not need to learn much about git to post a test case.
> Only a few lines of shell code that demonstrate how git fails to
> handle a specific situation is needed.  To do this, knowledge
> about the internals of git does not necessary help.  It should be
> sufficient to know how to use git.
>
> You may start with a simple shell script and send it to the list.
> Though, a real patch would be the preferred way.  For this, you
> should have a quick look into the t/ subdirectory.  Just open any
> of the tNUMBER*.sh files.  It should be quite obvious how your
> sequence of shell commands could be cast into a git test script.
>
> 	Steffen
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
