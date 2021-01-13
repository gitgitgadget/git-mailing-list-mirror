Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFC4C433E0
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 08:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D40A23107
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 08:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbhAMIeL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 03:34:11 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54168 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbhAMIeL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 03:34:11 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1B566A1CEF;
        Wed, 13 Jan 2021 03:33:25 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=HfI5NeYu7wNrJhRd+OagsYH2q
        xw=; b=Qpc+lymWD2gkMHHy+/eZ/KBX1Fb41whyFGP9MC0J7ICS76XNA9RMQLz3X
        SUY5DVY7DnKbwMvZlXbzvbfJVRmu/hHQLRC0ILjTNW5WXtsk9p/NwPTJmDPFzbTN
        ZGgUGRX0zhS4W2G2r435q94aLEhUitZbOkdSSJn5u5yb4wqFE0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=ZguOoeaI6k6n9XTuy1J
        MaC6NBDC7ohQt7Q8TjFjFrirYn7uCzxc8H+sPO92qsmwzDG4Db3WZOLPE/E52llP
        gHN5svjUxhFlhn5ad0Ob+FSbjFBJ82WtswMFyn5mVxUVQCX4hEyeA3WZtBgYQwWB
        vmGFtoa5709HBKFVbhe0XeaQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F23A6A1CEE;
        Wed, 13 Jan 2021 03:33:24 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 57C37A1CEC;
        Wed, 13 Jan 2021 03:33:24 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] CoC: update to version 2.0 + local changes
Date:   Wed, 13 Jan 2021 00:33:23 -0800
Message-ID: <xmqqzh1dxmlo.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 00439CCC-557A-11EB-B1B4-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is to remind those of you who may want to add your Acked-by to
=C3=86var's proposed update to show your support.  I've collected ones on
the list I saw in replies to the original proposal [*1*] but in case
I missed yours...

Thanks.

[Reference]

*1* Message-Id: <20201228171734.30038-3-avarab@gmail.com>

----- >8 ---------- >8 ---------- >8 ---------- >8 ---------- >8 -----
From: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Subject: [PATCH] CoC: update to version 2.0 + local changes

