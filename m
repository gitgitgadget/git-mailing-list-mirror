Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F34C820323
	for <e@80x24.org>; Wed, 22 Mar 2017 18:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935616AbdCVSCU (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 14:02:20 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50002 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934824AbdCVSCS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 14:02:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D65EB7A178;
        Wed, 22 Mar 2017 14:02:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=YGa/CcihJ8SA
        91VErt/iNLOdxJA=; b=M+uS6spubsMEstZlS1JRdW1u+hOoQcGzcaaVatJxO5ED
        ywRVIfl58sKPk0DQrzLTAJcP+n4S/WVI70Z1U9BT/Mi7dYyHJFfrCcB97h3bhee5
        xWm/NZFysoSplfKmzj4Cjp8zbq0ErXpFAu/gF4yTurCF5cpHQFnqLG/RNYWjuC0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Y+Vlrp
        tbSmUw6qTUtn5O282Bx3V4TpJCUY8Uy1XVR39KqerLqszULUgRK/WN8bgCeOfmWo
        F/87q4nXVgvFQE/VPeBo7N6P1Bx9UQtAS7I9YLsMeIrsKGf4aRjUjrTFAcK5kpOd
        kZkCfPxY1Hfar6VZnBcNzcHZ/Ogxw67LspChk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CE6297A177;
        Wed, 22 Mar 2017 14:02:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 409217A176;
        Wed, 22 Mar 2017 14:02:10 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Cc:     git <git@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] l10n: Add git-add.txt to localized man pages
References: <20170312200248.3610-1-jn.avila@free.fr>
        <20170320210225.13046-1-jn.avila@free.fr>
        <20170320210225.13046-3-jn.avila@free.fr>
        <xmqqpohbtxi3.fsf@gitster.mtv.corp.google.com>
        <5036581a-f989-2db6-06ba-621db05c6de1@free.fr>
Date:   Wed, 22 Mar 2017 11:02:09 -0700
In-Reply-To: <5036581a-f989-2db6-06ba-621db05c6de1@free.fr> (=?utf-8?Q?=22?=
 =?utf-8?Q?Jean-No=C3=ABl?=
        Avila"'s message of "Wed, 22 Mar 2017 13:01:31 +0100")
Message-ID: <xmqqpoh9kx5q.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AB75AEFA-0F29-11E7-AF83-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jean-No=C3=ABl Avila <jn.avila@free.fr> writes:

>> I am wondering if Documentation/po part should be a separate
>> repository, with a dedicated i18n/l10n coordinator.  Would it make
>> it easier for (1) those who write code and doc without knowing other
>> languages, (2) those who update .pot and coordinate the l10n effort
>> for the documentation and (3) those who translate them if we keep
>> them in a single repository?
>
> This is one of the points raised in the first RFC mail. Splitting this
> part would help a lot manage the translations with their own workflow,
> would not clutter the main repo with files not really needed for
> packaging and would simplify dealing with the interaction with crowd
> translation websites which can directly push translation content to a
> git repo.

As I was in favor of splitting it out, I was trying to gauge what
the downside of doing so would be, especially for those who are
doing the translation work (it is obvious that it would help
developers who are not translators, as nothing will change for them
if we keep this new thing as a separate project).

We may still want to fill in the details (and by doing so we may
discover it is not as easy as I make it sound to be here), but a
rough outline of what I think we could do is:

 * What you added to Documentation/po/ in these two patches becomes
   a separate project (let's call it "gitman-l10n") and they will be
   at the root level of the project, i.e. documentation.pot and
   documentation.$LANG.po will sit at the top level of the working
   tree of that project, without Documentation/po/ prefix. =20

   The idea is for some of us to have a checkout of "gitman-l10n"
   project inside Documentation/po of the checkout of git.git
   project and achieve a layout similar to what these two patches
   from you create, but keep that optional.

 * In git.git, teach Documentation/Makefile to enable "make
   doc-l10n" and "make install-l10n" targets in "Documentation/" if
   and only if Documentation/po/Makefile exists, and delegate these
   two targets to it, i.e. something like:

   (in Documentation/Makefile)
   ifeq ($(wildcard po/Makefile),po/Makefile)
   doc-l10n install-l10n::
	$(MAKE) -C po $@
   endif

   Certain Makefile macros Documentation/Makefile knows aboute
   (e.g. location to install, list of pages in the man1 section) may
   have to be exported down to Documentation/po/Makefile.

 * Some other Makefile targets to help i18n coordinator, e.g.
   updating Documentation/po/documentation.pot by using the latest
   set of Documentation/*.txt files, may also have to be added to
   Documentation/Makefile and conditionally enabled the same way
   (i.e. keying off of the presence of po/Makefile).

 * Those who work on the documentation translation and those who
   want to build and install localized documentation will have a
   checkout of the "gitman-l10n" project at "Documentation/po".
   This will _eventually_ be done by making "gitman-l10n" a
   submodule that git.git project uses, but it can start as a manual
   "clone and checkout" without making it a submodule.  Those who do
   not deal with localized manpages can just work with git.git
   proper without even knowing anything about the gitman-l10n
   project.

I'd prefer to start with the "optional gitman-l10n repository is
checked out at Documentation/po only by convention" approach, before
committing to bind it as a submodule.  Once we got comfortable with
cooperating between these two projects, we do want to bind them
using the submodule mechanism, but not before.

Once git.git starts binding the "gitman-l10n" project as its
submodule at "Documentation/po", we may want to start using "git
archive --recurse-submodules" when cutting a release tarball, when
that option becomes usable.

I'd prefer to start with the "main tarball" with "optional language
pack tarball" approach for releases, which is more flexible to the
end users (and less change to the workflow).  Once we gain more
experience, we may want to produce a single ball of wax tarball as
well (or "only a single one").

