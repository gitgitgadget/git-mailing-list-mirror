Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D09961FF72
	for <e@80x24.org>; Fri, 20 Oct 2017 10:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752853AbdJTKq6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Oct 2017 06:46:58 -0400
Received: from smtpoutz10.laposte.net ([194.117.213.175]:39885 "EHLO
        smtp.laposte.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751967AbdJTKq5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Oct 2017 06:46:57 -0400
X-Greylist: delayed 374 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Oct 2017 06:46:56 EDT
Received: from smtp.laposte.net (localhost [127.0.0.1])
        by lpn-prd-vrout004 (Postfix) with ESMTP id 0891260B22B
        for <git@vger.kernel.org>; Fri, 20 Oct 2017 12:40:41 +0200 (CEST)
Received: from smtp.laposte.net (localhost [127.0.0.1])
        by lpn-prd-vrout004 (Postfix) with ESMTP id DB58160B239
        for <git@vger.kernel.org>; Fri, 20 Oct 2017 12:40:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=laposte.net; s=mail0;
        t=1508496040; bh=0stUkVGLDSNjg4400iRn0yz71DnJA5xa4J4SNbBBRZc=;
        h=Date:From:To:In-Reply-To:Subject;
        b=ikqTFs6AWz8iqMaH0vRH5puAqiAyAp4Tiv1ZucATzsf3qUS59R4qdCDqHUsign75Z
         Frl53RWX+9oXKvsj6wgxYueJEMOFydFiolR2wvNRrrE7/Oi3QCLj2mOFhL03UvErYK
         7UuMEBwrqlCruVJF8gL2EVxf+Uru/N3HV4prQqRLFO9W142W5zLp0i2NjcNA59D47y
         8ScHTinqezTqRW3g8W6Zs2SLzkA6VrLfsxgYLeOP9tWOc30cgvDR7Qug2/X64zLrbS
         0m1GN3Puk/GBgm47Ra2iGR2cZ0ZqYwmPKh5YReVsQQwc/U9qU/MDVAPoT+jvVX6F0w
         GgiOK40EYMl4w==
Received: from lpn-prd-mstr088.laposte (lpn-prd-mstr088 [10.128.59.114])
        by lpn-prd-vrout004 (Postfix) with ESMTP id ED45860B22B
        for <git@vger.kernel.org>; Fri, 20 Oct 2017 12:40:39 +0200 (CEST)
Date:   Fri, 20 Oct 2017 12:40:39 +0200 (CEST)
From:   nicolas.mailhot@laposte.net
To:     git@vger.kernel.org
Message-ID: <1290947539.4254.1508496039812.JavaMail.zimbra@laposte.net>
In-Reply-To: <2089146798.216127.1508487262593.JavaMail.zimbra@laposte.net>
Subject: [RFE] Add minimal universal release management capabilities to GIT
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [82.232.40.215]
X-Mailer: Zimbra 8.0.6_GA_5922 (ZimbraWebClient - FF57 (Linux)/La Poste)
Thread-Topic: Add minimal universal release management capabilities to GIT
Thread-Index: +MyC/N+4Eu00GB0En3UxTcln/RKxtA==
X-VR-SrcIP: [82.232.40.215]
X-VR-FullState: 0
X-VR-Score: 0
X-VR-Cause-1: gggruggvucftvghtrhhoucdtuddrgedttddrvddtgdeftdcutefuodetggdotefrodftvfcurfhrohhf
X-VR-Cause-2: ihhlvgemucfntefrqffuvffgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepfffhvffkjgfu
X-VR-Cause-3: gggtgfhiofhtsehtqhgttdertdejnecuhfhrohhmpehnihgtohhlrghsrdhmrghilhhhohhtsehlrghp
X-VR-Cause-4: ohhsthgvrdhnvghtnecuffhomhgrihhnpehlfihnrdhnvghtnecukfhppedutddruddvkedrheelrddu
X-VR-Cause-5: udegpdekvddrvdefvddrgedtrddvudehnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghl
X-VR-Cause-6: oheplhhpnhdqphhrugdqmhhsthhrtdekkedrlhgrphhoshhtvgdpihhnvghtpedutddruddvkedrheel
X-VR-Cause-7: rdduudegpdhmrghilhhfrhhomhepnhhitgholhgrshdrmhgrihhlhhhotheslhgrphhoshhtvgdrnhgv
X-VR-Cause-8: thdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-VR-AvState: No
X-VR-State: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Git is a wonderful tool, which has transformed how software is created, and=
 made code sharing and reuse, a lot easier (both between human and software=
 tools).

Unfortunately Git is so good more and more developers start to procrastinat=
e on any activity that happens outside of GIT, starting with cutting releas=
es. The meme "one only needs a git commit hash" is going strong, even infec=
ting institutions like lwn and glibc (https://lwn.net/SubscriberLink/736429=
/e5a8c8888cc85cc8/)

However, the properties that make a hash commit terrific at the local devel=
opment level, also make it suboptimal as a release ID:

=E2=80=93 hashes are not ordered. A human can not guess the sequencing of t=
wo hashes, nor can a tool, without access to Git history. Just try to handl=
e "critical security problem in project X, introduced with version Y and fi=
xed in Z" when all you have is some git hashes. hashing-only introduces sev=
ere frictions when analysing deployment states.

=E2=80=94 hashes are not ranked. You can not guess, looking at a hash, if i=
t corresponds to a project stability point, or is in a middle of a refactor=
ing sequence, where things are expected to break. Evaluating every hash of =
every project you use quickly becomes prohibitive, with the only possible s=
trategy being to just use the latest commit at a given time and pray (and i=
f you are lucky never never update afterwards unless you have lots of fixin=
g and testing time to waste).

=E2=80=93 commit mixing is broken by design. One can not adapt the user of =
a piece of code to changes in this piece of code before those changes are c=
ommitted in the first place. There will always be moments where the latest =
commit of a project, is incompatible with the latest commit of downsteam us=
ers of this project. It is not a problem in developer environments and auto=
mated testers, where you want things to break early and be fixed early. It =
is a huge problem when you follow the same early commit push strategy for a=
ctual production code, where failures are not just a red light in a build f=
arm dashboard, but have real-world consequences. And the more interlinked g=
it repositories you pile on one another, the higher the probability is two =
commits won't work with one another with failures cascading down

=E2=80=93 commits are too granular. Even assuming one could build an automa=
ted regression farm powerful enough to build and test instantaneously every=
 commit, it is not possible to instantaneously push those rebuilds to every=
 instance where this code is deployed (even with infinite bandwidth, infini=
te network reach and infinite network availability). Computers would be spe=
nding their time resetting to the latest build of one component or another,=
 with no real work being done. So there will always be a distance, between =
the latest commit in a git repo, and what is actually deployed. And we've s=
een bare hashes make evaluating this distance difficult

=E2=80=93 commits are a bad inter-project synchronisation point. There are =
too many of them, they are not ranked, everyone is choosing a different com=
mit to deploy, that effectively kills the network effects that helped makin=
g traditional releases solid (because distributors used the same release st=
ate, and could share feedback and audit results).

One could mitigate those problems in a Git management overlay (and, indeed,=
 many try). The problem of those overlays is that they have variable maturi=
ty levels, make incompatible choices, cut corners, are not universal like G=
it, making building anything on top of them of dubious value, with quick fa=
llback to commit hashes, which *are* universal among Git repos. Release han=
dling and versioning really needs to happen in Git itself to be effective.

Please please please add release handling and versioning capabilities to Gi=
t itself. Without it some enthusiastic Git adopters are on a fast trajector=
y to unmanageable hash soup states, even if they are not realising it yet, =
because the deleterious side effects of giving up on releases only get clea=
r with time.

Here is what such capabilities could look like (people on this list can pro=
bably invent something better, I don't care as long as something exists).

1. "release versions" are first class objects that can be attached to a com=
mit (not just freestyle tags that look like versions, but may be something =
else entirely). Tools can identify release IDs reliably.

2. "release versions" have strong format constrains, that allow humans and =
tools to deduce their ordering without needing access to something else (fu=
ll git history or project-specific conventions). The usual string of number=
s separated by dots is probably simple and universal enough (if you start t=
o allow letters people will try to use clever schemes like alpha or roman n=
umerals, that break automation). There needs to be at least two numbers in =
the string to allow tracking patchlevels.

3. several such objects can be attached to a commit (a project may wish to =
promote a minor release to major one after it passes QA, versionning histor=
y should not be lost).

4. absent human intervention the release state of a repo is initialised at =
0.0, for its first commit (tools can rely on at least one release existing =
in a repo).

5. a command, such as "git release", allow a human with control of the repo=
 to set an explicit release version to a commit. Git enforces ordering (ref=
uses versions lower than the latest repo version in git history). The most =
minor number of the explicit release is necessarily zero.

6. a command, such as "git release" without argument, allows a human to req=
uest setting of a minor patchlevel release version for the current commit. =
The computed version is:
   "last=C2=A0release=C2=A0version=C2=A0in=C2=A0git=C2=A0history=C2=A0excep=
t=C2=A0most=C2=A0minor=C2=A0number"
 + "."
 + "number=C2=A0of=C2=A0commits=C2=A0in=C2=A0history=C2=A0since=C2=A0this=
=C2=A0version"
(patchlevel versioning is predictable and decentralized, credits to Willy T=
arreau for the idea)

7. a command, such as "git release bump", allows a human to request setting=
 of a new non-patchlevel release version. The computed version is
   "last release version in git history except most minor number, increment=
ing the remaining most minor number"
 + "."
 + "0"

8. a command, such as "git release promote", allows a human to request sett=
ing a new more major release version. The computed version is
   "last release version in git history except most minor number, increment=
ing the next-to-remaining-most-minor-and-non-zero number, and resetting the=
 remaining-most-minor-and-non-zero number to zero"
 + "."
 + "0"

9. a command, such as "git release cut", creates a release archive, named r=
eponame-releaseversion.tar.xz, with a reponame-releaseversion root director=
y, a reponame-releaseversion/VERSION file containing releaseversion (so aut=
omation like makefiles can synchronize itself with the release version stat=
e), removing git metadata (.git tree) from the result. If the current commi=
t has several release objects attached the highest one in ordering is chose=
n. If the current commit is lacking a release object a new minor patchlevel=
 release version is autogenerated. Archive compression format can be overri=
dden in repo config.

10. a command, such as "git release translate", outputs the commit hash ass=
ociated to the version given in argument if it exists, the version associat=
ed to the commit hash given in argument if it exists, the version associate=
d to the current commit without argument. If it is translating commit hashe=
s with no version it outputs the various versions that could be computed fo=
r this hash by git release, git release bump, git release promote. This is =
necessary to bridge developer-oriented tools, that will continue to talk in=
 commit hashes, and release/distribution/security-audit oriented tools, tha=
t want to manipulate release versions

11. when no releasing has been done in a repo for some time (I'd suggest 3 =
months to balance freshness with churn, it can be user-overidable in repo c=
onfig), git reminds its human masters at the next commit events they should=
 think about stabilizing state and cutting a release.

So nothing terribly complex, just a lot a small helpers to make releasing e=
asier, less tedious, and cheaper for developers, that formalize, automate, =
and make easier existing practices of mature software projects, making them=
 accessible to smaller projects. They would make releasing more predictable=
 and reliable for people deploying the code, and easier to consume by highe=
r-level cross-project management tools. That would transform the deployment=
 stage of software just like Git already transformed early code writing and=
 autotest stages.

Best regards,

--=20
Nicolas Mailhot
 
