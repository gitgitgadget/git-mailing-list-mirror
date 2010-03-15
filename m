From: =?utf-8?Q?=C5=81ukasz?= Stelmach <lukasz.stelmach@iem.pw.edu.pl>
Subject: Re: merging unmanaged working tree
Date: Tue, 16 Mar 2010 00:28:11 +0100
Message-ID: <87iq8xw4fo.fsf@kotik.lan>
References: <87ljdtkedl.fsf@dasa3.iem.pw.edu.pl>
	<46a29168.6d880e7c.4b9e296c.483a1@o2.pl>
	<87d3z5k3yb.fsf@dasa3.iem.pw.edu.pl>
	<a038bef51003151258q2a4ba7dfwe84b29854c03d7eb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 16 00:28:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrJi1-0006vN-Vc
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 00:28:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937169Ab0COX2Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Mar 2010 19:28:25 -0400
Received: from lo.gmane.org ([80.91.229.12]:53298 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932564Ab0COX2Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 19:28:24 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NrJhv-0006u5-JY
	for git@vger.kernel.org; Tue, 16 Mar 2010 00:28:23 +0100
Received: from 87-205-242-55.adsl.inetia.pl ([87.205.242.55])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 16 Mar 2010 00:28:23 +0100
Received: from lukasz.stelmach by 87-205-242-55.adsl.inetia.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 16 Mar 2010 00:28:23 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 87-205-242-55.adsl.inetia.pl
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Cancel-Lock: sha1:/L4Si+qNVMF2F4PdPUsdxrbVAAQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142277>

Chris Packham <judge.packham@gmail.com> writes:

> 2010/3/15 =C5=81ukasz Stelmach <lukasz.stelmach@iem.pw.edu.pl>:
>> 1. There is a repository (non-bare one) with all changes
>> =C2=A0 commited. Commit A.
>>
>> 2. I take some files put them on my pendrive. I take a note that the=
y come
>> =C2=A0 from commit A. I don't clone the repository.
>>
>> 3. I make changes here (in the repository) and commit them (commits =
B,
>> =C2=A0 C, D) and there (on my pendrive).
>>
>> 4. I want to merge things with something like this
>>
>> $ git diff3 file1.c(D) file1.c(A) /media/project/file1.c
>>
>> * file1.c(D) is the lates version in my repository and working tree
>> * file1.c(A) is the point where I branched
>> * /media/project/file1.c is the unmanaged version of the file with c=
hanges
>> =C2=A0I made on the go.
> One option, assuming you do record "Commit A" every time you do this,
> would be to use a short lived branch to merge your changes back in.
>
> e.g.
>
> git checkout -b work_from_home <sha of commit a>
> cp /media/... .
> git status # at this point you can check that what you about to commi=
t
> is what you intended, and
> git commit -a # if it is good
> git checkout master
> git merge work_from_home # this is where any conflicts would be resol=
ved
> git branch -d work_from_home

It seems to be the most obvious and straightforward worflow.
I keep my x-bits off with proper mount options ;-)

Thanks.


--=20
Mi=C5=82ego dnia,
=C5=81ukasz Stelmach
