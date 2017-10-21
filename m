Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF19F1FF72
	for <e@80x24.org>; Sat, 21 Oct 2017 13:57:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932098AbdJUN44 (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Oct 2017 09:56:56 -0400
Received: from smtpoutz11.laposte.net ([194.117.213.174]:60029 "EHLO
        smtp.laposte.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932085AbdJUN4x (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Oct 2017 09:56:53 -0400
Received: from smtp.laposte.net (localhost [127.0.0.1])
        by lpn-prd-vrout003 (Postfix) with ESMTP id C2E564305C58
        for <git@vger.kernel.org>; Sat, 21 Oct 2017 15:56:51 +0200 (CEST)
Received: from smtp.laposte.net (localhost [127.0.0.1])
        by lpn-prd-vrout003 (Postfix) with ESMTP id A1C904305D20
        for <git@vger.kernel.org>; Sat, 21 Oct 2017 15:56:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=laposte.net; s=mail0;
        t=1508594211; bh=oijjEn5RPUnffjUZh30Yiv4XcYjzZN5DT4Hhvq4TUt8=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject;
        b=G/YnBbTtWJDkBU/KcyuPK3ia8dEYyxCBuitDln/xpam66w5U2ae5W4ftlrjcIJsY5
         IhNzpNzxsw503SxzuMIhRaKgHYYl8zELQmVQPkb1JxV22MZzg/AzN/c25GLU+senNk
         Ofm/KweaooQbam9/3DhmfkEz28rq7WZIhK4zhGpnarlnBq7E8Vy5cf2Ca/oh+RcaJA
         9Zr+enIkyF9RAtryd9pGtNGX20B/162IT41OLQ4tjWm6LQY0c4pkHvLEnPv0wVu+4S
         kttmpWf0SkCnIHZNOQF8kT7sXqbgOqDtSzdtrzU4b5thiLQ3V1avAUKhhwG9JTKDWs
         gUBTG1YkXoaMg==
Received: from lpn-prd-mstr088.laposte (lpn-prd-mstr088 [10.128.59.114])
        by lpn-prd-vrout003 (Postfix) with ESMTP id 86E514305C58;
        Sat, 21 Oct 2017 15:56:51 +0200 (CEST)
Date:   Sat, 21 Oct 2017 15:56:51 +0200 (CEST)
From:   nicolas.mailhot@laposte.net
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Message-ID: <1760206035.56692.1508594211365.JavaMail.zimbra@laposte.net>
In-Reply-To: <CAGZ79kYRq4OugvTfb2WNdk-M5DMAZC0JpJHqC1KSeJY2eNN1=Q@mail.gmail.com>
References: <2089146798.216127.1508487262593.JavaMail.zimbra@laposte.net> <1290947539.4254.1508496039812.JavaMail.zimbra@laposte.net> <CAGZ79kYRq4OugvTfb2WNdk-M5DMAZC0JpJHqC1KSeJY2eNN1=Q@mail.gmail.com>
Subject: Re: [RFE] Add minimal universal release management capabilities to
 GIT
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [86.202.208.95]
X-Mailer: Zimbra 8.0.6_GA_5922 (ZimbraWebClient - FF57 (Linux)/La Poste)
Thread-Topic: Add minimal universal release management capabilities to GIT
Thread-Index: co6sfwp7Knf+5OsIVnMzAi7pTFRxMg==
X-VR-SrcIP: [86.202.208.95]
X-VR-FullState: 0
X-VR-Score: -100
X-VR-Cause-1: gggruggvucftvghtrhhoucdtuddrgedttddrvddvgdejtdcutefuodetggdotefrodftvfcurfhrohhf
X-VR-Cause-2: ihhlvgemucfntefrqffuvffgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhs
X-VR-Cause-3: ucdlqddutddtmdenucfjughrpeffhffvkfgjfhfugggtgfhiofhtsehtqhgttdertdejnecuhfhrohhm
X-VR-Cause-4: pehnihgtohhlrghsrdhmrghilhhhohhtsehlrghpohhsthgvrdhnvghtnecuffhomhgrihhnpehgihht
X-VR-Cause-5: hhhusgdrtghomhdpihhsohgtphhprdhorhhgpdhlfihnrdhnvghtnecukfhppedutddruddvkedrheel
X-VR-Cause-6: rdduudegpdekiedrvddtvddrvddtkedrleehnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhh
X-VR-Cause-7: vghloheplhhpnhdqphhrugdqmhhsthhrtdekkedrlhgrphhoshhtvgdpihhnvghtpedutddruddvkedr
X-VR-Cause-8: heelrdduudegpdhmrghilhhfrhhomhepnhhitgholhgrshdrmhgrihhlhhhotheslhgrphhoshhtvgdr
X-VR-Cause-9: nhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-VR-AvState: No
X-VR-State: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



----- Mail original -----
De: "Stefan Beller"=20

>> Unfortunately Git is so good more and more developers start to procrasti=
nate on any activity that happens outside of GIT,
>> starting with cutting releases. The meme "one only needs a git commit ha=
sh" is going strong, even infecting institutions
>> like lwn and glibc (https://lwn.net/SubscriberLink/736429/e5a8c8888cc85c=
c8/)

> For release you would want to include more than just "the code" into
> the hash, such as compiler versions, environment variables, the phase
> of the moon, what have you, that may impact the release build.

Yes and no. Yes because you do want to limit failure cases, and no because =
it's very easy to overspecify and block code reuse possibilities. Anyway I =
don't see a strong consensus on how to do those yet, they are very language=
-specific, and the first step is being able to identify other code you depe=
nd on which requires some sort of release id, which is what my message was =
about. You can't build any compatibility matrix, before being able to name =
the dimensions of the matrix.

> It sounds to me as if you assume that if X, Y, Z were numbers (or
> rather had some order), this can be easily deduced.

It's a lot more easy to use "option foo was introduced in version 2.3.4 and=
 takes Y parameters" than "option foo was introduced in commit hash #######=
######################################, you have version hash $$$$$$$$$$$$$=
$$$$$$$$$$$$$$$$$$$$$$$$$$$$$", good luck.

> The output of git-describe ought to be sufficient for an ordering
> scheme to rely on?

That relies on git access to the repo of every bit of code your computer ru=
ns. This is not practical past the deployment phase. For deployment the ord=
ering needs to be extracted from all the git data so you only need to manip=
ulate short human and tool-friendly ids. You need low coupling not the stro=
ng coupling of git repo access.

>> =E2=80=94 hashes are not ranked. You can not guess, looking at a hash, i=
f it corresponds to a project stability point, or is in a
>> middle of a refactoring sequence, where things are expected to break. Ev=
aluating every hash of every project you use
>> quickly becomes prohibitive, with the only possible strategy being to ju=
st use the latest commit at a given time and pra
>> (and if you are lucky never never update afterwards unless you have lots=
 of fixing and testing time to waste).

> That is up to the hash function. One could imagine a hash function
> that generates bit patterns that you can use to obtain an order from.

No that is not up to the hash function. First because hashes are too long t=
o be manipulated by humans, and second no hash will ever capture human inte=
nt. You need an explicit human action to mark "I want others to use this pa=
rticular state of my project because I am confident it is solid".

>> =E2=80=93 commit mixing is broken by design.

> In Git terms a repository is the whole universe.
> If you want relationships between different projects, you need to
> include these projects e.g. via subtree or submodules.
> It scales even up to linux distributions (e.g.
> https://github.com/gittup/gittup, includes nethack!)

This is still pre-deployment phase. And I wouldn't qualify this as "full li=
nux distro", it's very small scale. If anything it demonstrated than even o=
n a smallish perimeter relying on git alone as it stands today is too hard =
(3 updates in the whole 2017 year!).

>> One can not adapt the user of a piece of code to changes in this piece o=
f code before those changes are committed in the
>> first place. There will always be moments where the latest commit of a p=
roject, is incompatible with the latest commit of
>> downsteam users of this project. It is not a problem in developer enviro=
nments and automated testers, where you want things >> to break early and b=
e fixed early. It is a huge problem when you follow the same early commit p=
ush strategy for actual
>> production code, where failures are not just a red light in a build farm=
 dashboard, but have real-world consequences. And
>> the more interlinked git repositories you pile on one another, the highe=
r the probability is two commits won't work with
>> one another with failures cascading down

> That is software engineering in general, I am not sure how Git relates
> to this? Any change that you make (with or without utilizing Git) can
> break the downstream world.

It's a lot easier to manage when you have discrete release synchronisation =
point and not just a flow of commits

>> =E2=80=93 commits are a bad inter-project synchronisation point. There a=
re too many of them, they are not ranked, everyone is
>> choosing a different commit to deploy, that effectively kills the networ=
k effects that helped making traditional releases
>> solid (because distributors used the same release state, and could share=
 feedback and audit results).

> There are different strategies. Relevant open source projects (kernel,
> glibc, git) are pretty good at not breaking the downstream users with
> every commit.

Just pick any random kernel commit during merge windows, try to build/run i=
t and we'll talk again;)
What those projects are pretty good at is a clear release strategy that hel=
ps their users identify good project states which are safe to run.

Except, the releasing happens outside git, it's still fairly manual. All I'=
m proposing is to integrate the basic functions in git to simplify the life=
 of those projects and help smaller projects that want completely intergrat=
ed git workflows.

> If you want faster velocity, you have to couple the projects more
> (submodules or a large repo including everything)

Just try do to it. You'll get slower velocity because of the difficulty inh=
erent in managing a large number of projects with strong git coupling. And =
if you tell me "I'll just not update everything in parallel all the time" y=
ou've just reinvented releasing without the help of explicit release states=
.

> I am not convinced, yet. As said initially the release handling needs
> to take more things into account (compiler version, hardware version
> of the fleet, etc) which is usually not tracked in Git. Well you
> could, but that is the job of the release management tool, no?

Yes and it is so fun to herd hundreds of management tools with different co=
nventions and quirks. About as much fun as managing dozens of scm before mo=
st projects settled on git. All commonalities need to migrate in the common=
 git layer to simplify management and release id is the first of those. Bes=
ides the first thing those tools want is a way to identify the states to us=
e, they'll be the first consumers of release integration in git.

>> 1. "release versions" are first class objects that can be attached to a =
commit (not just freestyle tags that look like
>> versions, but may be something else entirely). Tools can identify releas=
e IDs reliably.

> git tags ?

Too loosely defined to be relied on by project-agnostic tools. That's what =
most tools won't ever try to use those. Anything you will define around tag=
s as they stand is unlikely to work on the project of someone else

>> 2. "release versions" have strong format constrains, that allow humans a=
nd tools to deduce their ordering without needing
>> access to something else (full git history or project-specific conventio=
ns). The usual string of numbers separated by dots
>> is probably simple and universal enough (if you start to allow letters p=
eople will try to use clever schemes like alpha or=20
>> roman numerals, that break automation). There needs to be at least two n=
umbers in the string to allow tracking patchlevels.

> git tags are pretty open ended in their naming. the strictness would
> need to be enforced by the given requirement of the environment.

You've just lost. You can't build any complex system without some level of =
shared conventions, if you limit the conventions to the project level you l=
imit what you can build above the project level, starting with tooling

> (Some
> want to have just one integer number going up; others want patch
>levels, i.e. 4 ints;=20

That's why I don't propose to set any constrain on the number of levels, ex=
cept for a minimum (2, because in practice every project will need a point =
release at some time).

This is sufficient for automation, and pretty much half of what linux distr=
os do to manage complex multi-project systems (convert loosely under-specif=
ied versionning to chains of numbers that deb or rpm can understand). And d=
istributions manage to do that because that's already pretty much the relea=
se id conventions everyone uses, with minor variations.

> yet others want dates?)

That never worked so well, half the time you miss the date because of delay=
s and it's too late to change the naming everyone expects. But anyway, noth=
ing prevents you from using 2017.10.21.0 as release id, the proposed scheme=
 allows this.

>> 3. several such objects can be attached to a commit (a project may wish =
to promote a minor release to major one after it
>> passes QA, versionning history should not be lost).

> Multiple git tags can be attached to the same commit. You can even tag
> a tag or tag a blob.

Again the problem with tags is that they can be anything, you can't rely on=
 a tag being a release id, you can't rely on a tag having ordering constrai=
ns, you can't build any tooling around those above the project level.

>> 4. absent human intervention the release state of a repo is initialised =
at 0.0, for its first commit (tools can rely on at >> least one release exi=
sting in a repo).

> An initial repo doesn't have tags, which comes close to 0.

And it's not defined anywere so some will insist history starts at 1 or at =
-52 BC or whatever. Explicit convention enforced by tooling that others too=
ls can rely on trumps implicit convention that can be argued to death all t=
he time.

>> 5. a command, such as "git release", allow a human with control of the r=
epo to set an explicit release version to a commit.=20

> This sounds fairly specific to an environment that you are in, maybe
> write git-release for your environment and then open source it. The
> world will love it (assuming they have the same environment and
> needs).

If you take the time to look at it it is not specific, it is generic.

But, anyway yet another project bubble presents no value. The value of conv=
entions is that they are shared, not that they are better than the neighbou=
r's. I'll applaud anything done at git level because all the other tools an=
d humans rely on this level. I'm sick of looking at conversion heuristics b=
etween higher-level tools, because they can't rely on scm-level conventions=
.

>> 9. a command, such as "git release cut",=20
> git -archive comes to mind, doing a subset here.

It is not complex to do. The value is not on its complexity, the value is i=
n setting conventions others can rely on.

>> 11. when no releasing has been done in a repo for some time (I'd suggest=
 3 months to balance freshness with churn, it can >> be user-overidable in =
repo config), git reminds its human masters at the next commit events they =
should think about >> stabilizing state and cutting a release.

> This is all process specific to your environment. Consider e.g. the
> C++ standard committee tracking the C++ Standard in Git .
> https://isocpp.org/std/the-committee
> They make a release every 10 years or such, so 3 month is off!

Actually you'll find out that they do intermediary pre-standard releases wa=
y more often. 3 months is the average that works for most projects. I don't=
 propose to set it in stone, just as a sane default.


> Integrating with CI and release is definitely important, but Git
> itself has no idea about the requirements and environments of the
> project specifics,

The proposal is not just about CI. The software life does not end when a de=
v pushes code to CI. You need to identify software during its whole lifecyc=
le, and the id needs to start in the scm, because that's where the lifecycl=
e starts.

Right now the only shared id that does not depend on project environment th=
at git proposes is commit hashes, and it is terrible in post-dev stages of =
the lifecycle.

Regards,

--=20
Nicolas Mailhot
