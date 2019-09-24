Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A81F21F463
	for <e@80x24.org>; Tue, 24 Sep 2019 17:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394283AbfIXRMU (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Sep 2019 13:12:20 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40043 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393616AbfIXRMU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Sep 2019 13:12:20 -0400
Received: by mail-pl1-f196.google.com with SMTP id d22so1259689pll.7
        for <git@vger.kernel.org>; Tue, 24 Sep 2019 10:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KAFJF+8OxPowzrIfF+qL98lUWusYdhahCalGoRye3A4=;
        b=W6amXuLxdHhiC78wNcGgmyoAqO8WrbUomFaiIKyg769Y7QBOAFXYMaleVONl3vaZl1
         tziD28lrz0z1ijD+At8Sc/Ukrj/jFc+Bvwaq951lBuD0nJ1BJFlPSadjZgvqkzZj43d9
         tEee3GqjkyHwodYrRPrJLRsDudcuxvR9zp4bEXPVqKUD4V4GkRc3nQI84XfywOw3ogMC
         F2Gaa0t7nkXiPxsFoUJxTgu6fM2u1dIwaQbZAUTc7y10qYiYHvDqCvIiv2FRjQmka7t2
         qYtazS4LkkmjzX/pm61iSkqSGhfhexp5DO4rfgdv3w95QVXWp7CZ2XW+zBUzWkgpOg74
         KBIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KAFJF+8OxPowzrIfF+qL98lUWusYdhahCalGoRye3A4=;
        b=gteSl5gj8qO77D4m/jbBtWT2llcqRV7iPpCTo4IWhA+lGigV5kskXhjhOQDzeJkVyD
         I7ux7HXwXcXAoUjqNHIxlp9Ngv63n1MxPC/FJbKtiEk9BIGK5OngurxbMBSrwWZlXILc
         93OZVXwzPGsDFpCMJb2qnzHPvvHvQZ3d3QkFfh3NxjQ3mkV+axyz3vOiOg3UZEl53rgN
         Q8p3JOQgPuBpTt+RzswJS4utz0tBZCGI3mNFy5EphoCEXu1bF6XHDsOGPZ3rZrYCjofL
         VOYgH8CSXCspPQWxR4DmBEY8w+xCYypUr6H5t7+2tmOfvSI/wBQ2Oldc6d6Q3v34LFZ1
         qkfw==
X-Gm-Message-State: APjAAAXhXGz/5PGiJEGyHaqWo9vYVxCCHwgcD87XHwVifhxOEyt9t5Pl
        /dyAF9QQ2w0aqcpvLDb3egs=
X-Google-Smtp-Source: APXvYqyinkPibuIhf8kTD1ocY/tEQ8EcJdr5a/9Y2Gmm82Pw1abDtn1F368w/uyQVHxN8DtyUhonhQ==
X-Received: by 2002:a17:902:6945:: with SMTP id k5mr3906182plt.203.1569345138236;
        Tue, 24 Sep 2019 10:12:18 -0700 (PDT)
Received: from dentonliu-ltm.internal.salesforce.com ([204.14.239.55])
        by smtp.gmail.com with ESMTPSA id z23sm2038025pgi.78.2019.09.24.10.12.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Sep 2019 10:12:16 -0700 (PDT)
Date:   Tue, 24 Sep 2019 10:12:14 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, git@sfconservancy.org,
        Derrick Stolee <stolee@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, garimasigit@gmail.com
Subject: Re: [PATCH] add a Code of Conduct document
Message-ID: <20190924171214.GA11452@dentonliu-ltm.internal.salesforce.com>
References: <20190924064454.GA30419@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924064454.GA30419@sigill.intra.peff.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 24, 2019 at 02:44:54AM -0400, Jeff King wrote:
> We've never had a formally written Code of Conduct document. Though it
> has been discussed off and on over the years, for the most part the
> behavior on the mailing list has been good enough that nobody felt the
> need to push one forward.
> 
> However, even if there aren't specific problems now, it's a good idea to
> have a document:
> 
>   - it puts everybody on the same page with respect to expectations.
>     This might avoid poor behavior, but also makes it easier to handle
>     it if it does happen.
> 
>   - it publicly advertises that good conduct is important to us and will
>     be enforced, which may make some people more comfortable with
>     joining our community
> 
>   - it may be a good time to cement our expectations when things are
>     quiet, since it gives everybody some distance rather than focusing
>     on a current contentious issue
> 
> This patch adapts the Contributor Covenant Code of Conduct. As opposed
> to writing our own from scratch, this uses common and well-accepted
> language, and strikes a good balance between illustrating expectations
> and avoiding a laundry list of behaviors. It's also the same document
> used by the Git for Windows project.
> 
> The text is taken mostly verbatim from:
> 
>   https://www.contributor-covenant.org/version/1/4/code-of-conduct.html
> 
> I also stole a very nice introductory paragraph from the Git for Windows
> version of the file.
> 
> There are a few subtle points, though:
> 
>   - the document refers to "the project maintainers". For the code, we
>     generally only consider there to be one maintainer: Junio C Hamano.
>     But for dealing with community issues, it makes sense to involve
>     more people to spread the responsibility. I've listed the project
>     committee address of git@sfconservancy.org as the contact point.
> 
>   - the document mentions banning from the community, both in the intro
>     paragraph and in "Our Responsibilities". The exact mechanism here is
>     left vague. I can imagine it might start with social enforcement
>     (not accepting patches, ignoring emails) and could escalate to
>     technical measures if necessary (asking vger admins to block an
>     address). It probably make sense _not_ to get too specific at this
>     point, and deal with specifics as they come up.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Obviously related to the discussion in:
> 
>   https://public-inbox.org/git/71fba9e7-6314-6ef9-9959-6ae06843d17a@gmail.com/
> 
> After some poking around at various CoC options, this one seemed like
> the best fit to me. But I'm open to suggestions or more discussion. It
> seems to me that the important piece is having _some_ CoC, and picking
> something standard-ish seems a safe bet.
> 
> I did find this nice set of guidelines in an old discussion:
> 
>   https://github.com/mhagger/git/commit/c6e6196be8fab3d48b12c4e42eceae6937538dee
> 
> I think it's missing some things that are "standard" in more modern CoCs
> (in particular, there's not much discussion of enforcement or
> responsibilities, and I think those are important for the "making people
> comfortable" goal). But maybe there are bits we'd like to pick out for
> other documents; not so much "_what_ we expect" as "here are some tips
> on _how_".
> 
> If people are on board with this direction, it might be fun to pick up a
> bunch of "Acked-by" trailers from people in the community who agree with
> it. It might give it more weight if many members have publicly endorsed
> it.
> 
> I've cc'd git@sfconservancy.org here, because I think it's important for
> all of the project committee members to endorse it (and because the
> document puts us on the hook for enforcing it!).

I tried looking it up but I couldn't find who the project committee
members are. Is this list published anywhere? More on that later...

> 
>  CODE_OF_CONDUCT.md | 85 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 85 insertions(+)
>  create mode 100644 CODE_OF_CONDUCT.md
> 
> diff --git a/CODE_OF_CONDUCT.md b/CODE_OF_CONDUCT.md
> new file mode 100644
> index 0000000000..b94f72b0b8
> --- /dev/null
> +++ b/CODE_OF_CONDUCT.md
> @@ -0,0 +1,85 @@
> +# Git Code of Conduct
> +
> +This code of conduct outlines our expectations for participants within
> +the Git community, as well as steps for reporting unacceptable behavior.
> +We are committed to providing a welcoming and inspiring community for
> +all and expect our code of conduct to be honored. Anyone who violates
> +this code of conduct may be banned from the community.
> +
> +## Our Pledge
> +
> +In the interest of fostering an open and welcoming environment, we as
> +contributors and maintainers pledge to make participation in our project and
> +our community a harassment-free experience for everyone, regardless of age,
> +body size, disability, ethnicity, sex characteristics, gender identity and
> +expression, level of experience, education, socio-economic status,
> +nationality, personal appearance, race, religion, or sexual identity and
> +orientation.
> +
> +## Our Standards
> +
> +Examples of behavior that contributes to creating a positive environment
> +include:
> +
> +* Using welcoming and inclusive language
> +* Being respectful of differing viewpoints and experiences
> +* Gracefully accepting constructive criticism
> +* Focusing on what is best for the community
> +* Showing empathy towards other community members
> +
> +Examples of unacceptable behavior by participants include:
> +
> +* The use of sexualized language or imagery and unwelcome sexual attention or
> +  advances
> +* Trolling, insulting/derogatory comments, and personal or political attacks
> +* Public or private harassment
> +* Publishing others' private information, such as a physical or electronic
> +  address, without explicit permission

Since this is a mailing list-based project, we should explicitly state
that email addresses and names don't count as private information since
it's vital for discourse.

On that note, I like the idea of having a CoC-interpretations document,
much like the one in the Linux kernel[1]. In my opinion, having one
would remove a lot of the vagueness (such as the emails issue) in the
CoC and close us off from people loophole lawyering over the language
used.

> +* Other conduct which could reasonably be considered inappropriate in a
> +  professional setting
> +
> +## Our Responsibilities
> +
> +Project maintainers are responsible for clarifying the standards of acceptable
> +behavior and are expected to take appropriate and fair corrective action in
> +response to any instances of unacceptable behavior.
> +
> +Project maintainers have the right and responsibility to remove, edit, or
> +reject comments, commits, code, wiki edits, issues, and other contributions

Since we use patches here, we should probably explicitly state that too.

> +that are not aligned to this Code of Conduct, or to ban temporarily or
> +permanently any contributor for other behaviors that they deem inappropriate,
> +threatening, offensive, or harmful.
> +
> +## Scope
> +
> +This Code of Conduct applies within all project spaces, and it also applies
> +when an individual is representing the project or its community in public
> +spaces. Examples of representing a project or community include using an
> +official project e-mail address, posting via an official social media account,
> +or acting as an appointed representative at an online or offline event.
> +Representation of a project may be further defined and clarified by project
> +maintainers.
> +
> +## Enforcement
> +
> +Instances of abusive, harassing, or otherwise unacceptable behavior may be
> +reported by contacting the project team at git@sfconservancy.org. All
> +complaints will be reviewed and investigated and will result in a response
> +that is deemed necessary and appropriate to the circumstances. The project
> +team is obligated to maintain confidentiality with regard to the reporter of
> +an incident. Further details of specific enforcement policies may be posted
> +separately.

I feel uncomfortable with this being left so wide open. First of all, I
know that the power *probably* won't be abused but I don't think
probably is good enough.

As I said above, I couldn't find a public list of the people who were on
the project committee. Perhaps that's because my Googling skills are bad
but I feel uncomfortable knowing that *anyone* will be given judge, jury
and executioner power, let alone people whom I don't know anything
about.

I'm okay with leaving it open for now but I think I would be a lot more
comfortable if we had the interpretations document to close up the
vagueness later.

Thanks for starting the discussion,

Denton

[1]: https://github.com/torvalds/linux/blob/master/Documentation/process/code-of-conduct-interpretation.rst

> +
> +Project maintainers who do not follow or enforce the Code of Conduct in good
> +faith may face temporary or permanent repercussions as determined by other
> +members of the project's leadership.
> +
> +## Attribution
> +
> +This Code of Conduct is adapted from the [Contributor Covenant][homepage],
> +version 1.4, available at https://www.contributor-covenant.org/version/1/4/code-of-conduct.html
> +
> +[homepage]: https://www.contributor-covenant.org
> +
> +For answers to common questions about this code of conduct, see
> +https://www.contributor-covenant.org/faq
> -- 
> 2.23.0.763.g3828a6cd7f
> 
