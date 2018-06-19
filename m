Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AD0C1F403
	for <e@80x24.org>; Tue, 19 Jun 2018 19:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030331AbeFSTM7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 15:12:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55685 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967138AbeFSTM6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 15:12:58 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A6CB7ED4A9;
        Tue, 19 Jun 2018 15:12:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=owh32X5CUJGdYuYLfoCZTa1XlUc=; b=UAQPwTR
        5qMwhTv2LPM7DJOXLnzkMedXXDNZX+WHdTekIIzEzaHZQT/1OcbnnhwV8vAHHgEH
        YlQlud3pGlK7iPjJKjGB0iXlPe585NsT1q5drl2fOCdZqzzzCmgVu2CMjNGPuyQ2
        c5H4fWM7tPAgaXu8qs/q0uEQfoWGTe/wzaQM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; q=dns; s=sasl; b=cziS3mXTytbRm12QFNcRDuZA1QgciIBtT
        vlCe9p6hUsliBD9yGl+HV2MklSmoVROg4yyYjnKfSHvHAAU832NbDbnlaBao6lvG
        i2o1mCWJayQ3M4uM63OdID9jNZ5c82ERyn8jOd5VQMkJk6nNqSdNt9UpaHJ0tnse
        mc8g2y2New=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9D929ED4A8;
        Tue, 19 Jun 2018 15:12:55 -0400 (EDT)
Received: from zaya.teonanacatl.net (unknown [98.111.125.125])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2F235ED4A7;
        Tue, 19 Jun 2018 15:12:55 -0400 (EDT)
Date:   Tue, 19 Jun 2018 15:12:53 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@talktalk.net>, git@vger.kernel.org
Subject: Re: [PATCH] t3404: check root commit in 'rebase -i --root reword
 root commit'
Message-ID: <20180619191253.GR11827@zaya.teonanacatl.net>
References: <pull.3.git.gitgitgadget@gmail.com>
 <d59805a43ddaf4bbd4528a2b7afa9809eca9b86b.1529177176.git.gitgitgadget@gmail.com>
 <484fe825-0726-a027-1187-de00df6406d5@talktalk.net>
 <20180618164958.GO11827@zaya.teonanacatl.net>
 <nycvar.QRO.7.76.6.1806182343421.77@tvgsbejvaqbjf.bet>
 <20180618221942.GQ11827@zaya.teonanacatl.net>
 <xmqqin6ewyv2.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqin6ewyv2.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Pobox-Relay-ID: C532987C-73F4-11E8-9A7D-67830C78B957-09356542!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Todd Zullinger <tmz@pobox.com> writes:
>> Or Junio may just squash this onto js/rebase-i-root-fix.
> 
> Nah, not for a hotfix on the last couple of days before the final.
> We'd need to build on top, not "squash".

Indeed.  I somehow missed that you'd merged and pushed the
changes to master and next when I set this.  I was
mistakenly thinking it was only on the js/rebase-i-root-fix
integration branch.

Thanks,

-- 
Todd
