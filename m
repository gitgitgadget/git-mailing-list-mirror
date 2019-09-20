Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0044D1F463
	for <e@80x24.org>; Fri, 20 Sep 2019 15:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388766AbfITPQk convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 20 Sep 2019 11:16:40 -0400
Received: from elephants.elehost.com ([216.66.27.132]:27024 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387693AbfITPQk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Sep 2019 11:16:40 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x8KFGZqe079886
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 20 Sep 2019 11:16:36 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        "'Derrick Stolee'" <stolee@gmail.com>
Cc:     <git@vger.kernel.org>, <peff@peff.net>,
        "'Emily Shaffer'" <emilyshaffer@google.com>,
        "'Jonathan Nieder'" <jrnieder@gmail.com>,
        "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>,
        <gitster@pobox.com>, <garimasigit@gmail.com>
References: <71fba9e7-6314-6ef9-9959-6ae06843d17a@gmail.com> <20190920143614.GB20698@genre.crustytoothpaste.net>
In-Reply-To: <20190920143614.GB20698@genre.crustytoothpaste.net>
Subject: RE: [DISCUSSION] Growing the Git community
Date:   Fri, 20 Sep 2019 11:16:28 -0400
Message-ID: <01ee01d56fc6$64093370$2c1b9a50$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQH1Bv7ydD5TzHcUGE9EAY1wzjLs9wCbpDHxpvCfEAA=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On September 20, 2019 10:36 AM, brian m. carlson wrote:
> To: Derrick Stolee <stolee@gmail.com>
> Cc: git@vger.kernel.org; peff@peff.net; Emily Shaffer
> <emilyshaffer@google.com>; Jonathan Nieder <jrnieder@gmail.com>;
> Johannes Schindelin <Johannes.Schindelin@gmx.de>; gitster@pobox.com;
> garimasigit@gmail.com
> Subject: Re: [DISCUSSION] Growing the Git community
> 
> On 2019-09-19 at 16:30:13, Derrick Stolee wrote:
> > 1. Improve the documentation for contributing to Git.
> >
> > In preparation for this email, I talked to someone familiar with
> > issues around new contributors, and they sat down to try and figure
> > out how to contribute to Git. The first place they went was
> > https://github.com/git/git and looked at the README. It takes deep
> > reading of a paragraph to see a link to the SubmittingPatches docs.
> >
> > To improve this experience, we could rewrite the README to have
> > clearer section markers, including one "Contributing to Git" section
> > relatively high in the doc. We may want to update the README for multiple
> reasons.
> > It should link to the new "My First Contribution" document
> > (https://git-scm.com/docs/MyFirstContribution).
> 
> I think there's a lot of improvements we could make here, and I know that
> many folks are already working on contributor documentation.
> That's enormously valuable work, and I'm pleased to see it going on.
> 
> > 2. Add more pointers to GitGitGadget
> >
> > We have a reference to GitGitGadget in the GitHub PR template to try
> > and get people who try to submit a pull request to git/git to instead
> > create one on GitGitGadget. However, that captures contributors who
> > didn't read the docs about how to submit! (This is somewhat covered by
> > the "My First Contribution" doc as well, so making that more visible
> > will also help.)
> 
> I think GitGitGadget is a useful tool which I haven't really had the time to
> learn how to use.  I appreciate that many people prefer a patch-based
> workflow, and that using a patch-based workflow and a mailing list provides
> the project independence and avoids favoring any hosting platform or tool,
> which I agree with.
> 
> I think also that many folks find a pull request-based workflow to be easier
> and more familiar and supporting this a bit better may lower the barrier to
> entry, so I'm in favor of bridges that make contributing easier, even if one
> still needs to subscribe to the list to get feedback.
> 
> > 4. Add an official Code of Conduct
> >
> > So far, the community has had an unofficial policy of "be nice, as
> > much as possible". We should add a Code of Conduct that is more
> > explicit about the behavior we want to model. This was also discussed
> > in the meeting with wide approval.
> 
> I think this is a good idea.  We already document how to contribute to the
> community by sending a bug report or a patch: how to format your emails,
> how to sign off your patches, and how to write a good commit message.  I
> see a code of conduct as another way to do this by documenting our social
> norms much as we document the way our contributions should look
> technically.
> 
> I also know in the past we have had problems with a contributor who was
> being argumentative and disagreeable.  I think documenting the kind of
> behavior we want to see both helps individuals ask themselves if their own
> behavior is helping us provide a positive community and helps other
> contributors provide feedback about unhelpful or unacceptable behavior on
> the rare occasion that we see it.
> 
> Lest I give the impression otherwise, I think that overall the Git community is
> quite welcoming and positive, and I anticipate that it will continue to remain
> that way.  I expect that the difference in behavior on the list if we adopt a
> code of conduct will be small, since so far pretty much everyone seems to be
> engaging in productive, helpful ways.
> 
> However, I know that many folks from underrepresented groups in tech feel
> more comfortable when there's a code of conduct because it signals to them
> that the project cares about fostering a respectful, healthy community and
> that their contributions are likely to be welcomed.  I recommend the
> Contributor Covenant for this purpose, since it is well known, well accepted,
> and is used by numerous other FLOSS projects.

Speak as one of those from two very specific underrepresented groups, I have found the committers and reviewers welcoming (and sometimes rightly and deservedly harsh when it was warranted). Although I only have a small number of contributions, I have not found there to be any glaring gaps in the implied policies that have grown organically in the team to this point and hope that we do not become overly formalized as that will, in my experience, push people away. The organic policies of this group are very closely aligned with the Contributor Covenant used by FLOSS - close enough that perhaps only a semanticist will find a difference, so I do find Brian's suggestion to be supportable.

Kind Regards,
Randall

-- Brief whoami:
NonStop developer since approximately 211288444200000000
UNIX developer since approximately 421664400
Not admitting my MVS experience at this point
-- In my real life, I talk too much.



