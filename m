Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB74C4332D
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 13:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1748022583
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 13:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729535AbgL1NAt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Dec 2020 08:00:49 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51170 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728158AbgL1NAp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Dec 2020 08:00:45 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DC26510F994;
        Mon, 28 Dec 2020 07:59:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=f30DQkoSrP7ntsvJ9Ho+0wPed
        H8=; b=FINszi2WtoMRJTAslOPL4U4LHrFc/HHY8/9XKQItnyA2kttFkAo59L6/b
        eqhumlFGzelcgLziavEiQ76v0ti3ntz1NaZGMD+T2Wj7I1JcIvol+ARQHuZVtctw
        c2MpRNtWFeHsK2YCRQHnovUNBfFnqNsirXQJIVpTAf+tHdaG4c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=iAS2Y1rxpBk0IaqfHuq
        ZK3Ng9GoMZbqVW+Mf7JYmLoA/N3T63zCQQDfII4SmJiB5ab1ZjWlqp17q3ynCNYS
        0a7YWA2/BzwWFat6vS2M6Et0xVNZ+KKIxhyAo600kc4qQmEToonO66HQ8H/WtOGj
        1q6SxS1Pt6qcrDqC1qv2D4Pw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D4E3110F993;
        Mon, 28 Dec 2020 07:59:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 24C3010F992;
        Mon, 28 Dec 2020 07:59:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] CoC: update to 2.0
Date:   Mon, 28 Dec 2020 04:59:53 -0800
Message-ID: <xmqq5z4mjdbq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 94E8D8B2-490C-11EB-84FA-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At 5cdf2301 (add a Code of Conduct document, 2019-09-24) we adopted
a Code of Conduct from www.contributor-covenant.org; back then the
version adopted, 1.4, was the latest one.

Version 2.0 tightens language in examples of unacceptable behaviour,
generalizes the audience from "contributors and maintainers" to
"community", and enhances the enforcement section.

The preamble we added to the beginning of the document has been
kept, but the rest of the test has been replaced in full from the
"upstream" and then the same customization for our community
(i.e. the way to contact community leadership teams) has been
applied.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * There was a thread to collect acks from community members at

    https://lore.kernel.org/git/xmqqd0f6n5a4.fsf_-_@gitster-ct.c.googlers=
.com/

   and that was how you now see many acks in the trailer of
   5cdf2301.  If we were to go ahead with this patch to move us to
   version 2.0, we'd need a similar "Ack" drive, I guess.

 CODE_OF_CONDUCT.md | 153 ++++++++++++++++++++++++++++++++++-------------=
------
 1 file changed, 99 insertions(+), 54 deletions(-)

diff --git c/CODE_OF_CONDUCT.md w/CODE_OF_CONDUCT.md
index fc4645d5c0..ac13a84d1a 100644
--- c/CODE_OF_CONDUCT.md
+++ w/CODE_OF_CONDUCT.md
@@ -8,86 +8,131 @@ this code of conduct may be banned from the community.
=20
 ## Our Pledge
=20
-In the interest of fostering an open and welcoming environment, we as
-contributors and maintainers pledge to make participation in our project=
 and
-our community a harassment-free experience for everyone, regardless of a=
ge,
-body size, disability, ethnicity, sex characteristics, gender identity a=
nd
-expression, level of experience, education, socio-economic status,
-nationality, personal appearance, race, religion, or sexual identity and
-orientation.
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
ies
-when an individual is representing the project or its community in publi=
c
-spaces. Examples of representing a project or community include using an
-official project e-mail address, posting via an official social media ac=
count,
-or acting as an appointed representative at an online or offline event.
-Representation of a project may be further defined and clarified by proj=
ect
-maintainers.
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
se
-that is deemed necessary and appropriate to the circumstances. The proje=
ct
-team is obligated to maintain confidentiality with regard to the reporte=
r of
-an incident. Further details of specific enforcement policies may be pos=
ted
-separately.
-
-Project maintainers who do not follow or enforce the Code of Conduct in =
good
-faith may face temporary or permanent repercussions as determined by oth=
er
-members of the project's leadership.
-
-The project leadership team can be contacted by email as a whole at
-git@sfconservancy.org, or individually:
+reported to the community leaders responsible for enforcement by
+email as a whole at git@sfconservancy.org, or individually:
=20
   - =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
   - Christian Couder <christian.couder@gmail.com>
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
],
-version 1.4, available at https://www.contributor-covenant.org/version/1=
/4/code-of-conduct.html
+This Code of Conduct is adapted from the Contributor Covenant,
+version 2.0, available at
+https://www.contributor-covenant.org/version/2/0/code_of_conduct.html.
=20
-[homepage]: https://www.contributor-covenant.org
+Community Impact Guidelines were inspired by
+Mozilla's code of conduct enforcement ladder.
=20
-For answers to common questions about this code of conduct, see
-https://www.contributor-covenant.org/faq
+For answers to common questions about this code of conduct, see the FAQ =
at
+https://www.contributor-covenant.org/faq. Translations are available
+at https://www.contributor-covenant.org/translations.
