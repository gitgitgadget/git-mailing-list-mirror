From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Git Survey 2011; now let's not forget the index/cache/stage
Date: Tue, 21 Sep 2010 02:28:19 +0300
Message-ID: <AANLkTik-2gaUMoWRC=SPfzY-0HdPw587n0ugnvvbMb_w@mail.gmail.com>
References: <AANLkTi=Fp89-MuYVCNFtSA25hVufbQD5TCJL-ATUDCDH@mail.gmail.com>
	<201009201538.41287.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 21 01:28:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oxpmb-0003aK-Sp
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 01:28:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757665Ab0ITX2U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Sep 2010 19:28:20 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:38316 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757412Ab0ITX2U convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Sep 2010 19:28:20 -0400
Received: by iwn5 with SMTP id 5so4598559iwn.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 16:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=wZUJnAMYSILZRzZcfgw9J2/jQ/0AisBdkfMJRvT55SY=;
        b=JVuphfIHgRFOawmA2fwHu2U7aVg4tK/SPo8B45hvJ2AZ/mUWsqUpq/f5ZHIBjozIBS
         8S1dFMuq33HzY3d/0DlHwdoKZw2QcbhF2LbQ0aGeYkkHPsP9qHtZtXvKbkI9emwLmPw7
         /I03k6xoaRRphyJhnu4LQNw8st9aLdRNk08v0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jkad1xhAxw331VrmBMDqrPnCQOgg6EyKLQbWOUHrojhE7kcNrrQwaXWuD2bGUNwJb+
         jKCUhZ2bYZV97027aiClv51++NNPIxPGKKwcNltYIW1y7MXeqguo8fk6/fKx7Dxj8K06
         +SnAMCH1JS7DbmGYQLfUUaNqSOdvH7r+mBd90=
Received: by 10.231.10.200 with SMTP id q8mr10016678ibq.83.1285025299212; Mon,
 20 Sep 2010 16:28:19 -0700 (PDT)
Received: by 10.231.160.6 with HTTP; Mon, 20 Sep 2010 16:28:19 -0700 (PDT)
In-Reply-To: <201009201538.41287.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156680>

Hi,

On Mon, Sep 20, 2010 at 4:38 PM, Jakub Narebski <jnareb@gmail.com> wrot=
e:
> On Mon, 20 Sep 2010, Felipe Contreras wrote:
>
>> I am *extremely* disappointed with the fact the git survey doesn't
>> have a way to determine how many people really use the
>> index/cache/stage; I think it's one of the most important features o=
f
>> git, and I'm fairly certain most users don't know about it.
>
> Doesn't "interactive commit / per-hunk comitting / partial commit" co=
ver
> "git index / cache / stage" response by being what git index is used =
for
> in explicit way?

Well, that's one part of the stage usage; there's a subset of 'git
checkout', and 'git diff --cached' that are totally uncovered. I think
somebody might be doing 'git add -i' without understanding where the
commit is going.

>> IMO the main purpose of the survey is to find out areas of improveme=
nt
>> in git, and I was hoping this year it would be obvious the stage
>> needed some help to make it more visible and accessible.
>
> I don't think that having "git index / cache / stage" as a choice of
> answer in multiple-choice '16) Which of the following features do you
> use?' question would tell us that.
>
> If there were "better support for staging / interacting with index"
> (perhaps with footnote describing it in more detail below) in the
> '17) Which of the following features would you like to see implemente=
d
> in git?' question, but IIRC it wasn't present in your proposal.

Well, if the users actually knew what the stage is, your idea would
certainly be better, but I'm not so sure that's the case. A user might
select "interactive commit / per-hunk comitting / partial commit"
without realizing that's using the "stage", and just skip the question
without thinking too much about it.

So I think the first step would be to determine if people know what
the stage is, and if they use it.

>> You agreed it would be there, and it's not, so I wonder what's the
>> point of asking for feedback if it's going to be forgotten. Next tim=
e
>> I think you should send the final version for review before
>> publishing.
>
> There were two issues conflated that contributed to this error
> of mine.
>
> First, I have re-checked *direct email* responses to request for
> feedback on Git User's Survey 2010 questions proposal, but I have
> forgot to re-check responses which were send only to git mailing list
> without Cc (i.e. in my case *newsgroup* responses). =C2=A0I am very s=
orry
> for that.
>
> Second, I has a bit unplanned time away from Internet access at the e=
nd
> of August, so I had only about a day to do re-check, edit and open th=
e
> survey on 1 September. =C2=A0I should have edited survey as soon as i=
 got
> improvement suggestion, but the fact that one has to close all channe=
ls
> before adding new answer to a multiple-choice question (I think
> Survs.com did it for a good reason) made me postpone it.

Ok, but still, I think a final notification one week or so before
would help. Either posting the last version, or just point the wiki.

>> I don't think I would care about the results this year, so can we ha=
ve
>> a wiki with next years's survey? I *really* want to make sure it get=
s
>> there.
>
> Well, nobody prevents you from starting GitSurvey2011 page on git wik=
i.
> You can use older version of GitSurvey2010 as a template:
> =C2=A0https://git.wiki.kernel.org/index.php?title=3DGitSurvey2010&old=
id=3D8988
> (click edit and copy the contents). =C2=A0Having a year for discussio=
n about
> what questions should there be in user's survey would only improve it=
=2E

Ok, I'll do that when I have time :)

> P.S. I can even add you as a member to 'git' account on Survs.com, so
> you would be able to view and even edit survey there, but the Premium
> plan, which we have thanks to generosity of Survs.com administration
> (received after Survs.com got out of beta - first survey on Survs.com
> was run on beta), will downgrade to the Free plan on Sep 22, 2011.

Sure, but I only would feel comfortable of updating the site after
some agreement has been reached on the wiki or ml.

Cheers.

--=20
=46elipe Contreras