Update the CoC added in 5cdf2301 (add a Code of Conduct document,
2019-09-24 from version 1.4 to version 2.0. This is the version found
at [1] with the following minor changes:

 - We preserve the change to the CoC in 3f9ef874a73 (CODE_OF_CONDUCT:
   mention individual project-leader emails, 2019-09-26)

 - We preserve the custom intro added in 5cdf2301d4a (add a Code of
   Conduct document, 2019-09-24)

This change intentionally preserves a warning emitted on "git diff
--check". It's better to make it easily diff-able with upstream than
to fix whitespace changes in our version while we're at it.

1. https://www.contributor-covenant.org/version/2/0/code_of_conduct/code_=
of_conduct.md

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Acked-by: Christian Couder <chriscool@tuxfamily.org>
Acked-by: Derrick Stolee <dstolee@microsoft.com>
Acked-by: Elijah Newren <newren@gmail.com>
Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Acked-by: Jonathan Nieder <jrnieder@gmail.com>
Acked-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 CODE_OF_CONDUCT.md | 153 ++++++++++++++++++++++++++++++---------------
 1 file changed, 104 insertions(+), 49 deletions(-)

diff --git a/CODE_OF_CONDUCT.md b/CODE_OF_CONDUCT.md
index 083bd872c5..65651beada 100644
--- a/CODE_OF_CONDUCT.md
+++ b/CODE_OF_CONDUCT.md
@@ -8,70 +8,64 @@ this code of conduct may be banned from the community.
=20
 ## Our Pledge
=20
-In the interest of fostering an open and welcoming environment, we as
-contributors and maintainers pledge to make participation in our project=
 and
-our community a harassment-free experience for everyone, regardless of a=
ge, body
-size, disability, ethnicity, sex characteristics, gender identity and ex=
pression,
-level of experience, education, socio-economic status, nationality, pers=
onal
-appearance, race, religion, or sexual identity and orientation.
+We as members, contributors, and leaders pledge to make participation in=
 our
+community a harassment-free experience for everyone, regardless of age, =
body
+size, visible or invisible disability, ethnicity, sex characteristics, g=
ender
+identity and expression, level of experience, education, socio-economic =
status,
+nationality, personal appearance, race, religion, or sexual identity
+and orientation.
+
+We pledge to act and interact in ways that contribute to an open, welcom=
ing,
+diverse, inclusive, and healthy community.
=20
 ## Our Standards
=20
-Examples of behavior that contributes to creating a positive environment
-include:
+Examples of behavior that contributes to a positive environment for our
+community include:
=20
-* Using welcoming and inclusive language
-* Being respectful of differing viewpoints and experiences
-* Gracefully accepting constructive criticism
-* Focusing on what is best for the community
-* Showing empathy towards other community members
+* Demonstrating empathy and kindness toward other people
+* Being respectful of differing opinions, viewpoints, and experiences
+* Giving and gracefully accepting constructive feedback
+* Accepting responsibility and apologizing to those affected by our mist=
akes,
+  and learning from the experience
+* Focusing on what is best not just for us as individuals, but for the
+  overall community
=20
-Examples of unacceptable behavior by participants include:
+Examples of unacceptable behavior include:
=20
-* The use of sexualized language or imagery and unwelcome sexual attenti=
on or
-  advances
-* Trolling, insulting/derogatory comments, and personal or political att=
acks
+* The use of sexualized language or imagery, and sexual attention or
+  advances of any kind
+* Trolling, insulting or derogatory comments, and personal or political =
attacks
 * Public or private harassment
-* Publishing others' private information, such as a physical or electron=
ic
-  address, without explicit permission
+* Publishing others' private information, such as a physical or email
+  address, without their explicit permission
 * Other conduct which could reasonably be considered inappropriate in a
   professional setting
=20
-## Our Responsibilities
+## Enforcement Responsibilities
=20
-Project maintainers are responsible for clarifying the standards of acce=
ptable
-behavior and are expected to take appropriate and fair corrective action=
 in
-response to any instances of unacceptable behavior.
+Community leaders are responsible for clarifying and enforcing our stand=
ards of
+acceptable behavior and will take appropriate and fair corrective action=
 in
+response to any behavior that they deem inappropriate, threatening, offe=
nsive,
+or harmful.
=20
-Project maintainers have the right and responsibility to remove, edit, o=
r
-reject comments, commits, code, wiki edits, issues, and other contributi=
ons
-that are not aligned to this Code of Conduct, or to ban temporarily or
-permanently any contributor for other behaviors that they deem inappropr=
iate,
-threatening, offensive, or harmful.
+Community leaders have the right and responsibility to remove, edit, or =
reject
+comments, commits, code, wiki edits, issues, and other contributions tha=
t are
+not aligned to this Code of Conduct, and will communicate reasons for mo=
deration
+decisions when appropriate.
=20
 ## Scope
=20
-This Code of Conduct applies within all project spaces, and it also appl=
ies when
-an individual is representing the project or its community in public spa=
ces.
-Examples of representing a project or community include using an officia=
l
-project e-mail address, posting via an official social media account, or=
 acting
-as an appointed representative at an online or offline event. Representa=
tion of
-a project may be further defined and clarified by project maintainers.
+This Code of Conduct applies within all community spaces, and also appli=
es when
+an individual is officially representing the community in public spaces.
+Examples of representing our community include using an official e-mail =
address,
+posting via an official social media account, or acting as an appointed
+representative at an online or offline event.
=20
 ## Enforcement
=20
 Instances of abusive, harassing, or otherwise unacceptable behavior may =
be
-reported by contacting the project team at git@sfconservancy.org. All
-complaints will be reviewed and investigated and will result in a respon=
se that
-is deemed necessary and appropriate to the circumstances. The project te=
am is
-obligated to maintain confidentiality with regard to the reporter of an =
incident.
-Further details of specific enforcement policies may be posted separatel=
y.
-
-Project maintainers who do not follow or enforce the Code of Conduct in =
good
-faith may face temporary or permanent repercussions as determined by oth=
er
-members of the project's leadership.
-
-The project leadership team can be contacted by email as a whole at
+reported to the community leaders responsible for enforcement at
 git@sfconservancy.org, or individually:
=20
   - =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
@@ -79,12 +73,73 @@ git@sfconservancy.org, or individually:
   - Jeff King <peff@peff.net>
   - Junio C Hamano <gitster@pobox.com>
=20
+All complaints will be reviewed and investigated promptly and fairly.
+
+All community leaders are obligated to respect the privacy and security =
of the
+reporter of any incident.
+
+## Enforcement Guidelines
+
+Community leaders will follow these Community Impact Guidelines in deter=
mining
+the consequences for any action they deem in violation of this Code of C=
onduct:
+
+### 1. Correction
+
+**Community Impact**: Use of inappropriate language or other behavior de=
emed
+unprofessional or unwelcome in the community.
+
+**Consequence**: A private, written warning from community leaders, prov=
iding
+clarity around the nature of the violation and an explanation of why the
+behavior was inappropriate. A public apology may be requested.
+
+### 2. Warning
+
+**Community Impact**: A violation through a single incident or series
+of actions.
+
+**Consequence**: A warning with consequences for continued behavior. No
+interaction with the people involved, including unsolicited interaction =
with
+those enforcing the Code of Conduct, for a specified period of time. Thi=
s
+includes avoiding interactions in community spaces as well as external c=
hannels
+like social media. Violating these terms may lead to a temporary or
+permanent ban.
+
+### 3. Temporary Ban
+
+**Community Impact**: A serious violation of community standards, includ=
ing
+sustained inappropriate behavior.
+
+**Consequence**: A temporary ban from any sort of interaction or public
+communication with the community for a specified period of time. No publ=
ic or
+private interaction with the people involved, including unsolicited inte=
raction
+with those enforcing the Code of Conduct, is allowed during this period.
+Violating these terms may lead to a permanent ban.
+
+### 4. Permanent Ban
+
+**Community Impact**: Demonstrating a pattern of violation of community
+standards, including sustained inappropriate behavior,  harassment of an
+individual, or aggression toward or disparagement of classes of individu=
als.
+
+**Consequence**: A permanent ban from any sort of public interaction wit=
hin
+the community.
+
 ## Attribution
=20
-This Code of Conduct is adapted from the [Contributor Covenant][homepage=
], version 1.4,
-available at https://www.contributor-covenant.org/version/1/4/code-of-co=
nduct.html
+This Code of Conduct is adapted from the [Contributor Covenant][homepage=
],
+version 2.0, available at
+[https://www.contributor-covenant.org/version/2/0/code_of_conduct.html][=
v2.0].
+
+Community Impact Guidelines were inspired by=20
+[Mozilla's code of conduct enforcement ladder][Mozilla CoC].
+
+For answers to common questions about this code of conduct, see the FAQ =
at
+[https://www.contributor-covenant.org/faq][FAQ]. Translations are availa=
ble=20
+at [https://www.contributor-covenant.org/translations][translations].
=20
 [homepage]: https://www.contributor-covenant.org
+[v2.0]: https://www.contributor-covenant.org/version/2/0/code_of_conduct=
.html
+[Mozilla CoC]: https://github.com/mozilla/diversity
+[FAQ]: https://www.contributor-covenant.org/faq
+[translations]: https://www.contributor-covenant.org/translations
=20
-For answers to common questions about this code of conduct, see
-https://www.contributor-covenant.org/faq
--=20
2.30.0-374-g7778288579

