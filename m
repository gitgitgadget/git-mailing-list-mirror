From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: Message from 'git-rebase'; German translation
Date: Sun, 23 Sep 2012 17:04:15 +0200
Message-ID: <CAN0XMO+Dd9S7j9Ujudcy+O3GwwBX1CvRPQTYWxymmEu=2bg7ww@mail.gmail.com>
References: <1527028.GPe6zkelBV@blacky>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Thomas Rast <trast@student.ethz.ch>,
	=?UTF-8?Q?Jan_Kr?= =?UTF-8?Q?=C3=BCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>
To: Sascha Cunz <sascha-ml@babbelbox.org>
X-From: git-owner@vger.kernel.org Sun Sep 23 17:04:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFnjS-0006pA-LF
	for gcvg-git-2@plane.gmane.org; Sun, 23 Sep 2012 17:04:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753931Ab2IWPER convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Sep 2012 11:04:17 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:45987 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753907Ab2IWPEQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Sep 2012 11:04:16 -0400
Received: by wibhr14 with SMTP id hr14so3883362wib.1
        for <git@vger.kernel.org>; Sun, 23 Sep 2012 08:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=IXm2ti1rfmFlY1w9jXf1TcS8Lh5SBrLZjpQ0Xhal2eA=;
        b=RPoTNBjIRVf7HxXz4BC1DWSd5DHM8DRvREtmW6A0HYclJwCb16xRSYwcIaLzOoTjDY
         b/Ukuwn8S1/hrVLkHMbAaVBl1AfWPcKF9bh4WxSaaYTIOFUSNlUIdgDtmbb9hF3F+9Se
         A+ilYLsSExu5shJUp6bTN2AwhAWFWJJLGOQr+bjXjfQRvj93cAFglYiu9JUly72jGREe
         8EJxMQzTAzU3xIINkC+Vf/X36OT3JJGwHw/fRtu5yc3mgdGsCKMlIbo8ekRqb+dxi7gs
         sMvnFMQS6R3l8AZrD/BwNrL4piI6A0O+2LGGT3AANNzdCMzDkAERMovWQbtCJtfJ9aIP
         NSAA==
Received: by 10.216.255.146 with SMTP id j18mr5762118wes.163.1348412655626;
 Sun, 23 Sep 2012 08:04:15 -0700 (PDT)
Received: by 10.194.23.201 with HTTP; Sun, 23 Sep 2012 08:04:15 -0700 (PDT)
In-Reply-To: <1527028.GPe6zkelBV@blacky>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206240>

On Sat, Sep 22, 2012 at 11:57 PM, Sascha Cunz <sascha-ml@babbelbox.org>=
 wrote:
> As I know how hard translations can be, esp. with that much technical=
 terms
> inside, I'm usually expecting _not_ to yield the same result when tra=
nslating
> a software's translation back to English.
>

Yeah, I think the goal is not making translations which are looking nea=
rly the
same when somebody translates them back to English in the first place.

> However, git-rebase just threw these two sentences at me (And though =
i know
> their meaning, i couldn't get the meaning from the message, it gave).=
 Both are
> in context of starting a rebase while one is already in progress.
>
> first is:
>
> Original:
> ... and I wonder if you are in the middle of another rebase.
>
> German git translation:
> ... und es w=C3=A4re verwunderlich, wenn ein Neuaufbau bereits im Gan=
ge ist.
>
> And a re-translation back to English from my understanding as native =
German
> speaker:
> ... and it would be astonishing (=3Di'd be surprised), if a rebase wa=
s already
> in progress.
>

We try to avoid translating terms like "I wonder if.." and similar as
"ich wundere mich", because it's very unusual in German messages
of computer programs. Translators should have the freedom to reword
terms a bit to make a more optimal translation, but the meaning must
not be lost, and I can't say that this is the case.
Translate the term "in the middle of"  word-by-word would result in
"in der Mitte eines", which can be interpreted as a place somewhere
or that an action is in progress. To avoid a possible confusion, we
decided to translate this term as "im Gange sein" ("be in progress") in
the whole translation. I also think that "in der Mitte einer Zusammenf=C3=
=BChrung
sein" doesn't sound really good. It tends to mean a place, not an actio=
n.

> And second:
>
> Original:
> I am stopping in case you still have something valuable there.
>
> German git translation:
> Es wird angehalten, falls bereits etwas N=C3=BCtzliches vorhanden ist=
=2E
>
> I wanted to point out that "etwas N=C3=BCtzliches" is more "something=
 useful" that
> "something valuable". But the more I thought about it, the more it st=
arted to

I've been thinking about possible different translations, and the only
one I have in
mind is "wertvoll". But translating "valuable" as "wertvoll" ("bereits
etwas Wertvolles
vorhanden") sounds a bit like "we've found a treasure", instead of
something which
has a value in the meaning of content. I think having a translation
which is more
like "useful" than "valuable" does also hit the point of the message,
doesn't it?

> confuse me (even the original text) - and now I feel like I don't und=
erstand
> the meaning of the last sentence at all; neither in English nor in th=
e German
> translation:
> After removing the directory with all rebase-information inside it, W=
HERE
> should something valuable still be left over? Is it referring to my w=
orking
> tree?
>

Yeah, I think it means the working tree and/or the index which would ma=
ke
sense.

Ralf
