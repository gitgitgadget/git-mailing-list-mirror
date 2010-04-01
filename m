From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: Are the patches used to build git on cygwin available in a git 
	repo somewhere?
Date: Fri, 2 Apr 2010 10:41:32 +1100
Message-ID: <x2p2cfc40321004011641s9964449cq4143021d0df63d07@mail.gmail.com>
References: <2cfc40321003300916o305e4c15x7850549beafc26c0@mail.gmail.com>
	 <20100331025626.GA13501@progeny.tock>
	 <20100331025856.GB13501@progeny.tock>
	 <o2p2cfc40321003310055i4b26d46l29ac6113be9eb980@mail.gmail.com>
	 <20100401023526.GA20916@progeny.tock> <4BB50925.9070006@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramsay Allan Jones <ramsay@ramsay1.demon.co.uk>,
	Dmitry Potapov <dpotapov@gmail.com>
To: Eric Blake <eblake@redhat.com>
X-From: git-owner@vger.kernel.org Fri Apr 02 01:41:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxU16-000126-9J
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 01:41:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758924Ab0DAXlf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Apr 2010 19:41:35 -0400
Received: from mail-pz0-f196.google.com ([209.85.222.196]:51431 "EHLO
	mail-pz0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753255Ab0DAXld convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Apr 2010 19:41:33 -0400
Received: by pzk34 with SMTP id 34so1577066pzk.20
        for <git@vger.kernel.org>; Thu, 01 Apr 2010 16:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=NN3RCMRE0a5DnYIE05ewm7p0hu74E7UsfrH560VBlnE=;
        b=HskykcnYnN2abOXCWfLjtlDb8Q0IbxLJ9PIIJ+ak63Bw3Do7XyG2lZZemnwhVOlclV
         K5ll9d9qWtnlVRVrk/e/pHro2wJbNDABzwf+vvCtpBr4EATX6e59ZVsBlv4UZAX8fTX4
         qL6X27LcDJm2T+0s1WnZtxd76yRSUvb4e1Gz0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=TJhS8eEmN9QkyJorV5MO8YdRWP0+asbt2V5j4gtIzb47jaVgCY00/Bfsl+yW2SkL/N
         OKn98cBjKxKUJTFvfOYcqhUbz5OviJjjo6cbO74IGCsXptMTok54JRLHXqI9119cheIW
         kBqQLP5tVAvQ6mH1hJMBca6XQ5ZqKAmt/sNEA=
Received: by 10.114.13.5 with HTTP; Thu, 1 Apr 2010 16:41:32 -0700 (PDT)
In-Reply-To: <4BB50925.9070006@redhat.com>
Received: by 10.114.215.30 with SMTP id n30mr1928168wag.27.1270165292667; Thu, 
	01 Apr 2010 16:41:32 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143760>

Eric,

Just in case it helps, I have taken the cygwin-1.6.6.1-1 patches and
split them up according to the discussions in this note and published
them as a tag (v1.6.6.1.cygwin-patch) in my fork of the github git/git
repo.

      git://github.com/jonseymour/git.git

=46eel free to clone this and do with it as you will.

If there any interest, I can post them to the list as patches, but I
figured it would probably be less confusing if Eric did that himself,
should that be required, especially since he has already started a new
series.

jon.

On Fri, Apr 2, 2010 at 7:59 AM, Eric Blake <eblake@redhat.com> wrote:
> On 03/31/2010 08:35 PM, Jonathan Nieder wrote:
>> I just fetched the packaging.
>>
>> =C2=A0 http://mirror.mcs.anl.gov/cygwin/release/git/git-1.6.6.1-1-sr=
c.tar.bz2
>>
>> gitk - work around stderr redirection on Cygwin
>>
>> =C2=A0 The description of this patch suggests it is meant to work ar=
ound
>> =C2=A0 the old Tcl/Tk version. =C2=A0In that case, maybe stock gitk =
should learn
>> =C2=A0 a workaround. =C2=A0I don=E2=80=99t think it is supposed to r=
equire more recent
>> =C2=A0 Tcl/Tk than 8.4.
>>
>> =C2=A0 Unfortunately, I cannot find a relevant changelog entry. =C2=A0=
Maybe
>> =C2=A0 this is a Windows-specific bug? =C2=A0http://wiki.tcl.tk/2620
>> =C2=A0 describes a similar problem.
>
> More of a problem of the fact that cygwin tcl is _still_ stuck with a
> bastardized implementation that is not quite a true cygwin app, and
> therefore doesn't handle file redirections as gracefully as it could.
> Mark Levedahl proposed the patch upstream on 14 Jun 2008, but it was
> never accepted.
> http://marc.info/?t=3D121346288300001&r=3D1&w=3D2
>
>>
>> gitk - convert gitk-path to Windows if on Cygwin
>>
>> =C2=A0 This patch seems reasonable, and it only affects Cygwin. =C2=A0=
I think it
>> =C2=A0 looks reasonable for inclusion in stock gitk, though others m=
ight
>> =C2=A0 disagree.
>
> OK, I'll find time to re-submit it upstream. =C2=A0 It was modified f=
rom this
> original post, also by Mark Levedahl:
> http://marc.info/?l=3Dgit&m=3D121349005001446&w=3D2
>
>>
>> Documentation/Makefile
>>
>> =C2=A0 Adds --unsafe to the asciidoc command line. =C2=A0Why?
>
> Because VPATH builds of the documentation make asciidoc fail otherwis=
e,
> due to a complaint about an unsafe use of ../ referencing to find the
> source dir outside of the build dir.
>
>>
>> Makefile
>>
>> =C2=A0 Stops disabling so many features, since Cygwin has come a lon=
g way.
>> =C2=A0 This looks worth applying upstream. =C2=A0The conservative th=
ing to do
>> =C2=A0 would be to test $(uname -r), but since it is easy to bring a
>> =C2=A0 Cygwin installation up to date and hard to figure out the app=
ropriate
>> =C2=A0 versions, it might make sense to make this change uncondition=
ally.
>
> Most of those defaults cater to cygwin 1.5, which was released severa=
l
> years ago. =C2=A0Cygwin 1.7 is the only supported version now, but it=
 was
> only released late 2009. =C2=A0I'll try to find time to submit the
> less-controversial of these upstream.
>
>>
>> =C2=A0 A worrisome one is NO_MMAP. =C2=A0Was that problem ever under=
stood? =C2=A0Maybe
>> =C2=A0 v1.6.3-rc0~133 (MinGW: implement mmap, 2009-03-13) contains s=
ome clues
>> =C2=A0 (just a hope). =C2=A0The message for v1.5.0-rc1~182 (Set NO_M=
MAP for Cygwin
>> =C2=A0 by default, 2006-12-27) indicates that it=E2=80=99s filesyste=
m-specific,
>
> No one has ever demonstrated to me why NO_MMAP was needed on cygwin.
> I'd rather get mmap fixed on cygwin, if it really is a bug (and if it
> still exists; it is highly likely that the bug was against 1.5 but ha=
s
> been fixed in the meantime).
>
>>
>> Makefile: all:: perl/perl.mak
>>
>> =C2=A0 Should be unnecessary. The scripts should pull it in already.
>
> It made a difference for me when packaging for cygwin. =C2=A0But if t=
here's a
> way to make it work without that line, I'm all ears.
>
>>
>> Makefile: setting INSTALLDIRS=3Dvendor in the perl/perl.mak target
>>
>> =C2=A0 Should be unnecessary. =C2=A0Make passes on variable settings=
 from the
>> =C2=A0 command line to submakes already.
>
> Again, I could never get it to work without this patch; but I'm all e=
ars
> if there's a better way.
>
>>
>> git-gui/Makefile:
>>
>> =C2=A0 Change to Cygwin-specific part. =C2=A0Probably applicable ups=
tream.
>
> OK, I'll try and find time to send an upstream patch submission.
>
> Meanwhile, I'm trying to package git 1.7.0.4 for cygwin, so this is a
> good chance to review all of those patches in the cygwin port.
>
> --
> Eric Blake =C2=A0 eblake@redhat.com =C2=A0 =C2=A0+1-801-349-2682
> Libvirt virtualization library http://libvirt.org
>
>
