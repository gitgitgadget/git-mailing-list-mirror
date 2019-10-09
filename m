Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A1D01F4BD
	for <e@80x24.org>; Wed,  9 Oct 2019 00:15:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729918AbfJIAPG (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 20:15:06 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53901 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728792AbfJIAPF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 20:15:05 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 37A528362D;
        Tue,  8 Oct 2019 20:15:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Z02s2UsgEJDs
        lACgXKxXG8RiLDk=; b=TyCB7FQIAMF1ySc0Jwjnf9Sw+J5mTL2SOuHMDlvS3sdf
        CbdIDUW9ctsZzElneiOfYOoUS6imxdhkF90L6TMkwN4ynm8wuOQcpzzM+rd0BQhF
        T+bh6gMmibEiLFvRSLGo3nKjj/ssbSywkif8tZbcTAAaH1TmhNJfS7HPqmMTETs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=dDHz3K
        aSzxvQ/sIdkPYh7Gct5f672bgF3Cuj4NqswOeokqzSf3+8LkgKpWG1N5OUv9py6w
        5ExFPlPBQnDoffm+x2/H8qoMYnooWJlCqfBNjw/xtMcdq0fBypisTUf6ij5a1TZ0
        v4r4kzIbH1ptSomnl7NrMi6hIOGqM8kFEgK5s=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2F5D48362C;
        Tue,  8 Oct 2019 20:15:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CB77E8362A;
        Tue,  8 Oct 2019 20:15:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Raise your hand to Ack jk/code-of-conduct if your Ack fell thru cracks
References: <xmqq36g5444k.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1910082111220.46@tvgsbejvaqbjf.bet>
Date:   Wed, 09 Oct 2019 09:14:59 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1910082111220.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 8 Oct 2019 21:36:26 +0200 (CEST)")
Message-ID: <xmqqd0f6n5a4.fsf_-_@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D61FCCAC-EA29-11E9-8872-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> In other words, the commit message can be augmented by this:
>
> Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Acked-by: Derrick Stolee <stolee@gmail.com>
> Acked-by: Garima Singh <garimasigit@gmail.com>
> Acked-by: Jonathan Tan <jonathantanmy@google.com>
> Acked-by: Thomas Gummerer <t.gummerer@gmail.com>
> Acked-by: brian m. carlson <sandals@crustytoothpaste.net>
> Acked-by: Elijah Newren <newren@gmail.com>
>
> Junio, would you mind picking it up, please?

I trust you enough that I won't go back to the cited messages to
double check that these acks are real, but I'd still wait for a few
days for people who expressed their Acks but your scan missed, or
those who wanted to give their Acks but forgot to do so, to raise
their hands on this thread.

Thanks for starting the concluding move on this topic.

For reference, here is the CoC the patch wants to add (there is no
such topic yet locally, nor a single patch that can be made into
such a topic, so there isn't exactly something people can Ack on
yet. So here is a "preview" of what we would see once such a series
lands).

 CODE_OF_CONDUCT.md | 93 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++++

# Git Code of Conduct

This code of conduct outlines our expectations for participants within
the Git community, as well as steps for reporting unacceptable behavior.
We are committed to providing a welcoming and inspiring community for
all and expect our code of conduct to be honored. Anyone who violates
this code of conduct may be banned from the community.

## Our Pledge

In the interest of fostering an open and welcoming environment, we as
contributors and maintainers pledge to make participation in our project =
and
our community a harassment-free experience for everyone, regardless of ag=
e,
body size, disability, ethnicity, sex characteristics, gender identity an=
d
expression, level of experience, education, socio-economic status,
nationality, personal appearance, race, religion, or sexual identity and
orientation.

## Our Standards

Examples of behavior that contributes to creating a positive environment
include:

* Using welcoming and inclusive language
* Being respectful of differing viewpoints and experiences
* Gracefully accepting constructive criticism
* Focusing on what is best for the community
* Showing empathy towards other community members

Examples of unacceptable behavior by participants include:

* The use of sexualized language or imagery and unwelcome sexual attentio=
n or
  advances
* Trolling, insulting/derogatory comments, and personal or political atta=
cks
* Public or private harassment
* Publishing others' private information, such as a physical or electroni=
c
  address, without explicit permission
* Other conduct which could reasonably be considered inappropriate in a
  professional setting

## Our Responsibilities

Project maintainers are responsible for clarifying the standards of accep=
table
behavior and are expected to take appropriate and fair corrective action =
in
response to any instances of unacceptable behavior.

Project maintainers have the right and responsibility to remove, edit, or
reject comments, commits, code, wiki edits, issues, and other contributio=
ns
that are not aligned to this Code of Conduct, or to ban temporarily or
permanently any contributor for other behaviors that they deem inappropri=
ate,
threatening, offensive, or harmful.

## Scope

This Code of Conduct applies within all project spaces, and it also appli=
es
when an individual is representing the project or its community in public
spaces. Examples of representing a project or community include using an
official project e-mail address, posting via an official social media acc=
ount,
or acting as an appointed representative at an online or offline event.
Representation of a project may be further defined and clarified by proje=
ct
maintainers.

## Enforcement

Instances of abusive, harassing, or otherwise unacceptable behavior may b=
e
reported by contacting the project team at git@sfconservancy.org. All
complaints will be reviewed and investigated and will result in a respons=
e
that is deemed necessary and appropriate to the circumstances. The projec=
t
team is obligated to maintain confidentiality with regard to the reporter=
 of
an incident. Further details of specific enforcement policies may be post=
ed
separately.

Project maintainers who do not follow or enforce the Code of Conduct in g=
ood
faith may face temporary or permanent repercussions as determined by othe=
r
members of the project's leadership.

The project leadership team can be contacted by email as a whole at
git@sfconservancy.org, or individually:

  - =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
  - Christian Couder <christian.couder@gmail.com>
  - Jeff King <peff@peff.net>
  - Junio C Hamano <gitster@pobox.com>

## Attribution

This Code of Conduct is adapted from the [Contributor Covenant][homepage]=
,
version 1.4, available at https://www.contributor-covenant.org/version/1/=
4/code-of-conduct.html

[homepage]: https://www.contributor-covenant.org

For answers to common questions about this code of conduct, see
https://www.contributor-covenant.org/faq

