From: Eugene Sajine <euguess@gmail.com>
Subject: Re: Folder level Acces in git
Date: Fri, 4 Nov 2011 11:59:28 -0400
Message-ID: <CAPZPVFZwW1VF2qb8YVQjBixRzZgz+HSz6NjJBUimuC-nx7LwZQ@mail.gmail.com>
References: <1320300655224-6958047.post@n2.nabble.com>
	<CAPZPVFY15AqCpWcRbv0tjXBz4G2kQTm+nMGpsYzCKe0niHV_dA@mail.gmail.com>
	<4EB36855.8000802@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: redhat1981 <redhat1981@gmail.com>, git@vger.kernel.org
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Fri Nov 04 16:59:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMMB3-0008NU-RE
	for gcvg-git-2@lo.gmane.org; Fri, 04 Nov 2011 16:59:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755841Ab1KDP73 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Nov 2011 11:59:29 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:50620 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755241Ab1KDP73 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Nov 2011 11:59:29 -0400
Received: by iage36 with SMTP id e36so2692985iag.19
        for <git@vger.kernel.org>; Fri, 04 Nov 2011 08:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=tUB8Zl4u+UMu8em9fVr8tjXJ01HoJO/RWUR6j8i0pCs=;
        b=t9Fy/TP+8Te++H+T+vFtvTRk4tW4mICqx7pMe1myFjztC61WutyH4KoQjlGE5/fEI8
         DQJegGovY6oCUgLsx74ny/EtHSxiJJLt4zgbNqxlPay6B+RPyiBSNWdxm7eo3ZZ7B7Xm
         Afc3+5ls1Dq6xMieAqeThf77IAIEhr54aV6L0=
Received: by 10.231.0.208 with SMTP id 16mr3848836ibc.50.1320422368386; Fri,
 04 Nov 2011 08:59:28 -0700 (PDT)
Received: by 10.231.103.6 with HTTP; Fri, 4 Nov 2011 08:59:28 -0700 (PDT)
In-Reply-To: <4EB36855.8000802@workspacewhiz.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184783>

On Fri, Nov 4, 2011 at 12:21 AM, Joshua Jensen
<jjensen@workspacewhiz.com> wrote:
> ----- Original Message -----
> From: Eugene Sajine
> Date: 11/3/2011 1:28 PM
>>
>> Are you sure that the way your have organized the repository is
>> actually correct? If you need to manage the access on folder level w=
hy
>> don't you simply split up the project into several
>> repositories/projects which each team is going to work with
>> independently?
>>
>> This seems to me to be much simpler and cleaner solution then any
>> other alternative.
>>
> Submodules are _not_ simple at all. =C2=A0Our organization of nearly =
100
> developers using Git pretty much let out a collective cheer when we f=
inally
> removed the submodules. =C2=A0Submodules are an absolute pain to deve=
lop within;
> there are a number of Git mailing list exchanges about that, but I'd =
be
> happy to go into great detail if anybody cares. =C2=A0Even submodules=
 that are
> read-only are a pain as it takes two steps (git pull + git submodule =
update)
> to actually get them up to date.
>
> Ick.
>
> In short, if it is an absolute requirement to manage access to a repo=
sitory
> on a folder level, get Subversion or Perforce. =C2=A0DVCS is not for =
you...
>
> Josh
>

That is exactly what i wanted to say. I suggest OP not to go into
submodules, but just have separate repositories. I think if they need
this kind of granularity in permissions it means that their repository
is too big and incorrectly organized. I think they are trying to
migrate to better VCS (as git is superior by definition;) ), but they
still think in central VCS terms and that's what causing this folder
level management requirement to appear. We  at $work have hundreds of
repositories and never had any need of submodules or folder level
permissions. (One repo =3D one project =3D one artifact) + Ivy as
dependency manager works just fine and if we will need to fine tune
the permissions it will be always pretty easy to do.


Thanks,
Eugene
