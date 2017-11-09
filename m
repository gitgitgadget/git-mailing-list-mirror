Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28BFB1F43C
	for <e@80x24.org>; Thu,  9 Nov 2017 03:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751749AbdKIDcI (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Nov 2017 22:32:08 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55215 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751550AbdKIDcI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Nov 2017 22:32:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 66B6E9F4E2;
        Wed,  8 Nov 2017 22:32:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mO01Yqw4lhMgrou30tlDqzwbx44=; b=ieC1PQ
        i3HRi3mPEmBVqUjz7vL2VAtid3MkNPY1ZzTUFUNE+avO050aJ5616mEVeXFCTNrx
        aojec6ZxtxmVlOmM1mrgz0bfVaJIFw5usWV9u5zDaZhiio2shO7R0DfNa6hW1dCQ
        w1AuncMxXCR9XPjNVBS0YzTU6p4Wl3dnmNPt4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ax4sQQxr8WWFr+5iD3OzSoDy76BSjc0q
        E9Fdj+S4XQWB/g45NRGsyXMFJNoWtisBCbrzfvUol7b1313Cm/oBqshxTmNrOv9q
        1dX4yGkaKztQtGnmKhqkDjhfl0DXYgFjilST0p8UwdjcVT/kycXlaq46gnp4VOEf
        245SR0pZlhs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5EF749F4E1;
        Wed,  8 Nov 2017 22:32:07 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DAD039F4E0;
        Wed,  8 Nov 2017 22:32:06 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lucien Kong <Lucien.Kong@ensimag.imag.fr>
Subject: Re: [PATCH] rebase -i: fix comment typo
References: <20171108132020.287540-1-adam@dinwoodie.org>
Date:   Thu, 09 Nov 2017 12:32:05 +0900
In-Reply-To: <20171108132020.287540-1-adam@dinwoodie.org> (Adam Dinwoodie's
        message of "Wed, 8 Nov 2017 13:20:20 +0000")
Message-ID: <xmqqr2t8jfey.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8FAA6AFE-C4FE-11E7-9F52-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adam Dinwoodie <adam@dinwoodie.org> writes:

> Signed-off-by: Adam Dinwoodie <adam@dinwoodie.org>
> ---
>  git-rebase--interactive.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 2563dc52d..437815669 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -722,7 +722,7 @@ collapse_todo_ids() {
>  	git rebase--helper --shorten-ids
>  }
>  
> -# Add commands after a pick or after a squash/fixup serie
> +# Add commands after a pick or after a squash/fixup series
>  # in the todo list.
>  add_exec_commands () {
>  	{

Thanks.  I recall deliberately letting this slip through knowing
that it came from France ;-)

Will apply.
