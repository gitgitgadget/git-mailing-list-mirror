Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97FE71F4BE
	for <e@80x24.org>; Thu, 10 Oct 2019 00:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732140AbfJJASy (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Oct 2019 20:18:54 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:46262 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731553AbfJJASy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Oct 2019 20:18:54 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 73EB01F4BD;
        Thu, 10 Oct 2019 00:18:53 +0000 (UTC)
Date:   Thu, 10 Oct 2019 00:18:53 +0000
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Raise your hand to Ack jk/code-of-conduct if your Ack fell thru
 cracks
Message-ID: <20191010001853.h2pepvg7yilevipv@dcvr>
References: <xmqq36g5444k.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1910082111220.46@tvgsbejvaqbjf.bet>
 <xmqqd0f6n5a4.fsf_-_@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqd0f6n5a4.fsf_-_@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:

<snip>

> For reference, here is the CoC the patch wants to add (there is no
> such topic yet locally, nor a single patch that can be made into
> such a topic, so there isn't exactly something people can Ack on
> yet. So here is a "preview" of what we would see once such a series
> lands).
> 
>  CODE_OF_CONDUCT.md | 93 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
> 
> # Git Code of Conduct
> 
> This code of conduct outlines our expectations for participants within
> the Git community, as well as steps for reporting unacceptable behavior.
> We are committed to providing a welcoming and inspiring community for
> all and expect our code of conduct to be honored. Anyone who violates
> this code of conduct may be banned from the community.
> 
> ## Our Pledge
> 
> In the interest of fostering an open and welcoming environment, we as
> contributors and maintainers pledge to make participation in our project and
> our community a harassment-free experience for everyone, regardless of age,
> body size, disability, ethnicity, sex characteristics, gender identity and
> expression, level of experience, education, socio-economic status,
> nationality, personal appearance, race, religion, or sexual identity and
> orientation.
> 
> ## Our Standards
> 
> Examples of behavior that contributes to creating a positive environment
> include:
> 
> * Using welcoming and inclusive language

What's welcoming to some is repulsive to others.

For example: vger blocks HTML email.

IMHO it's the right thing to do since it blocks much spam and
phishing while saving precious storage and bandwidth.

However, other folks consider it "gatekeeping", because their
developed-by-a-megacorp mail tool defaults to HTML.  On the
other hand, I consider gatekeeping to be making things more
expensive in terms of computing resources.  Just because
Moore's law exists doesn't mean our contributors have the
socio-economic status to keep up with it.


Another example: "Fork me on GitXYZ!" which is intended to
welcome contributions.  For me, that's repulsive since it
requires:

1) using a Javascript VM (browser) that bogs my system down
2) accepting their Terms of Service (which can change at any time)
3) doing a CAPTCHA
4) contributing via such service(s) implies tacit endorsement of
   a proprietary/open-core SAAS

git remains one of the few projects I'm comfortable contributing
to because of that.

> * Being respectful of differing viewpoints and experiences

Agreed.  And we should not be trying to please everybody.

> * Gracefully accepting constructive criticism
> * Focusing on what is best for the community
> * Showing empathy towards other community members
> 
> Examples of unacceptable behavior by participants include:
> 
> * The use of sexualized language or imagery and unwelcome sexual attention or
>   advances
> * Trolling, insulting/derogatory comments, and personal or political attacks
> * Public or private harassment

> * Publishing others' private information, such as a physical or electronic
>   address, without explicit permission

Very much agreed on keeping private information private.
I honestly wished we'd just allow anonymous contributions since
identity verification is and ought to remain impossible; but
I understand there's legal concerns about GPL enforcement, too.

> * Other conduct which could reasonably be considered inappropriate in a
>   professional setting

I've been sometimes considered "unprofessional" for sticking to
plain-text mail/IRC, refusing to deal with video conferencing,
proprietary/hosted chat, etc.  To me, it's about cost-cutting
and minimizing security risks, but I don't work with some people
because of it.  Outside of open source, it's also about preserving
trade secrets.

> ## Our Responsibilities
> 
> Project maintainers are responsible for clarifying the standards of acceptable
> behavior and are expected to take appropriate and fair corrective action in
> response to any instances of unacceptable behavior.
> 
> Project maintainers have the right and responsibility to remove, edit, or
> reject comments, commits, code, wiki edits, issues, and other contributions
> that are not aligned to this Code of Conduct, or to ban temporarily or
> permanently any contributor for other behaviors that they deem inappropriate,
> threatening, offensive, or harmful.
> 
> ## Scope
> 
> This Code of Conduct applies within all project spaces, and it also applies
> when an individual is representing the project or its community in public
> spaces. Examples of representing a project or community include using an
> official project e-mail address, posting via an official social media account,
> or acting as an appointed representative at an online or offline event.
> Representation of a project may be further defined and clarified by project
> maintainers.
> 
> ## Enforcement
> 
> Instances of abusive, harassing, or otherwise unacceptable behavior may be
> reported by contacting the project team at git@sfconservancy.org. All
> complaints will be reviewed and investigated and will result in a response
> that is deemed necessary and appropriate to the circumstances. The project
> team is obligated to maintain confidentiality with regard to the reporter of
> an incident. Further details of specific enforcement policies may be posted
> separately.

Given the absence of identity verification on the Internet
(which I'm thankful for), enforcement seems toothless.

> Project maintainers who do not follow or enforce the Code of Conduct in good
> faith may face temporary or permanent repercussions as determined by other
> members of the project's leadership.
> 
> The project leadership team can be contacted by email as a whole at
> git@sfconservancy.org, or individually:
> 
>   - Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>   - Christian Couder <christian.couder@gmail.com>
>   - Jeff King <peff@peff.net>
>   - Junio C Hamano <gitster@pobox.com>

All folks that have proven to exhibit good judgement in the past,
and hope they continue to exhibit that in the future.

Though we shouldn't forget unexpected things have happened
in the past, such as SFLC suing SFC...


Just pointing out some concerns of mine.  No ack from me
(but it's not a NACK, either).  I'm pretty ambivalent...
