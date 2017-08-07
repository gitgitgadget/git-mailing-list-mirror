Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2026B2047F
	for <e@80x24.org>; Mon,  7 Aug 2017 22:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751881AbdHGWOy (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 18:14:54 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54144 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751743AbdHGWOx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 18:14:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D80CEA1587;
        Mon,  7 Aug 2017 18:14:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=u
        acLtj9HXVfnDWIDU8RcqPFt2nk=; b=bUdUJ08pkk2tOvWyC/sKL5JBZ/ic0qHlS
        EInotHOpXFFQIi2oKqpfCWXGtBMhGM7bIGeQHlpboZ5RNX7fMnu+TrbVrFE3SCwY
        KBudqC8upOUfkqprS+aLJ5+NZa5Y/JWJ7uUnEO2rkKfZWzjI+ubLWa8CE1lI0XdZ
        w5oD8NIb/0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=aIy
        AVfWy1rgCboAABLzXxWh49JxTGjIMhDJ5PAPGidBGNmcQmph0ib/2KJYGFJMiBxp
        Vef4oTWPDbirAKwL4J/RRjneCDJ21JTIKBHvwOkA8K3zZ1vI7FXnkRvXkYUthPPi
        Kr2gJTO9iBzZRynTNBjVDQDTJq2o1RclZvv3c3S8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D029BA1586;
        Mon,  7 Aug 2017 18:14:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3B9F0A1583;
        Mon,  7 Aug 2017 18:14:52 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] perl/Git.pm: typofix in a comment
Date:   Mon, 07 Aug 2017 15:14:50 -0700
Message-ID: <xmqqh8xjnhyd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D5B60AE2-7BBD-11E7-BC35-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

No change of behaviour intended.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
--
 perl/Git.pm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index f4b56e6d4d..ffa09ace92 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -532,7 +532,7 @@ If TIME is not supplied, the current local time is used.
 =cut
 
 sub get_tz_offset {
-	# some systmes don't handle or mishandle %z, so be creative.
+	# some systems don't handle or mishandle %z, so be creative.
 	my $t = shift || time;
 	my $gm = timegm(localtime($t));
 	my $sign = qw( + + - )[ $gm <=> $t ];
