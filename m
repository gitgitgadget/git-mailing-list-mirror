From: Ismail Donmez <ismail@uludag.org.tr>
Subject: Re: Rss produced by git is not valid xml?
Date: Fri, 18 Nov 2005 23:33:23 +0200
Organization: =?utf-8?q?T=C3=9CB=C4=B0TAK/UEKAE?=
Message-ID: <200511182333.23687.ismail@uludag.org.tr>
References: <200511181833.40048.ismail@uludag.org.tr> <20051118205513.GA3168@vrfy.org> <Pine.LNX.4.64.0511181314470.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1254
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Fri Nov 18 23:22:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by deer.gmane.org with esmtp (Exim 3.35 #1 (Debian))
	id 1EdDs5-0002MM-00
	for <gcvg-git@gmane.org>; Fri, 18 Nov 2005 22:34:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbVKRVeK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 18 Nov 2005 16:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbVKRVeK
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 16:34:10 -0500
Received: from ns2.uludag.org.tr ([193.140.100.220]:16274 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S1751013AbVKRVeJ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2005 16:34:09 -0500
Received: from dsl.dynamic8599158195.ttnet.net.tr (unknown [85.99.158.195])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by uludag.org.tr (Postfix) with ESMTP id CF3DFAC9A4
	for <git@vger.kernel.org>; Fri, 18 Nov 2005 23:34:01 +0200 (EET)
To: git@vger.kernel.org
User-Agent: KMail/1.9
In-Reply-To: <Pine.LNX.4.64.0511181314470.13959@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12271>

On Friday 18 November 2005 23:30, you wrote:
> On Fri, 18 Nov 2005, Kay Sievers wrote:
> > Actually, the real bug is not to try to prevent binary nonsense in
> > textual commit logs, which are distibuted. Remember, that you provi=
de a
> > SCM not a filesystem.
>
> I never said they were text, and in fact, I never even said I'm doing=
 an
> SCM. Quite the reverse. I very much said that I'm doing a filesystem =
that
> is flexible.
>
> The fact that the headers are text-like is not so much about text as =
it is
> about flexibility and easy tool access. If you look at the git object
> format, for example, the header is strictly NUL-terminated ASCII, but=
 the
> object itself is a pure binary data stream. Which obviously just _hap=
pens_
> to often be text too, since quite often the object contents is someth=
ing
> like a C source file, but there's a real power to _not_ thinking that=
 it
> means that files are text-files.
>
> And I like UTF-8, but the fact is, all my editors and mail tools are =
still
> Latin-1. My editor converts the UTF-8 input into latin1 and keeps it =
in
> that format on disk (it writes it to the _screen_ as UTF-1 just to ma=
ke
> the glyphs come out right, but the file it works with is still latin1=
).
>
> Could I change? Yup, I could change pretty easily. I wrote the code t=
hat
> did the latin1 conversion, and I've got source for my tools, so I cou=
ld
> just decide one day that I'll join the 21st century and switch. I jus=
t
> haven't done so yet.
>
> The fact that _I_ can't be bothered, even though I'm in just about th=
e
> best possible situation (I've got a keyboard with =E5=E4=F6 on it, bu=
t they're
> not in my name, so I don't use them that much) should tell you someth=
ing.
> Namely, it should tell you that there's a _lot_ of people who have a =
much
> harder time than I do in changing their setups.
>
> I think most of Asia _still_ doesn't use utf-8. And I _guarantee_ you=
 that
> it's a hell of a lot easier for you to complain about it and say "the=
y
> should" than it is for them to actually do so and convert all the pro=
grams
> they use.
>
> On this mailing list, the only person that I've seen pipe up about th=
ese
> things in the past _and_ that I suspect actually has to work with thi=
s
> thing in real life (instead of just from a theoretical "this is how t=
hings
> should be done" standpoint) is Junio. And last I heard (if I remember
> correctly), Junio explicitly said that a lot of the people he works w=
ith
> still use shift-jis.
>
> And I'm not surprised. Look on the web. As far as I know, shift-jis i=
s
> still much more common than utf-8.
>
> AND IT DOESN'T MATTER ONE WHIT WHEN SOME GEEK SAYS "THEY SHOULDN'T DO
> THAT, THEN"!
>
> Software should conform to people, not the other way around.

Linus,

I got your point. But the XML should reflect the data it contains. This=
 _is_=20
my problem. Will the data be latin-1, OK then  the xml should say its l=
atin-1=20
and not lie as utf-8.=20

Regards,
ismail
