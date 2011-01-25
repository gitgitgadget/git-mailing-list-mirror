From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: Can't find the revelant commit with git-log
Date: Tue, 25 Jan 2011 18:44:49 +0100
Message-ID: <m2ipxc27zi.fsf@gmail.com>
References: <m2ipxd2w78.fsf@gmail.com> <4D3EF650.20407@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Jan 25 18:45:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Phmwy-0004De-76
	for gcvg-git-2@lo.gmane.org; Tue, 25 Jan 2011 18:45:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752610Ab1AYRo6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Jan 2011 12:44:58 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:52132 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751508Ab1AYRo5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Jan 2011 12:44:57 -0500
Received: by wyb28 with SMTP id 28so34979wyb.19
        for <git@vger.kernel.org>; Tue, 25 Jan 2011 09:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:references:mail-followup-to
         :date:in-reply-to:message-id:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=RBJa93lyXKUNv3svMsQghje5DiwDCnQahRfu133qZTQ=;
        b=TZRfLLnD3CoLo0u4Zx9yLM5o93gv/YDP3nUsJynNijyRaJhdpTDYYtcSxJvn8eXFQR
         sW/v6u7VWFV+BOT+fq4+P1V1lawCQVplrkKkX1nkWvQpExmTAyvvHM7iMAKNBXTfTsui
         OKIso1KPQYnbEAnOQAs1cV586wyzgJRFKfjtM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:references:mail-followup-to:date:in-reply-to
         :message-id:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=bH6oCcInn3S4wZxETPikx+aHO+BxwtWWtQZS7GiWT2GtHbWW0tTdPGvMMPboMAvXbR
         WSR5h06nT1TlA6soMiLbYoekxlNqzCmN5d5vEUFo+LWd31at8y9Ot15nZQwYAKwqJuCC
         ASbJnJhh18suXyI2tDYIzqoMc7dC6g1dnpCbk=
Received: by 10.227.155.73 with SMTP id r9mr4847403wbw.63.1295977496540;
        Tue, 25 Jan 2011 09:44:56 -0800 (PST)
Received: from localhost (au213-1-82-235-205-153.fbx.proxad.net [82.235.205.153])
        by mx.google.com with ESMTPS id y29sm5145898wbd.10.2011.01.25.09.44.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 25 Jan 2011 09:44:54 -0800 (PST)
Mail-Followup-To: =?iso-8859-1?Q?Ren=E9?= Scharfe
 <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
In-Reply-To: <4D3EF650.20407@lsrfire.ath.cx> (=?iso-8859-1?Q?=22Ren=E9?=
 Scharfe"'s message of
	"Tue, 25 Jan 2011 17:12:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165482>

Ren=E9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Am 25.01.2011 10:01, schrieb Francis Moreau:
>>
>> The project is the Linux kernel, and I'm trying to look for changes
>> which happened between v2.6.27 and v2.6.28. The changes happened in =
the
>> following file: drivers/pci/intel-iommu.c where a function has been
>> removed:
>>=20
>>    $ git --version
>>    git version 1.7.4.rc3
>>=20
>>    $ cd ~/linux-2.6/drivers/pci/
>>    $ git grep blacklist v2.6.27 -- drivers/pci/intel-iommu.c
>>    $
>>=20
>> No ouput... hmm, I know it's in... oh maybe the path is incorrect
>>=20
>>    $ git git grep blacklist v2.6.27 -- intel-iommu.c
>>    v2.6.27:intel-iommu.c:static int blacklist_iommu(const struct dmi=
_system_id *id)
>>    v2.6.27:intel-iommu.c:          .callback =3D blacklist_iommu,
>>=20
>> ah, so Git failed previously without any comments on the wrong
>> path... maybe it should ?
>
> Good idea.
>

Actually I _think_ I encoutered this behaviour for other commands as we=
ll,
like git-show or git-log, I don't remember.

>
>> So at that point I know that in the revision v2.6.27, there's a func=
tion
>> called "blacklist_iommu" in drivers/pci/intel-iommu.c
>>=20
>> Now take a look if it's still there in v2.6.28:
>>=20
>>    $ git git grep blacklist v2.6.28 -- intel-iommu.c
>>    $
>>=20
>> This time nothing is printed but I know that the command is correct.
>>=20
>> So now I'm interested in looking for the commit which removed this
>> function. Fo this I'm trying to use git-log(1):
>>=20
>>    $ git log --full-history --follow -S'static int blacklist_iommu(c=
onst struct dmi_system_id *id)' v2.6.27..v2.6.28 -- intel-iommu.c
>>    $ echo $?
>>    0
>>=20
>> I tried different options but it fails.
>>=20
>> Also I found that passing the exact string to '-S' is annoying, are
>> there any way to just pass a part of the string such as
>> "-Sblacklist_iommu" ?
>
> This (-Sblacklist_iommu) works for me.
>

