From: Bo Chen <chen@chenirvine.org>
Subject: Re: GSoC - Some questions on the idea of
Date: Fri, 13 Apr 2012 17:36:28 -0400
Message-ID: <CA+M5ThRJYeVgHtKjuDbpDDMUv+k33cVZkeJ887_TnsB9BHAzVg@mail.gmail.com>
References: <CA+M5ThS2iS-NMNDosk2oR25N=PMJJVTi1D=zg7MnMCUiRoX4BQ@mail.gmail.com>
	<CACsJy8APtMsMJ=FrZjOP=DbzuFoemSLJTmkjaiK5Wkq9XtA4rg@mail.gmail.com>
	<loom.20120328T131530-717@post.gmane.org>
	<CA+M5ThTPyic=RhFL2SvuNB0xBWOHxNTaUZrYMB144UjpjCiLoQ@mail.gmail.com>
	<20120330203430.GB20376@sigill.intra.peff.net>
	<CA+M5ThR6jtxqs0-Kz-8fcRuOFRbLr-GvsJcTmrOQ7_geNspDLg@mail.gmail.com>
	<4F76E430.6020605@gmail.com>
	<4F772E48.3030708@gmail.com>
	<20120402210708.GA28926@sigill.intra.peff.net>
	<4F84DD60.20903@gmail.com>
	<20120411213522.GA28199@sigill.intra.peff.net>
	<4F872D24.8010609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Sergio Callegari <sergio.callegari@gmail.com>,
	git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 13 23:36:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIoAV-00013n-VT
	for gcvg-git-2@plane.gmane.org; Fri, 13 Apr 2012 23:36:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756780Ab2DMVga convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Apr 2012 17:36:30 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:38823 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753266Ab2DMVg3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Apr 2012 17:36:29 -0400
Received: by wgbdr13 with SMTP id dr13so3419823wgb.1
        for <git@vger.kernel.org>; Fri, 13 Apr 2012 14:36:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-originating-ip:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=11i2zeWQcjmV73Ne8gb/f77nGY/b/drEYRNI/l+zA4g=;
        b=QhsNb2y/J1VBRfdt+dmbP28Gl/w45hL9e4LfQqTmcZPJrnez3QIuFv6ME726CZYPgb
         nRBSxXpeHj0Y0x6iC4vRwJJ0djx2+7guv0Xf1gK4p+3AnMZzHMz7hBIx38J9tdLK0gaL
         +YbxdQSrqh9t+6bBp1cOd2jpcxI4ANH/usStQC1UKf482ZC6JdKoA3dt60qeqpUuYadW
         medKAwnEJEZexFfJA3NfZ9nQeM6b8wJdT91Z+JiJFZyIImsJFqwwQz/dRGWlIiCI3/56
         P7T3hFuJnsu0ebp+ClbrG1rav8nAbiA5CgxBJHUfDi0I9V7y77URolPybpLNnUjaEjh2
         7Wwg==
Received: by 10.180.101.230 with SMTP id fj6mr8064017wib.13.1334352988342;
 Fri, 13 Apr 2012 14:36:28 -0700 (PDT)
Received: by 10.216.123.85 with HTTP; Fri, 13 Apr 2012 14:36:28 -0700 (PDT)
X-Originating-IP: [128.235.34.66]
In-Reply-To: <4F872D24.8010609@gmail.com>
X-Gm-Message-State: ALoCoQkN5tfQvFK0s2imnP00boeVs88lBVWQ+qGS5DQ0grQycs6C84yUglwT8DqoRR1DFj4aWblK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195447>

On Thu, Apr 12, 2012 at 3:29 PM, Neal Kreitzinger
<nkreitzinger@gmail.com> wrote:
> On 4/11/2012 4:35 PM, Jeff King wrote:
>>
>> On Tue, Apr 10, 2012 at 08:24:48PM -0500, Neal Kreitzinger wrote:
>>
>>> This is all theory to me, but the reality is looming over my head
>>> since most of the components I should be tracking are binaries smal=
l
>>> (large history?) and big (but am not yet because of "big-file"
>>> concerns -- I don't want to have to refactor my vast git ecosystem
>>> with filter branch later because I slammed binaries into the main
>>> project or superproject without proper systems programming (I'm not
>>> sure what the c/linux term is for 'systems programming', but in the
>>> mainframe world it meant making sure everything was configured for
>>> efficient performance)).
>>
>> So properly implemented, no, you would not have to ever filter-branc=
h to
>>
>> tweak these settings. You might have to do a repack to see the gains
>> (because you want to delete the old non-split representation you hav=
e in
>> your pack and replace it with a split representation), but that is
>> transparent to git's abstract data model.
>>
> I'm likely going to have to slam graphics files into the main repo in=
 the
> very near future. =A0It sounds like once git.git is updated for big-f=
ile
> optimization I can just upgrade to that git version and repack to get=
 the
> benefits. =A0Any idea when that version of git will come out release =
number
> wise and calendar wise?
>
> (Don't read this next part if you just ate or are eating or drinking.=
 =A0You
> may throw-up from nausea or choke from laughing.)
> (I am forced to deal with a mandated/micromanaged change control menu=
 design
> from the powers-that-be that is based on cvs workflow and to
> wipe-your-nose-for-you. =A0It can't even cope with branches much less
> submodules so in that context there isn't time to implement the graph=
ics
> tracking as a submodule. =A0This change control menu is designed to r=
eplace
> cvs commands with equivalent-results git-command sequences. =A0While =
there are
> many git users who import from svn into git, do their work in git, an=
d then
> export back into svn to get work done, ironically I am probably the o=
nly git
> user who has to import from git (powers-that-be mandated cvs-style me=
nu
> controlled git-repo) into git (separate normal git repo and commandli=
ne), do
> the work in normal git, and then export it back into git (cvs-style m=
enu
> controlled git-repo).)

It seems that this is not directly related to the big-file support
issue. Maybe it is better to discuss it in a new thread ^-^
>
> v/r,
> neal
