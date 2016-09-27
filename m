Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE4A420986
	for <e@80x24.org>; Tue, 27 Sep 2016 17:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934755AbcI0RhA (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 13:37:00 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54391 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751325AbcI0Rg7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 13:36:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D3AD13D066;
        Tue, 27 Sep 2016 13:36:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JscCQQMI20BDUk0yX0GLPdjkXYM=; b=YDLQ8M
        8fRFVV1ikocFUiGEjfjZUcfb9M0jsOm7BBGO44kiMPlU+sXZOZx43S/8mOpzAOfn
        FxYgCcW6ynE9QdoFoM0LRz2OktjaMVkTqx85Wkm1Mb16zXydBROo4AVTJsTJNYcn
        uug9SEqDIqQFG4hWx9/0ACWRijE9+xW5j1i9k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iQ1uoW1lqnWc4AlT/QqTD7ZLK6yxDna5
        244B9DorrEWH1NlnYyak7lhjdcIfsYGP+k6qjyTKo5XQdxW8or5kG09350+Ujky3
        P41ZXO1ED9oyzhLgDc9GbukhGZtQe7rVP4t9MlywcruUEJAjHZMpnK7YUylBO3fC
        aFWujsB4yOA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CB12C3D065;
        Tue, 27 Sep 2016 13:36:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4F6AE3D064;
        Tue, 27 Sep 2016 13:36:57 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     santiago@nyu.edu
Cc:     git@vger.kernel.org, peff@peff.net, sunshine@sunshineco.com,
        walters@verbum.org, Lukas P <luk.puehringer@gmail.com>
Subject: Re: [PATCH v2 1/5] gpg-interface, tag: add GPG_VERIFY_QUIET flag
References: <20160926224233.32702-1-santiago@nyu.edu>
        <20160926224233.32702-2-santiago@nyu.edu>
Date:   Tue, 27 Sep 2016 10:36:55 -0700
In-Reply-To: <20160926224233.32702-2-santiago@nyu.edu> (santiago@nyu.edu's
        message of "Mon, 26 Sep 2016 18:42:29 -0400")
Message-ID: <xmqqbmz9p7m0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FD032634-84D8-11E6-AAD9-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

santiago@nyu.edu writes:

> From: Lukas P <luk.puehringer@gmail.com>
>
> Functions that print git object information may require that the
> gpg-interface functions be silent. Add GPG_VERIFY_QUIET flag and prevent
> print_signature_buffer from being called if flag is set.
>
> Signed-off-by: Lukas P <luk.puehringer@gmail.com>

Are you and Lukas sure that "Lukas P" is how luk.puehringer wants to
be known by the world?  Just checking.

