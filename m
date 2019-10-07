Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48BEA1F4BD
	for <e@80x24.org>; Mon,  7 Oct 2019 01:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfJGBj2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Oct 2019 21:39:28 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53227 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbfJGBj2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Oct 2019 21:39:28 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CC02D24191;
        Sun,  6 Oct 2019 21:39:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HLOMiwTm+DF4+XMb+OqaoH+Z0Ec=; b=hhx5A9
        egrI47EfqLgFcAttWj4ggKTellc15H4isDn/C/dsr9SVg7aoK9B2vuGhi0VaiCjO
        bF8jpLdKhIIGcVkELmPLhUtgn7/mXaxQnWF0Z0fhQbvJBM8h4/CJRCgR4ydUW33H
        e5pDFASHstcAJHmd8mO9m9URWayZDKd04cL9A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hsW6uVoNqRSAD9eSGjXjJhGbVG2TppGY
        R+wqUYcy/0oU+E0M40haM2hi64w9hqeOSi0j53HLqsFu9pj6jHdfgSPwHT1LAwat
        KYKZSITSDrrwtcBKww55cT48zx1c3y66U5df+TsJpA0LXZmhIun41YT+cHqc2OEt
        eEUr2k8Lekc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C283724190;
        Sun,  6 Oct 2019 21:39:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 36AB32418E;
        Sun,  6 Oct 2019 21:39:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     <git@vger.kernel.org>, Bert Wesarg <bert.wesarg@googlemail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] git-gui: add a readme
References: <20191004221052.23313-1-me@yadavpratyush.com>
        <20191006220935.31766-1-me@yadavpratyush.com>
Date:   Mon, 07 Oct 2019 10:39:24 +0900
In-Reply-To: <20191006220935.31766-1-me@yadavpratyush.com> (Pratyush Yadav's
        message of "Mon, 7 Oct 2019 03:39:35 +0530")
Message-ID: <xmqqimp149mb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4B50BECE-E8A3-11E9-BD90-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pratyush Yadav <me@yadavpratyush.com> writes:

>     -+# Git Gui - A graphical user interface for Git
>     ++# Git GUI - A graphical user interface for Git
>      +
>     -+Git Gui is a GUI for [git](https://git-scm.com/) written in Tcl/Tk. It allows
>     -+you to use the git source control management tools via a GUI. This includes
>     ++Git GUI is a GUI for [Git](https://git-scm.com/) written in Tcl/Tk. It allows
>     ++you to use the Git source control management tools via a GUI. This includes

(ignore me if this has been discussed already)

The first sentence looks overly repeticious (it just looks to me as
if saying "Git GUI is a Git GUI written in Tcl/Tk").  Saying

	Git GUI allows you to use the [Git source control management
	tools](https://git-scm.com/) via a GUI and is written in
	Tcl/Tk.  This includes ...

may reduce the repetition somewhat.  Also if I were writing this
intro, I'd move "writtein in Tcl/Tk" to a lot later or perhaps just
drop the phrase from here; what the users can gain from the tool is
much more important to the readers of this document than its
implementation detail.  "Written in Tcl" is given in the installation
section anyway.

>      +staging, commiting, adding, pushing, etc. It can also be used as a blame
>      +viewer, a tree browser, and a citool (make exactly one commit before exiting
>      +and returning to shell). More details about git-gui can be found in its manual
>      +page by either running `man git-gui`, or by visiting the [online manual
>      +page](https://git-scm.com/docs/git-gui).
>      +
>     -+Git Gui was initially written by Shawn O. Pearce, and is distributed with the
>     -+standard git installation.
>     ++Git GUI was initially written by Shawn O. Pearce, and is distributed with the
>     ++standard Git installation.
>      +
>      +# Building and installing
>      +
>     -+Most of Git Gui is written in Tcl, so there is not much compilation involved.
>     -+Still, some things do need to be done, so you do need to "build" it.
>     ++Most of Git GUI is written in Tcl, so there is no compilation involved. Still,
>     ++some things do need to be done (mostly some substitutions), so you do need to
>     ++"build" it.

It is a good thing to say that it is written in Tcl for two
reasons..  The users need to know (1) they need to know Tcl/Tk to
hack on it, and (2) they need to install "wish" as a prerequisite to
run it.  

Does the document mention the latter explicitly?  If it does not, it
probably should.  Also it helps to have msgfmt installed when
building git-gui.  That also should be mentioned.

