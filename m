Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E904920986
	for <e@80x24.org>; Tue, 27 Sep 2016 17:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935057AbcI0RDH (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 13:03:07 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55229 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934454AbcI0RDE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 13:03:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 84BA63CB22;
        Tue, 27 Sep 2016 13:03:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=1wSKQaC/NKkJ
        wu3MMDkmQMzFtU4=; b=RURWUDhwu54vpnLdiwGl+CLUP0ZXy3jdwZWU5Tqfk00x
        zCrAH/2pNKvdkNaKzYrPLQc7qtwZQOZy73svNWJuKYKiky2x/Ei50xXIVSd/E02j
        JyIA/pu0+eTUXo1V6SStrwQU5sy2FHhR39DMKHa2QXzrBKBZf8kodmqxN2FC8EQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=mIkWJZ
        JyFVN69jLecjTNriDZf9Jalt0XGYenSXyhNcz/J38UY0PZV5F/WHYHuYT1GqeNOo
        9TNa4KnHqfOLt42BquptVQxKJzaj7DRqRuig8T2Od1NzB/PBGo1f9oIwkFN9qNPx
        3TO1VG8Bn2gOhP7O8Vg5eoB2+upffG1EnpP2A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7CE8B3CB20;
        Tue, 27 Sep 2016 13:03:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F2AD03CB1F;
        Tue, 27 Sep 2016 13:03:02 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Turner <dturner@twosigma.com>
Cc:     git@vger.kernel.org, peff@peff.net,
        David Turner <novalis@novalis.org>
Subject: Re: [PATCH v3 3/3] add David Turner's Two Sigma address
References: <1474989806-5002-1-git-send-email-dturner@twosigma.com>
        <1474989806-5002-3-git-send-email-dturner@twosigma.com>
Date:   Tue, 27 Sep 2016 10:03:00 -0700
In-Reply-To: <1474989806-5002-3-git-send-email-dturner@twosigma.com> (David
        Turner's message of "Tue, 27 Sep 2016 11:23:26 -0400")
Message-ID: <xmqqshslp96j.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 406B0A72-84D4-11E6-97D4-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Turner <dturner@twosigma.com> writes:

> From: David Turner <novalis@novalis.org>
>
> Signed-off-by: David Turner <novalis@novalis.org>
> ---
>  .mailmap | 1 +
>  1 file changed, 1 insertion(+)

Thanks. Queued separately in order to merge to master much earlier
than the tree-fsck topic.

>
> diff --git a/.mailmap b/.mailmap
> index 9441a54..9cc33e9 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -48,6 +48,7 @@ David K=C3=A5gedal <davidk@lysator.liu.se>
>  David Reiss <dreiss@facebook.com> <dreiss@dreiss-vmware.(none)>
>  David S. Miller <davem@davemloft.net>
>  David Turner <novalis@novalis.org> <dturner@twopensource.com>
> +David Turner <novalis@novalis.org> <dturner@twosigma.com>
>  Deskin Miller <deskinm@umich.edu>
>  Dirk S=C3=BCsserott <newsletter@dirk.my1.cc>
>  Eric Blake <eblake@redhat.com> <ebb9@byu.net>
