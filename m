Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9346020248
	for <e@80x24.org>; Sun, 24 Mar 2019 16:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfCXQVm (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Mar 2019 12:21:42 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59380 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfCXQVm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Mar 2019 12:21:42 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 18F5F5B00B;
        Sun, 24 Mar 2019 12:21:38 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; s=sasl; bh=Eg8goRNRp60Fe
        wqnjSRDhvqjouI=; b=IWR7ms3F4T+SaK8REmnYraOH/qKvzRiGAuFkbGHoXwCOB
        yR3Uhj54frZf8pd7rlWw0XSv142W24h/lPoQFPR51VySMIndSZOPyHGtXKy77bZe
        0hABa1nzjxT4IznCamzZKhBrmwmSshcPj8OlXD25pNBozi7ik0DDtwz9SSonu0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; q=dns; s=sasl; b=InFSIqC
        i+6mEq1vs/WMi/VeiAC4bs91sHhpQomfFTXdmXdspmhxx7uMOzn4RNgO/9EJzp+Q
        aRUwFIDfRtFrK1fRqB1QhmVrP46pmq0zR2JT7M0HpuwMIrdAwaFj+jE7n+X/4z3O
        7OYFFuPcjY6VeYab9wNxS88IBSGe+OKjAHJQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 102AE5B00A;
        Sun, 24 Mar 2019 12:21:38 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [173.67.141.44])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A62905B009;
        Sun, 24 Mar 2019 12:21:34 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Date:   Sun, 24 Mar 2019 12:21:31 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] asciidoctor-extensions: provide `<refmiscinfo/>`
Message-ID: <20190324162131.GL4047@pobox.com>
References: <20190317144747.2418514-1-martin.agren@gmail.com>
 <20190317194431.GY31362@pobox.com>
 <CAN0heSrajiswzpm+au_5nmZMZG9406iZa-CK9p5CaHLTuxm8nw@mail.gmail.com>
 <20190320181715.GJ31362@pobox.com>
 <CAN0heSpJvsPm_qq63VumokmyOG6N=6fwMZRqf_9CzoCeHsdiyQ@mail.gmail.com>
 <20190323192756.GK4047@pobox.com>
 <20190324121619.GD312@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190324121619.GD312@sigill.intra.peff.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Pobox-Relay-ID: E487B5D6-4E50-11E9-8954-EE24A11ADF13-09356542!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff King wrote:
> On Sat, Mar 23, 2019 at 03:27:56PM -0400, Todd Zullinger wrote:
>=20
>> I updated my system to asciidoctor-2.0.0 last night and now
>> I can't even generate the man pages properly, because the
>> docbook45 converter was removed.  I'll have to see if I
>> missed some other required update. :/
>=20
> I ran into that, too. Using ASCIIDOC_DOCBOOK=3Ddocbook5 worked. The out=
put
> looked OK to me, but I only eyeballed it briefly. It's possible there
> are subtle problems.

Interesting.  I did that last night as well, but it only led
to more errors.  I'm curious why manpage builds work for you
and not for me.

On my fedora 29 test system, ASCIIDOC_DOCBOOK=3Ddocbook5 leads
to a validation failure from xmlto, since docbook5 doesn't
use a DTD=B9.  I added XMLTO_EXTRA =3D --skip-validation to the
USE_ASCIIDOCTOR block, which can build many of the man
pages, but fails when it gets to git-blame due to use of
literal < > characters in the xml:

    git-blame.xml:423: parser error : StartTag: invalid element name
    <literallayout class=3D"monospaced"><40-byte hex sha1> <sourceline> <=
resultline> <
                                       ^

While this may be a real issue in the formatting of
git-blame.txt which we should fix, I'm suspicious of that
due to the number of other files similarly affected:

    git-blame.txt
    git-diff-files.txt
    git-diff-index.txt
    git-diff-tree.txt
    git-diff.txt
    git-format-patch.txt
    git-http-fetch.txt
    git-log.txt
    git-rebase.txt
    git-rev-list.txt
    git-show.txt
    git-svn.txt

=B9 Here's the failure I get without --skip-validation:
[tmz@f29 Documentation]$ make USE_ASCIIDOCTOR=3D1 git.1
    SUBDIR ../
make[1]: 'GIT-VERSION-FILE' is up to date.
    ASCIIDOC git.xml
    XMLTO git.1
xmlto: /home/tmz/src/git/Documentation/git.xml does not validate (status =
3)
xmlto: Fix document syntax or use --skip-validation option
validity error : no DTD found!
Document /home/tmz/src/git/Documentation/git.xml does not validate
make: *** [Makefile:359: git.1] Error 13

Thanks,

--=20
Todd
