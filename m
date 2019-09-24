Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 794C11F463
	for <e@80x24.org>; Tue, 24 Sep 2019 06:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405443AbfIXGo5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Sep 2019 02:44:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:57966 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2391061AbfIXGo5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Sep 2019 02:44:57 -0400
Received: (qmail 3013 invoked by uid 109); 24 Sep 2019 06:44:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 24 Sep 2019 06:44:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7398 invoked by uid 111); 24 Sep 2019 06:47:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Sep 2019 02:47:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 24 Sep 2019 02:44:54 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     git@sfconservancy.org, Derrick Stolee <stolee@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, garimasigit@gmail.com
Subject: [PATCH] add a Code of Conduct document
Message-ID: <20190924064454.GA30419@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We've never had a formally written Code of Conduct document. Though it
has been discussed off and on over the years, for the most part the
behavior on the mailing list has been good enough that nobody felt the
need to push one forward.

However, even if there aren't specific problems now, it's a good idea to
have a document:

  - it puts everybody on the same page with respect to expectations.
    This might avoid poor behavior, but also makes it easier to handle
    it if it does happen.

  - it publicly advertises that good conduct is important to us and will
    be enforced, which may make some people more comfortable with
    joining our community

  - it may be a good time to cement our expectations when things are
    quiet, since it gives everybody some distance rather than focusing
    on a current contentious issue

This patch adapts the Contributor Covenant Code of Conduct. As opposed
to writing our own from scratch, this uses common and well-accepted
language, and strikes a good balance between illustrating expectations
and avoiding a laundry list of behaviors. It's also the same document
used by the Git for Windows project.

The text is taken mostly verbatim from:

  https://www.contributor-covenant.org/version/1/4/code-of-conduct.html

I also stole a very nice introductory paragraph from the Git for Windows
version of the file.

There are a few subtle points, though:

  - the document refers to "the project maintainers". For the code, we
    generally only consider there to be one maintainer: Junio C Hamano.
    But for dealing with community issues, it makes sense to involve
    more people to spread the responsibility. I've listed the project
    committee address of git@sfconservancy.org as the contact point.

  - the document mentions banning from the community, both in the intro
    paragraph and in "Our Responsibilities". The exact mechanism here is
    left vague. I can imagine it might start with social enforcement
    (not accepting patches, ignoring emails) and could escalate to
    technical measures if necessary (asking vger admins to block an
    address). It probably make sense _not_ to get too specific at this
    point, and deal with specifics as they come up.

Signed-off-by: Jeff King <peff@peff.net>
---
Obviously related to the discussion in:

  https://public-inbox.org/git/71fba9e7-6314-6ef9-9959-6ae06843d17a@gmail.com/

After some poking around at various CoC options, this one seemed like
the best fit to me. But I'm open to suggestions or more discussion. It
seems to me that the important piece is having _some_ CoC, and picking
something standard-ish seems a safe bet.

I did find this nice set of guidelines in an old discussion:

  https://github.com/mhagger/git/commit/c6e6196be8fab3d48b12c4e42eceae6937538dee

I think it's missing some things that are "standard" in more modern CoCs
(in particular, there's not much discussion of enforcement or
responsibilities, and I think those are important for the "making people
comfortable" goal). But maybe there are bits we'd like to pick out for
other documents; not so much "_what_ we expect" as "here are some tips
on _how_".

If people are on board with this direction, it might be fun to pick up a
bunch of "Acked-by" trailers from people in the community who agree with
it. It might give it more weight if many members have publicly endorsed
it.

I've cc'd git@sfconservancy.org here, because I think it's important for
all of the project committee members to endorse it (and because the
document puts us on the hook for enforcing it!).

 CODE_OF_CONDUCT.md | 85 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100644 CODE_OF_CONDUCT.md

diff --git a/CODE_OF_CONDUCT.md b/CODE_OF_CONDUCT.md
new file mode 100644
index 0000000000..b94f72b0b8
--- /dev/null
+++ b/CODE_OF_CONDUCT.md
@@ -0,0 +1,85 @@
+# Git Code of Conduct
+
+This code of conduct outlines our expectations for participants within
+the Git community, as well as steps for reporting unacceptable behavior.
+We are committed to providing a welcoming and inspiring community for
+all and expect our code of conduct to be honored. Anyone who violates
+this code of conduct may be banned from the community.
+
+## Our Pledge
+
+In the interest of fostering an open and welcoming environment, we as
+contributors and maintainers pledge to make participation in our project and
+our community a harassment-free experience for everyone, regardless of age,
+body size, disability, ethnicity, sex characteristics, gender identity and
+expression, level of experience, education, socio-economic status,
+nationality, personal appearance, race, religion, or sexual identity and
+orientation.
+
+## Our Standards
+
+Examples of behavior that contributes to creating a positive environment
+include:
+
+* Using welcoming and inclusive language
+* Being respectful of differing viewpoints and experiences
+* Gracefully accepting constructive criticism
+* Focusing on what is best for the community
+* Showing empathy towards other community members
+
+Examples of unacceptable behavior by participants include:
+
+* The use of sexualized language or imagery and unwelcome sexual attention or
+  advances
+* Trolling, insulting/derogatory comments, and personal or political attacks
+* Public or private harassment
+* Publishing others' private information, such as a physical or electronic
+  address, without explicit permission
+* Other conduct which could reasonably be considered inappropriate in a
+  professional setting
+
+## Our Responsibilities
+
+Project maintainers are responsible for clarifying the standards of acceptable
+behavior and are expected to take appropriate and fair corrective action in
+response to any instances of unacceptable behavior.
+
+Project maintainers have the right and responsibility to remove, edit, or
+reject comments, commits, code, wiki edits, issues, and other contributions
+that are not aligned to this Code of Conduct, or to ban temporarily or
+permanently any contributor for other behaviors that they deem inappropriate,
+threatening, offensive, or harmful.
+
+## Scope
+
+This Code of Conduct applies within all project spaces, and it also applies
+when an individual is representing the project or its community in public
+spaces. Examples of representing a project or community include using an
+official project e-mail address, posting via an official social media account,
+or acting as an appointed representative at an online or offline event.
+Representation of a project may be further defined and clarified by project
+maintainers.
+
+## Enforcement
+
+Instances of abusive, harassing, or otherwise unacceptable behavior may be
+reported by contacting the project team at git@sfconservancy.org. All
+complaints will be reviewed and investigated and will result in a response
+that is deemed necessary and appropriate to the circumstances. The project
+team is obligated to maintain confidentiality with regard to the reporter of
+an incident. Further details of specific enforcement policies may be posted
+separately.
+
+Project maintainers who do not follow or enforce the Code of Conduct in good
+faith may face temporary or permanent repercussions as determined by other
+members of the project's leadership.
+
+## Attribution
+
+This Code of Conduct is adapted from the [Contributor Covenant][homepage],
+version 1.4, available at https://www.contributor-covenant.org/version/1/4/code-of-conduct.html
+
+[homepage]: https://www.contributor-covenant.org
+
+For answers to common questions about this code of conduct, see
+https://www.contributor-covenant.org/faq
-- 
2.23.0.763.g3828a6cd7f

