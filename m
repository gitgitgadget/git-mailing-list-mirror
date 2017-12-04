Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38A0120954
	for <e@80x24.org>; Mon,  4 Dec 2017 16:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751631AbdLDQq7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 11:46:59 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57670 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751033AbdLDQq6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 11:46:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 051EEA1A52;
        Mon,  4 Dec 2017 11:46:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YRvwxfYhCFHw91JKdS+f0VyuoEY=; b=XRZImZ
        F/IrbL08mVgKTKP7KiFb2WKVUj7uNBK6gKlpim1ZSPAd/AIcQCXRHpuMpcqqECod
        mGYDRDG5RcrFQExJIu5MSgIfMP8aqYivZCsT1UMcqldZP8vSOZ40CchXd4WGbSRM
        fTp/IK/zLU41ghtuDF3geqIXNhfPC579CExDk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=F0Z8DLKCBHF9sUwJn3CbKl03mDxgXxRT
        xdujypfH2HERAVYaN7Vm8HL4xeOO9Zz/RzP0zVO0P8cAfHgFVHyp7kRX81XTbf7N
        bTmHTFPuDNDr9x6zyYuCZTAv9prGkein2vrkoMS5vKYTknLKIJUYvKg/9OCmpa78
        7klSFiOV+gg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F128EA1A51;
        Mon,  4 Dec 2017 11:46:57 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 60EAEA1A4E;
        Mon,  4 Dec 2017 11:46:57 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ann T Ropea <bedhanger@gmx.de>
Cc:     Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git Mailing List <git@vger.kernel.org>,
        Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH v5 4/7] checkout: describe_detached_head: remove ellipsis after committish
References: <20171203212743.10228-1-bedhanger@gmx.de>
        <20171119184113.16630-1-bedhanger@gmx.de>
        <20171113223654.27732-1-bedhanger@gmx.de>
        <83D263E58ABD46188756D41FE311E469@PhilipOakley>
        <xmqqfu9pmsx3.fsf@gitster.mtv.corp.google.com>
        <20171113223654.27732-3-bedhanger@gmx.de>
        <xmqq1sl17e1u.fsf@gitster.mtv.corp.google.com>
        <20171119184113.16630-5-bedhanger@gmx.de>
        <xmqqzi7hlhkx.fsf@gitster.mtv.corp.google.com>
        <5AE7AD53CF184A27BF8F484D415083D9@PhilipOakley>
        <xmqqo9nuuadm.fsf@gitster.mtv.corp.google.com>
        <FDCFD8EC7A754412A6369F03E91926C5@PhilipOakley>
        <CAPig+cT-r0uLLv_GyTRddPe=ATX883S1jt-8gc=ANZW21S81Mg@mail.gmail.com>
        <CAPig+cT4MvjLDvFEB6hJOSip=dqkp10ydnpfnoUabK=53OmQkw@mail.gmail.com>
        <20171124235330.15157-1-bedhanger@gmx.de>
        <xmqq4lpjkl4g.fsf@gitster.mtv.corp.google.com>
        <xmqqd145k9td.fsf@gitster.mtv.corp.google.com>
        <20171203212743.10228-4-bedhanger@gmx.de>
Date:   Mon, 04 Dec 2017 08:46:56 -0800
In-Reply-To: <20171203212743.10228-4-bedhanger@gmx.de> (Ann T. Ropea's message
        of "Sun, 3 Dec 2017 22:27:40 +0100")
Message-ID: <xmqqshcqmoe7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BDC86490-D912-11E7-BE05-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ann T Ropea <bedhanger@gmx.de> writes:

> +# Detached HEAD tests for GIT_PRINT_SHA1_ELLIPSIS
> +
> +# The first detach operation is more chatty than the following ones.
> +cat > 1st_detach <<'EOF'
> +Note: checking out 'HEAD^'.
> +
> +You are in 'detached HEAD' state. You can look around, make experimental
> +changes and commit them, and you can discard any commits you make in this
> +state without impacting any branches by performing another checkout.
> +
> +If you want to create a new branch to retain commits you create, you may
> +do so (now or later) by using -b with the checkout command again. Example:
> +
> +  git checkout -b <new-branch-name>
> +
> +HEAD is now at 7c7cd714e262 three
> +EOF
> +# The remaining ones just show info about previous and current HEADs.
> +cat > 2nd_detach <<'EOF'
> +Previous HEAD position was 7c7cd714e262 three
> +HEAD is now at 139b20d8e6c5 two
> +EOF
> +cat > 3rd_detach <<'EOF'
> +Previous HEAD position was 139b20d8e6c5 two
> +HEAD is now at d79ce1670bdc one
> +EOF

It is preferrable to have all of the above inside the
test_expect_success block that uses them.  

Also lose the SP between redirection operator and its target
filename, i.e.

	command >file

not

	command > file

> +test_expect_success 'describe_detached_head prints no SHA-1 ellipsis when not asked to' '
> +	reset && check_not_detached && unset GIT_PRINT_SHA1_ELLIPSIS &&
> +
> +	# Various ways of *not* asking for ellipses
> +
> +	unset GIT_PRINT_SHA1_ELLIPSIS && git -c 'core.abbrev=12' checkout HEAD^ 1> actual 2>&1 &&

Use sane_unset from t/test-lib-functions.sh instead, unless you are
absolutely sure that the variable you are unsetting _is_ set at this
point.

> +	check_detached &&
> +	test_cmp 1st_detach actual && unset GIT_PRINT_SHA1_ELLIPSIS &&

Is the output we are grabbing with check_detached from the command
internationalized?  If so, the comparison should be done with
test_i18ncmp (otherwise, the test will break under the "poisoned
gettext" build).

Thanks.
