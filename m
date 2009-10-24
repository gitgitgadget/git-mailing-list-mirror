From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 0/2] user-manual: new "getting started" section
Date: Sat, 24 Oct 2009 23:16:51 +0300
Message-ID: <94a0d4530910241316r3fc4136emd036d18aa45a4192@mail.gmail.com>
References: <1256377489-16719-1-git-send-email-felipe.contreras@gmail.com>
	 <7vy6n065os.fsf@alter.siamese.dyndns.org>
	 <7vr5ss64e5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Hannu Koivisto <azure@iki.fi>, Jeff King <peff@peff.net>,
	Wincent Colaiuta <win@wincent.com>,
	Matthias Lederhofer <matled@gmx.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 24 22:17:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1n2t-0003WD-Ry
	for gcvg-git-2@lo.gmane.org; Sat, 24 Oct 2009 22:17:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752085AbZJXUQu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Oct 2009 16:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751982AbZJXUQt
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Oct 2009 16:16:49 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:30666 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751864AbZJXUQt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Oct 2009 16:16:49 -0400
Received: by fg-out-1718.google.com with SMTP id d23so646857fga.1
        for <git@vger.kernel.org>; Sat, 24 Oct 2009 13:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=sFkGNdcG2ZPXa9T6HnFwOeeZIyo/lWAw2KHrkcWDCWc=;
        b=xuIuGoPeqk/HexjkbL3ayEjYd9v440raPs+fPSTxSGAnlUERLJqjP3E1aSKwR9KNk4
         gtg6Gd+vQ+B1d1extSGzNu1odAV3BEVkCZtzmAZFLcihLfj2rEl1cpDLp7hjqNxZ6M1i
         o4F2LFOPXkYlbjAsACG2up9aOsIuwdsrc5N5I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ZMJOuN+xmtbPUMXwZzDw9RA5OfyrDUxI0IayBgrTNFu6y9t7UXnJ2ifEJuvpz8XQj8
         2R40F9XYNiZ6/RGEI/xXjqIkDDSn5OjRK6PJMRWOPOBBWo7QMpI9b+K+I1ue/OW4hScZ
         Kg7IaJWyhMslcpGTr6cvR6xoB42l64gpnPmsA=
Received: by 10.86.231.15 with SMTP id d15mr6915210fgh.74.1256415411926; Sat, 
	24 Oct 2009 13:16:51 -0700 (PDT)
In-Reply-To: <7vr5ss64e5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131177>

On Sat, Oct 24, 2009 at 9:19 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> Reworded the getting started section based on comments from Michael=
 J Gruber,
>>> Jonathan Nieder and Junio C Hamano.
>>
>> Hmm, I thought JBF also had some input...
>
> Ah, nevermind. Yes, he did have input, and I tend to agree with him, =
and
> more importantly trust his judgement on the manual.

JBF said this[1]:
If we have to do this, just keep it short....

And I am trying to keep it short.

> I think a "Getting started" section that only covers "git config" loo=
ks
> way out of place in the beginning of this document.

Now you are saying that the fact that it's short is a bad thing? That
goes against to what JBF said.

And let's not forget your previous comments

[2]: I think a "getting started" section near the beginning of the manu=
al is a
good idea (and ll.40- is a very early part of the manual).

[3]: I actually wish this section appeared a lot earlier in the documen=
t, but
that is a separate issue.

> Manuals by other people that teach "here is how you would do a hello-=
world
> repository" would want to teach user.name before reaching that point,=
 but
> because the user-manual is written in such a way that it first introd=
uces
> concepts to understand what is going on without changing anything, we=
 do
> not have much need user.name until it gets to "Developing with git"
> section.
>
> "Many people prefer to teach it this way" does not justify "everybody=
 must
> teach it this way" an iota, when teaching "config user.name" upfront =
will
> fit the flow of how they teach but does not fit the flow of how this
> manual teaches [*1*].

Nobody argued that "everybody must teach it this way", the argument
was that most people find it easier, and considering the section is
about "developing with git" it is sensible to avoid burdening the
reader with concepts that don't pertain to the objective at hand,
which is getting them to configure their user.

And let's not forget that the current text is broken for Windows users.

> I'm inclined to to discard the first patch.

And you decided to mention that after many people including you, have
agreed that it's a good idea?

> The point of the original text the second patch touches was to show h=
ow
> simple the contents of the configuration file is and give the users t=
hat
> there is nothing magic there. =C2=A0While I do not like the second pa=
tch as-is,
> because it destroys that nice property and treats the end users mindl=
ess
> "cut-and-paste without thinking" sheeples,

What's wrong with teaching one thing at a time? Configuring the user
is something so essential, I don't think it makes sense to make the
task difficult on purpose. Some people might avoid doing it precisely
because of that.

> I think that it is rather vague
> and unhelpful to the current target audience to say:
>
> =C2=A0 =C2=A0... =C2=A0The easiest way to do so is to make sure the f=
ollowing lines
> =C2=A0 =C2=A0appear in a file named .gitconfig in your home directory=
:
>
> and the parts can use some improvement. =C2=A0For example, "home dire=
ctory"
> does not hold true for people on platforms that lack the concept. =C2=
=A0Keeping
> the current "the following lines appear", rewording "in a file named
> .gitconfig in your home directory" with "in your per-user configurati=
on
> file", keeping the display that shows how the config snippet should l=
ook
> like, and using "config --global -e" might be a better approach.

If you read the results of the last git survey you'll see that the
area that needs most improvement is the documentation. Also I still
see many people doing commits without configuring the user name and
email properly and so I've tried very hard to improve the user manual
to make it easier for them to understand they must do that. In the
process I've added the --edit option to 'git config' and the new
"getting started" section, in order to address all the issues
mentioned in previous threads and gone through several iterations of
these patches already.

I'm starting to think that all the previous "constructive" feedback
was actually targeted to deter people from making any changes.

I'm CC'ing people that have been involved in previous threads.

> [Footnote]
>
> *1* Unless you are changing the flow of how this manual teaches at th=
e
> same time, that is. =C2=A0And no, I am not suggesting that we should =
start from
> "let's do a hello-world repository from scratch". =C2=A0I think the c=
urrent
> "start from read-only and then learn how to grow history later" is on=
e
> valid way to teach.

I also don't think the flow should be changed, that's why I didn't put
the user configuration on the "getting started" section. It goes into
the "developing with git" section.

[1] http://article.gmane.org/gmane.comp.version-control.git/130236
[2] http://article.gmane.org/gmane.comp.version-control.git/115649
[3] http://article.gmane.org/gmane.comp.version-control.git/106667

--=20
=46elipe Contreras
