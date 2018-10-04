Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EEC11F453
	for <e@80x24.org>; Thu,  4 Oct 2018 15:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbeJDWUP (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Oct 2018 18:20:15 -0400
Received: from mout.gmx.net ([212.227.15.18]:48325 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727588AbeJDWUP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Oct 2018 18:20:15 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M2c1V-1fpsHO3m4b-00sL08; Thu, 04
 Oct 2018 17:26:28 +0200
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M2c1V-1fpsHO3m4b-00sL08; Thu, 04
 Oct 2018 17:26:28 +0200
Date:   Thu, 4 Oct 2018 17:26:32 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Ananya Krishna Maram <ananyakittu1997@gmail.com>
cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] [Outreachy] git/userdiff.c fix regex pattern error
In-Reply-To: <CA+=o6KFN-p901GiJzj5BquU2RKCVTOKarGpjjuqsASN_uqGZSQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1810041718480.73@tvgsbejvaqbjf.bet>
References: <20181004113015.GA30901@manohar-ssh> <nycvar.QRO.7.76.6.1810041624290.73@tvgsbejvaqbjf.bet> <CA+=o6KFN-p901GiJzj5BquU2RKCVTOKarGpjjuqsASN_uqGZSQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:80D+VHbvflglHUpc5eSM/VqVzWRN6JwU8j6AMgW7VGGbf+kLkow
 0Pp4h+VuVlaVMHLyTmyyaEwd1xqu4cbkU2wqIF6eLo9lPmfaMb94GRnKbUhO4Jn6gnYQiLq
 gVGdzqj+vGYwcZWLiEj3X23v9GZ4uyRsMXcErG2CA9/7NLhBPzLMZCrr8jxpn5h5coVUuEw
 udMp7n+RZch+s20R4xmNg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UdNGeKkEoNY=:aoiRzJSi5wcsahZiAnnrwc
 aQF6VrFXjht9YG0Of8fV8nS35evpm/rOnh8stPxv2L2Y702jZmGDfkStbnTQhMVjcZ3CVxfu6
 trQ+lUrHRT5l+k47frnHExMO3NFRpOGB9Pbl8Fw7tWc+WDhiENL8qyY/ZGSmXP/5cyewp6iAO
 H2DWTZlyDD4m9w6Y/IzIlzjXZNh9fg08IdX/uXM1zAUBq3XvsTVmCBs2QPOgFfgDeUxJvQStY
 /HD5C80AyR6wOEH5kd/QkFryk/MW+C4QIRBwqp/68ycKPGqyrE025umeg466LfdsM81Mo7VPx
 oXAVYAuwBLyPKhhxtV5qjwremx+7K4G+F19xjzpGcmdPp59Hlft0JjwOYFnwB9mg9a6/5xAEb
 NpIdfLAbLQyHujUVU88rVsPOuCpJRU1qaFF4QX3ytY8kbqWK9ELJ9SZXZ3qYYpDhepEsrF2L6
 pU0ZnLTavhPxvJBvsfA7ovoVnjH531K7HSr873VWqW1wYRLz07hjEC3fnoSwJWDIJtWg4UuhD
 /kIjxBGQ/CYvWPEMFybIrKj7wb4NNn9KWHeOLAPkLOxNuwJxUm/5EsuC8Y2XquxdeNqbmzspg
 Nf+gtNRusfzqw7cI2+VWARtXvthtEr4KlcU1AccKOnvGMZDoJOI4yV87eVvXwNNr1rzTgUN+o
 YAk+Meikp3xTfDggpTQPrcQRYpFVll5bV5l04ffAqQS9KPjeNXhc7mhPeeZUcU8TJfnnWro/n
 bD2Xa7GO7uhmn2StvRivAfsQblWiktHtUwKuiwlk8sR2GewVF1QRgD78fYfEQxwmF+uv6dn3E
 CFTHkWRTLWYOK0QPkzrU9C/G6+S62lt7IZk1LyLb4P7GDLoKqc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ananya,

On Thu, 4 Oct 2018, Ananya Krishna Maram wrote:

> On Thu, 4 Oct 2018 at 19:56, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > Hi Ananya,
> >
> > thank you for taking the time to write this patch!
> >
> > On Thu, 4 Oct 2018, Ananya Krishna Maram wrote:
> >
> > > the forward slash character should be escaped with backslash. Fix
> > > Unescaped forward slash error in Python regex statements.
> > >
> > > Signed-off-by: Ananya Krishna Maram<ananyakittu1997@gmail.com>
> >
> > That explains pretty well what you did, but I wonder why the forward slash
> > needs to be escaped? I would understand if we enclosed the pattern in
> > `/<regex>/`, as it is done e.g. in Javascript, but we do not...
> 
> You are correct, the code would execute either ways. But when I came across
> this line, I didn't get it's meaning instantly because as per standards, forward
> slash has to be escaped. In fact when open source code is written according to
> standards, the code will be reachable to more people.

I am afraid that I do not follow... Regular expressions have quite a few
special characters, but forward slashes are not among them.

Meaning: if we had specified the regular expression thusly (in any
language that supports them to be specified in this way):

	/|[-+*/<>%&^|=!]=|//=?|<<=?|>>=?|\\*\\*=?/

then I would agree that this is a bug, and needs to be fixed. But we
specify it as a regular C string:

	"|[-+*/<>%&^|=!]=|//=?|<<=?|>>=?|\\*\\*=?"

In this context, the backslash has an additional, nested meaning: it
escapes special characters in a C string, too. So writing

	"\\"

will actually result in a string consisting of a single backslash. And

	"\n"

would specify a string consisting of a single line feed character. Some C
compilers ignore incorrectly-escaped characters, i.e. "\/" would simply
expand to the forward slash.

However, you wanted to escape the forward slash in the regular expression.
To do that, you would have to write

	"\\/"

i.e. specifying, in a C string, a backslash character, followed by a
forward slash character.

However, the regular expression would then be interpreting the backslash
character as escape character in its own right, seeing the forward slash,
and replacing this sequence by a forward slash.

But it does not need to be escaped, when you specify the regular
expression the way we do. And the way we specified it is really the
standard when specifying regular expressions in C code, i.e. *without* the
suggested backslash.

Ciao,
Johannes

> 
> Thanks,
> Ananya.
> 
> > Thanks,
> > Johannes
> >
> > > ---
> > >  userdiff.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/userdiff.c b/userdiff.c
> > > index f565f6731..f4ff9b9e5 100644
> > > --- a/userdiff.c
> > > +++ b/userdiff.c
> > > @@ -123,7 +123,7 @@ PATTERNS("python", "^[ \t]*((class|def)[ \t].*)$",
> > >        /* -- */
> > >        "[a-zA-Z_][a-zA-Z0-9_]*"
> > >        "|[-+0-9.e]+[jJlL]?|0[xX]?[0-9a-fA-F]+[lL]?"
> > > -      "|[-+*/<>%&^|=!]=|//=?|<<=?|>>=?|\\*\\*=?"),
> > > +      "|[-+*\/<>%&^|=!]=|\/\/=?|<<=?|>>=?|\\*\\*=?"),
> > >        /* -- */
> > >  PATTERNS("ruby", "^[ \t]*((class|module|def)[ \t].*)$",
> > >        /* -- */
> > > --
> > > 2.17.1
> > >
> > >
> 
