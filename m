Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4D151FF72
	for <e@80x24.org>; Mon, 23 Oct 2017 08:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751272AbdJWIq6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Oct 2017 04:46:58 -0400
Received: from smtpoutz11.laposte.net ([194.117.213.174]:34817 "EHLO
        smtp.laposte.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751116AbdJWIq5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Oct 2017 04:46:57 -0400
Received: from smtp.laposte.net (localhost [127.0.0.1])
        by lpn-prd-vrout003 (Postfix) with ESMTP id 013D942E66DF
        for <git@vger.kernel.org>; Mon, 23 Oct 2017 10:46:52 +0200 (CEST)
Received: from smtp.laposte.net (localhost [127.0.0.1])
        by lpn-prd-vrout003 (Postfix) with ESMTP id D3AD842E5CA1
        for <git@vger.kernel.org>; Mon, 23 Oct 2017 10:46:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=laposte.net; s=mail0;
        t=1508748411; bh=P5OY4vDipg/+/Qad999YjbkOYIGgrg+7BG8rRJkgVjs=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject;
        b=TURzianLCkYZ6ZEeJ55hl4zV0a0zFTwx/TLjDbl5IXq2Jc79pWGdvJYYtXz0d9w+m
         F+2hNQe1MgdWg75l9AyUReWVvIjDqr1CDiG/tUUwISQmifXgedxFn99V0Ga33Ij8jP
         Uo66554VsjV5WZXIeqdy2oGWJmS/ksx+nUFtb68Uu+HB3qRgLaW8HWHqU5jA4Z2eQP
         8ITxccVcDL8YXkq83p4b3aJOk9V3JKTwTLJJ5x/otuxg0vIBkbhkg+y9LNsqbU6Fvu
         Orw0MnrI6W6oHXs3F26gjU6q4Pw0ndJaP7qioTKW5QeN5n4AdF1XSt8AdKefBCu0Be
         GUOk4KnLkhQCg==
Received: from lpn-prd-mstr088.laposte (lpn-prd-mstr088 [10.128.59.114])
        by lpn-prd-vrout003 (Postfix) with ESMTP id B86CB42E5E89;
        Mon, 23 Oct 2017 10:46:51 +0200 (CEST)
Date:   Mon, 23 Oct 2017 10:46:51 +0200 (CEST)
From:   nicolas.mailhot@laposte.net
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Message-ID: <941027584.80456.1508748411596.JavaMail.zimbra@laposte.net>
In-Reply-To: <1508681703.6715.12.camel@gmail.com>
References: <2089146798.216127.1508487262593.JavaMail.zimbra@laposte.net> <1290947539.4254.1508496039812.JavaMail.zimbra@laposte.net> <CAGZ79kYRq4OugvTfb2WNdk-M5DMAZC0JpJHqC1KSeJY2eNN1=Q@mail.gmail.com> <1760206035.56692.1508594211365.JavaMail.zimbra@laposte.net> <1508681703.6715.12.camel@gmail.com>
Subject: Re: [RFE] Add minimal universal release management capabilities to
 GIT
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [86.202.208.95]
X-Mailer: Zimbra 8.0.6_GA_5922 (ZimbraWebClient - FF57 (Linux)/La Poste)
Thread-Topic: Add minimal universal release management capabilities to GIT
Thread-Index: oKnamx+nf6saIhH4WEp2NIAwXnM4Zg==
X-VR-SrcIP: [86.202.208.95]
X-VR-FullState: 0
X-VR-Score: -100
X-VR-Cause-1: gggruggvucftvghtrhhoucdtuddrgedttddrvdeigddtiecutefuodetggdotefrodftvfcurfhrohhf
X-VR-Cause-2: ihhlvgemucfntefrqffuvffgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhs
X-VR-Cause-3: ucdlqddutddtmdenucfjughrpeffhffvkfgjfhfugggtgfhiofhtsehtqhgttdertdejnecuhfhrohhm
X-VR-Cause-4: pehnihgtohhlrghsrdhmrghilhhhohhtsehlrghpohhsthgvrdhnvghtnecuffhomhgrihhnpehgrhgr
X-VR-Cause-5: fhgvrghsrdhiohenucfkphepuddtrdduvdekrdehledruddugedpkeeirddvtddvrddvtdekrdelheen
X-VR-Cause-6: ucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehlphhnqdhprhguqdhmshhtrhdtkeek
X-VR-Cause-7: rdhlrghpohhsthgvpdhinhgvthepuddtrdduvdekrdehledruddugedpmhgrihhlfhhrohhmpehnihgt
X-VR-Cause-8: ohhlrghsrdhmrghilhhhohhtsehlrghpohhsthgvrdhnvghtpdhrtghpthhtohepghhithhsthgvrhes
X-VR-Cause-9: phhosghogidrtghomh
X-VR-AvState: No
X-VR-State: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

----- Mail original -----
De: "Kaartic Sivaraam" >

> Heads up, I'm gonna play the devil's advocate a little, here.

Be my guest, you're not alone.

On Sat, 2017-10-21 at 15:56 +0200, nicolas.mailhot@laposte.net wrote:
> No that is not up to the hash function. First because hashes are too
> long to be manipulated by humans, and second no hash will ever
> capture human intent. You need an explicit human action to mark "I
> want others to use this particular state of my project because I am
> confident it is solid".
>=20

> I would say you're just limiting your thoughts. There's no strict rule
> saying hash functions should be "incomprehensible" to humans or that
> different hashes should be "uncomparable". No one's going to stop
> someone from creating a hypothetical hash function that's totally
> ordered (!) unless you violate the basis of a "hash". (surprise,
> there's already attempts at it,

I'm not terribly interested in future tech incompatible with existing git p=
rojects, or with the multiple levels of release numbers projects seem to li=
ke.

Besides, even assuming a perfect magical hash, it is not going to replace t=
he human act of choosing a project state others can consolidate on. You can=
 search and replace numbers with magic ordered hash in my original message =
if you like, the rest does not change.

>> Except, the releasing happens outside git, it's still fairly manual.=20

> You seem to be more frustrated by "manual" work.

Git users are frustrated with manual work. They've been "spoilt" by a wonde=
rful tool, and want all software engineering actions to be automated as muc=
h as possible, including releases. They don't want to setup custom project =
specific helpers around Git, they don't want to deal with the project speci=
fic custom helpers others may have invented for generic actions, they want =
built-in commands or nothing.

Just take any random sampling of actual Git projects on Github and you'll s=
ee masses of people not doing releases or referencing other projects by ran=
dom commit hash ("random" in the sense there's no coordination on what hash=
 to choose, it may work or not, once it works locally the commit hash refer=
ence sediments in the project build env because it is too dangerous to chan=
ge, there is no cooperation to focus on particular commits to make sure the=
y are solid, and that's a basic project need, as evidenced by the "RHEL" "s=
table kernel" "Firefox ESR" "Ubuntu LTS" initiatives).=20

>> All I'm proposing is to integrate the basic functions in git to
>> simplify the life of those projects and help smaller projects that
>> want completely intergrated git workflows.

> Wait, aren't you just trying to make git more than a "version control
> system"? I don't think it's encouraged a lot here given that there have
> patches that have not been accepted because they might make git
> opinionated and the result "doesn't quite fit into the broad picture of
> a version control system"

No I'm not trying to make git more than a "version control system". That's =
why I don't propose including dependency handling or build rules. However, =
git needs to hand project state to other tools, every other tool but CI wor=
ks on discrete states (releases), you need a robust process to identify tho=
se states or the handover becomes a pain point. It is starting to failing w=
hen devs do not want to identify project states by anything except git obje=
cts (a is happening now) and those objects are not adapted to deployment an=
d system-wide softwate management.

Just look at
https://grafeas.io/docs/concepts/what-is-grafeas/overview.html

(brand new Google project)

It is all about 'component identifiers' ie release ids. Most of those compo=
nents now live in Git. Why does Google need half a dozen different ways to =
identify software sourced from git? Because Git does not provide good relea=
se tracking capabilities. Yet a lot of developers of those projects will in=
sist the only correct id is a Git commit hash (conspicuously missing from G=
oogle's examples, because commit hashes are a terrible release identifier).

It is a huge problem when all the actors gravitating around a software proj=
ect start disagreeing on basic stuff such as how to identify a project stat=
e. It is a huge problem when you start maintaining complex rosetta stone in=
frastructures just because the software layer that should define convention=
s, refuses to do it, and upper layers are forced to make choices that end u=
p different. There is no inherent advantage to driving left or right. There=
 is a huge advantage when everyone drives the same side.

>> Yes and it is so fun to herd hundreds of management tools with
>> different conventions and quirks. About as much fun as managing
>> dozens of scm before most projects settled on git. All commonalities
>> need to migrate in the common git layer to simplify management and
>> release id is the first of those.

> It's better to have a "good" (generic) release management tool that
> does what you ask (probably with some help from git) than try to turn
> Git into one (which is not possible without making Git opinionated,
> more on that later).

Be my guest, try to define the "some help from git", you'll end up with ver=
y similar requirements to mine. For most because you can't do less to be us=
eful, for others because they are trivial to add once the rest is done and =
it would be woefully inefficient not to do them at the same time.

> I guess there should already be one that meets
> your expectation and you probably just have to discover it.

Funny, it seems the scores of Git projects I have used those past months ar=
e in the same situation. Maybe that's because there's no sense in building =
a standalone tool? Tracking project states is the whole point of Git, you c=
an overlay other tracking systems over the SCM, the end result is inconveni=
ent in the absence of SCM cooperation. That's why so many people are starti=
ng to use git commit hashes in places they've never been designed for and a=
re not adapted too. They are fed up with translating between the scm and th=
e overlays.

> Further, if there's no "generic" release management tool in existence,
> I suspect that because there's no such thing a "generic release
> management strategy"

There may be no such thing as a generic release management strategy. There =
are such things as generic release management steps, which is the only part=
 I propose to automate. Linux package management relies on those commonalit=
ies, and they have decades of successful deployment of all kinds of project=
s by very different authors with very different opinions that sort of prove=
 those commonalities exist.

> and it always depends on context (or) create one
> on your own in the spirit of letting "git" handle just "version
> control" and letting your "genereic" tool handle your concerns. Who
> knows, if you have developed a good enough "generic" tool it might be
> used widely for "release management" just as a lot of projects starting
> using Git for "version control". (I still suspect that there should be
> one that already exists)

Again the problem is not the technical bits, they are rather trivial, the p=
roblem is scm integration which can't be solved outside git itself.

>> > git tags ?
>>=20
>> Too=C2=A0loosely defined to be relied on by project-agnostic tools. That=
's
>> what most tools won't ever try to use those. Anything you will define
>> around tags as they stand is unlikely to work on the project of
>> someone else

> They are loosely defined because you can't define them "tightly" and if
> you try to it would make Git opinionated !?

That makes them useless for tooling. Any automation will require removing a=
mbiguities humans relish. Keep tags for humans, add release ids for tools. =
Making Git unambiguous is not the same thing as giving Git opinions (except=
 when the opinion is "don't use release ids cools can't process").

>> > > 5. a command, such as "git release", allow a human with control of t=
he repo to set an explicit release version to a commit.=20
>> >=20
>> > This sounds fairly specific to an environment that you are in, maybe
>> > write git-release for your environment and then open source it. The
>> > world will love it (assuming they have the same environment and
>> > needs).
>>=20
>> If you take the time to look at it it is not specific, it is generic.
>>=20

>I would say that you might haven't looked broadly enough.

> 1) If it's generic, why isn't there any "generic" release management
> tool?

Why didn't git exist from day one? Is git not generic?

> 2) if it's possible to create a "generic" release management tool and
> it just doesn't exist yet, why not try to create instead of trying to
> integrate release management into Git ?

Because the whole point of Git is to track project states and a release is =
just a particular state (that happens to be useful for users of a project, =
not its own devs, which is why it was not included in git from day one. Tha=
t didn't stop Linus from doing releases manually).

>> You need to identify software during
>> its whole lifecycle, and the id needs to start in the scm, because
>> that's where the lifecycle starts.

> It might not for everyone!

Please present actual facts, that can be discussed.

Regards,

--=20
Nicolas Mailhot