Hmm, I thought I tried this and it didn't work, but that's obviously
wrong.

>
>> Sorry if I miss the revelant git-log's option, but there're so many.=
=2E.
>
> Try -m (show full diff for merge commits), as the change you're looki=
ng
> for seems to have been introduced by a merge, not a regular commit.
>
> 	$ opts=3D"--stat -Sblacklist_iommu -m --oneline"
> 	$ revs=3D"v2.6.27..v2.6.28"
>
> 	$ git log $opts $revs -- drivers/pci/intel-iommu.c
>
> This returns nothing.  Hmm.  Let's try this instead:
>
> 	$ git log $opts $revs -- drivers/pci/
> 	057316c (from 3e2dab9) Merge branch 'linus' into test
> 	 drivers/pci/intel-iommu.c |  307 ++++++++++++++++++++--------------=
----------
> 	 1 files changed, 140 insertions(+), 167 deletions(-)
> 	6b2ada8 (from 3b7ecb5) Merge branches 'core/softlockup', 'core/softi=
rq', 'core/resources', 'core/printk' and 'core/misc' into core-v28-for-=
linus
> 	 drivers/pci/intel-iommu.c |  187 ++++++----------------------------=
----------
> 	 1 files changed, 26 insertions(+), 161 deletions(-)
> 	d847059 (from 725c258) Merge branch 'x86/apic' into x86-v28-for-linu=
s-phase4-B
> 	 drivers/pci/intel-iommu.c |  185 ++++++----------------------------=
-----------
> 	 1 files changed, 25 insertions(+), 160 deletions(-)
> 	725c258 (from 129d6ab) Merge branches 'core/iommu', 'x86/amd-iommu' =
and 'x86/iommu' into x86-v28-for-linus-phase3-B
> 	 drivers/pci/intel-iommu.c |   25 ++++++++++++++++++++++++-
> 	 1 files changed, 24 insertions(+), 1 deletions(-)
> 	6e03f99 (from 9821626) Merge branch 'linus' into x86/iommu
> 	 drivers/pci/intel-iommu.c |   23 +++++++++++++++++++++++
> 	 1 files changed, 23 insertions(+), 0 deletions(-)
>
> Strange, why did we need to remove the last path component to get the=
se
> results which say that exactly the file we previously specified was c=
hanged?

ah... I think I've been hit by this, since I tried '-m' too but see
nothing and was not smart enough to remove the filename from the path.

> Also interesting, and matching the above results in that we see the n=
eed for
> the -m flag confirmed:
>
> 	$ for merge in 057316c 6b2ada8 d847059 725c258 6e03f99
> 	do
> 		a=3D$(git show $merge | grep -c blacklist_iommu)
> 		b=3D$(git show -m $merge | grep -c blacklist_iommu)
> 		echo $merge $a $b
> 	done
> 	057316c 0 2
> 	6b2ada8 0 2
> 	d847059 0 2
> 	725c258 0 2
> 	6e03f99 0 2
>
> IAW: the combined diff for the five found merges doesn't show any cha=
nges to
> a line containing the string "blacklist_iommu", but the full diffs do=
=2E
>
> Let's check for the presence of the string in the merge results and t=
heir
> parents:
>
> 	$ for merge in 057316c 6b2ada8 d847059 725c258 6e03f99
> 	  do
> 		for rev in $(git show $merge | grep ^Merge:)
> 		do
> 			t=3Dparent
> 			case $rev in
> 			Merge:)
> 				echo
> 				rev=3D$merge
> 				t=3Dmerge
> 				;;
> 			esac
> 			if git grep -q blacklist_iommu $rev -- drivers/pci/
> 			then
> 				echo "$t $rev: found"
> 			else
> 				echo "$t $rev: not found"
> 			fi
> 		done
> 	done
>
> 	merge 057316c: not found
> 	parent 3e2dab9: found
> 	parent 2515ddc: not found
> =09
> 	merge 6b2ada8: not found
> 	parent 278429c: not found
> 	parent 3b7ecb5: found
> 	parent 77af7e3: not found
> 	parent 1516071: not found
> 	parent 1fa63a8: not found
> 	parent 8546232: not found
> =09
> 	merge d847059: not found
> 	parent 725c258: found
> 	parent 11494547: not found
> =09
> 	merge 725c258: found
> 	parent 3dd392a: found
> 	parent 72d3105: found
> 	parent 129d6ab: not found
> 	parent 1e19b16: found
> =09
> 	merge 6e03f99: found
> 	parent 9821626: not found
> 	parent 6bfb09a: found
>
> Hmm, seems like the function is gone since d847059.  Does all of this=
 help
> you in any way?

Yes it does, but one question I'm wondering is: is it possible to do
this more user friendly ? ;)

Thanks
--=20
=46rancis
