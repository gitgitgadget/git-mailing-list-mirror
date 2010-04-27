From: Dmitrijs Ledkovs <dmitrij.ledkov@ubuntu.com>
Subject: Re: RFD: git-bzr: anyone interested?
Date: Tue, 27 Apr 2010 09:47:53 +0100
Message-ID: <q2j86ecb3c71004270147le799967dw579964600be84066@mail.gmail.com>
References: <4B7D8358.1080108@gmail.com> <fabb9a1e1002181037n58d6942dpa63a57a23f506d9c@mail.gmail.com> 
	<4B7E3856.3080609@gmail.com> <20100219135549.GA31796@Knoppix> 
	<4B820B4E.7050405@gmail.com> <20100222105133.GA10577@Knoppix> 
	<4B834989.50502@gmail.com> <20100223124553.GA19153@Knoppix> 
	<p2ka038bef51004261441x7e4857f1mc3f03a4104f8e018@mail.gmail.com> 
	<4BD651C6.5050501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Chris Packham <judge.packham@gmail.com>, git@vger.kernel.org
To: Gabriel Filion <lelutin@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 27 10:48:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6gSr-0003N5-Lm
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 10:48:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752561Ab0D0IsP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Apr 2010 04:48:15 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:35303 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085Ab0D0IsO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Apr 2010 04:48:14 -0400
Received: by pxi17 with SMTP id 17so2054809pxi.19
        for <git@vger.kernel.org>; Tue, 27 Apr 2010 01:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received
         :in-reply-to:references:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=1aAmYyClrVlxQ84aplg0bJsuRhmqf+lvwW1yOzZZbY8=;
        b=hP8xsaTfzwrWHd1ubPeIIJKNI+k43je75SjAzXBmRi5f4NIE/q3kZXXbn/8wbAkMMv
         PdM3Uv27Un8gsx2Nq/oXtSDt7ebSz5u+R0P8QmcfovpxeDggnaysNHUZH7qwvz/UWBBC
         Kxm+48J5FNwgQdI910JfOo01pMwS7UDAQYl5k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=ukRfWRiV3gWoCOftVQ14Zx9ROWrosa4QtvPrVfb7BgUwhMxgsQ7HC2zS/BKIQotrqO
         823s9YtR26eYUxMdOJBAkWtpLhSdkjcoTuV5MJSOlAtejnZyucvTqsPmLpY2ezXgrP3b
         JfGkB4Tq5Tm9443R5MDsSHTgcbHktxLPfhHeU=
Received: by 10.142.5.28 with SMTP id 28mr2617115wfe.205.1272358093087; Tue, 
	27 Apr 2010 01:48:13 -0700 (PDT)
Received: by 10.142.188.15 with HTTP; Tue, 27 Apr 2010 01:47:53 -0700 (PDT)
In-Reply-To: <4BD651C6.5050501@gmail.com>
X-Google-Sender-Auth: 0bf5b37701303cf3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145884>

On 27 April 2010 03:53, Gabriel Filion <lelutin@gmail.com> wrote:
> Hello,
>
> On 2010-04-26 17:41, Chris Packham wrote:
>> How far did git-bzr or git-remote-bzr get?
>>
>
> I unfortunately haven't had much time to fiddle with this. Having a f=
ull
> time job doesn't give me much space for experiences :( And on my free
> time, I've been a bit busy with one of my projects..
>
>
> I've tried simply "plugging in" the bzr-fastimport plugin to do the
> communication part. They already implement output similar to what
> git-fastimport expects. I was stuck on the part where you have to
> specify "marks" files, and about where to place them, so I left it th=
ere
> for now.
>

Except that bzr-fast-export -> bzr-fast-import will produce similar
history but all revision ids will be different so you will not be able
to merge in bzr after you worked in git =3D/ so it will be read-only.
Marks files are used when you want to import multiple related bzr
branches into a git repo. So in general case you will not need it =3D)

> I'll try and work on this pretty soon, but since I'm doing this on sp=
are
> time, any help would be welcome. Maybe the good thing to do would be =
to
> put up a page somewhere with a mini-roadmap and the info needed/the i=
nfo
> that was found out?
> By using bzr fast-import, the whole thing shouldn't take too long.
>
>> I've tried git-bzr from the repo and I seem to be stumbling on bzr n=
ot
>> having the fast-export command after I install the fast-import plugi=
n
>> as per [1].
>
>> [1] http://github.com/kfish/git-bzr/blob/master/README
>
> This script needs you to install bazaar and the bzr "fast-import"
> plugin. Normally the fast-export command is implemented by it. You ne=
ed
> a rather up-to-date version, though.
> I've found this script to work mostly for pulling in changes from bzr
> into git. Pushing has proven to be from slow to non-functional.
>

Well I did this:

$ mkdir -p ~/.bazaar/plugins
$ bzr branch lp:bzr-fast-import ~/.bazaar/fast-import
$ bzr branch lp:xiphos
$ git init git-xiphos
$ cd git-xiphos
$ bzr fast-export ../xiphos | git fast-import

And the resulting git repository has master branch with tags.

>
> As for the interest in this: mine is in using only one tool to do the
> work right and not having to switch from using 3 vcs tools (the curre=
nt
> situation at work is 2 -- git and svn -- but soon bzr will come in). =
And
> for the one tool, I'd like to choose git.
> stupid reason? probably. but I've tried bzr and I don't like it.
>

Well I have my stupid reasons as well for choosing bzr for small
projects. With bzr-hg, bzr-git & bzr-svn I can work on all 4 without
doing a context switch. When I work on something big though like gcc
or binutils. Yeah git.... because of size & performance.

With bzr-* plugins though you generally get roundtrip & svn support is
excellent. On two machines bzr branch svn://URL will give identical
branches which you can merge between in bzr & svn, unlike git where
you have to use canonical import to have same SHA-1's on commits.

> --
> Gabriel Filion
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
