From: Pau Garcia i Quiles <pgquiles@elpauer.org>
Subject: Re: [PATCH 10/11] Add MSVC Project file
Date: Tue, 18 Aug 2009 00:19:38 +0200
Message-ID: <3af572ac0908171519h7b72427lba7536506d44460e@mail.gmail.com>
References: <1250525103-5184-1-git-send-email-lznuaa@gmail.com>
	 <4A899495.8050902@gnu.org>
	 <40aa078e0908171040g5718a809o88b093fe5a4a0e28@mail.gmail.com>
	 <alpine.DEB.1.00.0908172149480.8306@pacific.mpi-cbg.de>
	 <3af572ac0908171317s3ef1506fpb3df11916f8a6ee9@mail.gmail.com>
	 <3f4fd2640908171343s6e2796a8le0455e02fd8386d9@mail.gmail.com>
	 <3af572ac0908171354i6dd231etb576859ab8941214@mail.gmail.com>
	 <alpine.DEB.1.00.0908172304200.8306@pacific.mpi-cbg.de>
	 <3af572ac0908171423ye08efa8m6666ddb922d5ee92@mail.gmail.com>
	 <alpine.DEB.1.00.0908180005250.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Reece Dunn <msclrhd@googlemail.com>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Paolo Bonzini <bonzini@gnu.org>, Frank Li <lznuaa@gmail.com>,
	git@vger.kernel.org, msysgit@googlegroups.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Aug 18 00:19:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdAYX-0001O8-Sa
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 00:19:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758215AbZHQWTl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Aug 2009 18:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758179AbZHQWTk
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 18:19:40 -0400
Received: from mail-fx0-f215.google.com ([209.85.220.215]:47891 "EHLO
	mail-fx0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753403AbZHQWTj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Aug 2009 18:19:39 -0400
Received: by fxm11 with SMTP id 11so38523fxm.39
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 15:19:39 -0700 (PDT)
Received: by 10.223.101.156 with SMTP id c28mr971365fao.52.1250547578976; Mon, 
	17 Aug 2009 15:19:38 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0908180005250.8306@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126301>

On Tue, Aug 18, 2009 at 12:10 AM, Johannes
Schindelin<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Mon, 17 Aug 2009, Pau Garcia i Quiles wrote:
>
>> On Mon, Aug 17, 2009 at 11:05 PM, Johannes
>> Schindelin<Johannes.Schindelin@gmx.de> wrote:
>>
>> > You are putting an undue burden on the already overloaded maintain=
er.
>>
>> Sorry, but I'm a bit lost now. What maintainer are we talking about =
now?
>> Junio?
>
> I was talking about me, as maintainer of msysGit.
>
>> As I would be providing a turn-key CMake build system, the only burd=
en I
>> would be putting on the maintainer would be learning CMake.
>>
>> Given that I'm providing a comprehensive (100+ slides) CMake tutoria=
l
>> ( http://www.elpauer.org/stuff/learning_cmake.pdf ) , which I use in
>> my CMake workshops, I think I'm making that burden a bit lighter.
>>
>> If the next git conference is somewhere in Europe, I could also fly
>> there and we'd have a CMake tutorial, if people would feel more
>> comfortable that way.
>
> This is exactly what I mean by burden. =A0Why do I have to learn a ne=
w
> system, and suffer the hassle of integrating it into the current buil=
d
> system, which works quite well thankyouverymuch?

Because it works for every platform, including Visual C++, where a
Bourne shell is not available and where you currently need to maintain
a different built system.

> Never run a changing system.
>
>> > Well, let's see if you can provide a /src/cmake/release.sh that
>> > compiles CMake from scratch, and _then_ I'll look into CMake again=
=2E
>>
>> Again, I'm a bit lost. What '/src/cmake/release.sh' are we talking a=
bout
>> now? Would that be part of CMake or git ?
>
> Maybe this:
>
> http://article.gmane.org/gmane.comp.version-control.git/126286
>
> and this:
>
> http://repo.or.cz/w/msysgit.git?a=3Dblob;f=3Dsrc/curl/release.sh;h=3D=
d7516cbf6e92af4de138ce405d88561fbe1e92a8;hb=3D968336eddac1874c56cd934d1=
0783566af5a3e26
>
> helps.
>
> To quote myself (as you appear to have missed that):
>
> =A0 =A0 =A0 =A0Having said that, a CMake-based system _in addition_ t=
o what is
> =A0 =A0 =A0 =A0tried-and-tested to be able to support all those diffe=
rent kinds of
> =A0 =A0 =A0 =A0Microsoft Visual Studio (took me 3 attempts to write t=
hat without a
> =A0 =A0 =A0 =A0Freudian) would be welcome, _if_ you succeed in making=
 it compile out
> =A0 =A0 =A0 =A0of the box on msysGit.
>
> =A0 =A0 =A0 =A0By out-of-the-box I mean: you send a patch that adds
> =A0 =A0 =A0 =A0/src/cmake/release.sh, I apply the patch (after briefl=
y scanning
> =A0 =A0 =A0 =A0that it does not install a backdoor on a machine that =
is not even
> =A0 =A0 =A0 =A0mine, and therefore will never see even a single of my=
 passwords
> =A0 =A0 =A0 =A0typed in), run it, it compiles installs and commits cm=
ake and cmake
> =A0 =A0 =A0 =A0works.

Hmmm indeed I have missed a lot, thanks. A lot of what you had written
in other e-mails was being hidden by GMail as "quoted" text :-/

It seems we are talking about two different things here. I'm talking
about getting the CMake-based build system in git.git, you are talking
about msysgit. If getting into msysgit is the first step to getting
into git.git, I'll start from msysgit. Are the differences between
both branches so big they cannot be merged into a single branch yet ?

> Short form: if you make it easy for me, I will look at it again, if y=
ou
> make it hard on me, you will just have done to me what you now try
> to avoid yourself: wasted time.

Let's see what I can do.

--=20
Pau Garcia i Quiles
http://www.elpauer.org
(Due to my workload, I may need 10 days to answer)
