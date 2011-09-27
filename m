From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH] Docs: git checkout --orphan: `root commit' and `branch head'
Date: Tue, 27 Sep 2011 16:02:32 +0000
Message-ID: <CAMOZ1BsvnZ7PyfjOJURX+B7vCZcYheLS4pissGvPNjEivbYXtw@mail.gmail.com>
References: <1316960136073-6829212.post@n2.nabble.com> <1316961212.4388.5.camel@centaur.lab.cmartin.tk>
 <7vaa9r2jii.fsf@alter.siamese.dyndns.org> <1317073309.5579.9.camel@centaur.lab.cmartin.tk>
 <e88b6e560cab4ed1937dd191b4180387-mfwitten@gmail.com> <4E81F080.7010905@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>,
	vra5107 <venkatram.akkineni@gmail.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Sep 27 18:03:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8a7h-0002I7-UR
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 18:03:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324Ab1I0QDE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Sep 2011 12:03:04 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:57046 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940Ab1I0QDD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Sep 2011 12:03:03 -0400
Received: by iaqq3 with SMTP id q3so5857749iaq.19
        for <git@vger.kernel.org>; Tue, 27 Sep 2011 09:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=mkCabU37zmpU8K2R/oSq6/XKPAolUDFo/R6/UTCRx4Y=;
        b=u0EdsYo0dy8gmqqcM19wLGEVQxIyHarpHh62KELAZdYMhcD27jjoi9R4MpxpBj1llH
         AYggwWKjxJo0O26+L+R0/9itPQ29OkeWxw5VtBZ/IO+uEiSI9f+dCVR8BtBhKGkbPZzV
         +Eh1IHsmpy3P3GIgOKy3O8BgxXkb4VB3ObmE0=
Received: by 10.42.134.4 with SMTP id j4mr9929599ict.135.1317139382389; Tue,
 27 Sep 2011 09:03:02 -0700 (PDT)
Received: by 10.42.171.194 with HTTP; Tue, 27 Sep 2011 09:02:32 -0700 (PDT)
In-Reply-To: <4E81F080.7010905@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182247>

On Tue, Sep 27, 2011 at 15:49, Michael J Gruber
<git@drmicha.warpmail.net> wrote:

> Michael Witten venit, vidit, dixit 27.09.2011 16:43:
>> See:
>>
>> =C2=A0 Re: Can a git changeset be created with no parent
>> =C2=A0 Carlos Mart=C3=ADn Nieto <cmn@elego.de>
>> =C2=A0 Message-ID: <1317073309.5579.9.camel@centaur.lab.cmartin.tk>
>> =C2=A0 http://article.gmane.org/gmane.comp.version-control.git/18217=
0
>>
>> and:
>>
>> =C2=A0 git help glossary
>>
>> Signed-off-by: Michael Witten <mfwitten@gmail.com>
>> ---
>> =C2=A0Documentation/git-checkout.txt | =C2=A0 13 +++++--------
>> =C2=A01 files changed, 5 insertions(+), 8 deletions(-)
>>
>> diff --git a/Documentation/git-checkout.txt b/Documentation/git-chec=
kout.txt
>> index c0a96e6..c963a0f 100644
>> --- a/Documentation/git-checkout.txt
>> +++ b/Documentation/git-checkout.txt
>> @@ -125,19 +125,16 @@ explicitly give a name with '-b' in such a cas=
e.
>> =C2=A0 =C2=A0 =C2=A0 below for details.
>>
>> =C2=A0--orphan::
>> - =C2=A0 =C2=A0 Create a new 'orphan' branch, named <new_branch>, st=
arted from
>> - =C2=A0 =C2=A0 <start_point> and switch to it. =C2=A0The first comm=
it made on this
>> - =C2=A0 =C2=A0 new branch will have no parents and it will be the r=
oot of a new
>> - =C2=A0 =C2=A0 history totally disconnected from all the other bran=
ches and
>> - =C2=A0 =C2=A0 commits.
>> + =C2=A0 =C2=A0 Tell git to make the next commit you make a root com=
mit referenced by
>> + =C2=A0 =C2=A0 the branch head <new_branch>.
>
> I recall objecting to the name "--orphan" (to no avail) because the
> first commit is the root commit and there is no "orphan branch nor
> "parent branch"...

It seems like a more logical approach would be instead for "git
commit" to take a "--root" option that would create a new root commit
based on the current index and then point the current branch head to
the new root commit. Thus:

  $ git checkout -b new_branch old_branch
  $ # Manipulate or not
  $ git commit --root

That's how people think.

> In any case, I think the above is indeed an improvement, but I would
> keep at least something which connects to the misnamed option, e.g.
>
> ...root commit (i.e. without parents) referenced by...
>

Agreed! See the new v2 patch:

  http://article.gmane.org/gmane.comp.version-control.git/182245

>> =C2=A0+
>> =C2=A0The index and the working tree are adjusted as if you had prev=
iously run
>> =C2=A0"git checkout <start_point>". =C2=A0This allows you to start a=
 new history
>> -that records a set of paths similar to <start_point> by easily runn=
ing
>> +that records a set of paths similar to <start_point> by just runnin=
g
>> =C2=A0"git commit -a" to make the root commit.
>
> "similar" is an understatement here, maybe "as in"?

Damn! I'll send a patch on top of v2.

>> =C2=A0+
>> -This can be useful when you want to publish the tree from a commit
>> -without exposing its full history. You might want to do this to pub=
lish
>> +This can be useful when you want to publish a tree without exposing=
 its
>> +full history; for instance, you might want to do this to publish
>> =C2=A0an open source branch of a project whose current tree is "clea=
n", but
>> =C2=A0whose full history contains proprietary or otherwise encumbere=
d bits of
>> =C2=A0code.
>
> +1 ;)

Actually, in v2, I got rid of that entire paragraph, as it's redundant
and difficult to state succinctly AND consistently.
