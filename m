Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BEAE2070F
	for <e@80x24.org>; Wed,  7 Sep 2016 17:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757964AbcIGRf1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 13:35:27 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58982 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1757125AbcIGRf0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 13:35:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7F5463B79A;
        Wed,  7 Sep 2016 13:35:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=o13WUTE5SHxVrEh6GUtT8k04+fU=; b=d2viar
        baAQl6qdoTG+h7hphBYnI8si7EJSHFhjQBeWNJYUU8krblZknpUFdZDGauvOdQMt
        ycZP5oH30rI4fBftKX+5PedOBGyp78gN3WH41xwFRA898pQ3qebWd9xitV3YvEKo
        1ETXY9KcuPUlvvSL3X1cZUTVSPTL168ef5AYo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FoPGfr3KojuwVn9gx05OkR3k74IC9UyP
        fT5m6ha56KDgGJUjZjCXnuPPkfdNkkIFv65S4MFvGgVO/e8EnFQMzBSBH+eF2EgE
        MMfZ+xVE3ENyiDvs4p+WzvIitZu4D7wJzutl1XzI/P8wBTw1OTqve6lDcqzqPwWP
        KtqGNL7fkq0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 778823B799;
        Wed,  7 Sep 2016 13:35:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E73A13B798;
        Wed,  7 Sep 2016 13:35:24 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Satoshi Yasushima" <s.yasushima@gmail.com>,
        "Pat Thoyts" <patthoyts@users.sourceforge.net>
Cc:     <git@vger.kernel.org>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v2 6/6] git-gui: Update Japanese information
References: <1472913822-9088-1-git-send-email-s.yasushima@gmail.com>
        <1473177741-9576-1-git-send-email-s.yasushima@gmail.com>
        <1473177741-9576-6-git-send-email-s.yasushima@gmail.com>
        <048AF5D4DC044BDC9F3A75A3BABD00F1@Yasushima>
Date:   Wed, 07 Sep 2016 10:35:22 -0700
In-Reply-To: <048AF5D4DC044BDC9F3A75A3BABD00F1@Yasushima> (Satoshi Yasushima's
        message of "Wed, 7 Sep 2016 20:47:37 +0900")
Message-ID: <xmqqk2enobol.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 75A69C14-7521-11E6-B16D-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Satoshi Yasushima" <s.yasushima@gmail.com> writes:

> There seems to be a cause in the following taboo.
> Sure, PATCH 3/6 is little too great.
> http://vger.kernel.org/majordomo-info.html#taboo
>  >Taboo things to be done when discussing at VGER lists
>   : (abbr.)
>  > * Message size exceeding 100 000 characters causes blocking.
>
> To somehow.

Since I received the patch directly bypassing vger, I queued it on
gitgui-0.20.0 from Pat and tentatively merged it to my 'pu'.

Pat, we haven't heard from you for a long time.  How would you want
to proceed?  If you fetch from me and merge 52285c83 ("git-gui:
update Japanese information", 2016-09-07), you'd get these six
commits for po/ja.po and then we'd be in sync next time I pull from
you.

That is, if that ever happens--is git-gui pretty much in deep
maintenance mode without anything more to do from your point of
view?

Thanks.
