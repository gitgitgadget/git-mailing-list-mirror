Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B61B2207BD
	for <e@80x24.org>; Mon, 24 Apr 2017 02:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164189AbdDXCgb (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Apr 2017 22:36:31 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54463 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1757980AbdDXCga (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Apr 2017 22:36:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D5AB87D447;
        Sun, 23 Apr 2017 22:36:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=eSlGZzG2CseU
        LEFObgzeONC+3WY=; b=qdTutzG5ZnZfiK3Xudi93KXSi50xkr7SnsRaoZLHE46J
        dVgzxWtrb0GjCmxABeopskW1X9Cf/Dhsu6zPfNVljSuVFYC4b9SFyQbtw2AqQEz4
        feW9vGPVfc5bOL2vL0jDccBlJ0DTHwsxpXdFUHECyiCya85huXLXzsl9gscl9i8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=LIr+NJ
        5mAoLi2okpor34opDJQdi8OJus8Yvp54V653a54RrMCQyth+ZSyzne+FabC4rOUw
        ydz5FXkArefpPDFPycJ3FcFbrTkN6n9MybJLLKSGQejvezwAzozArmX0INSc5DHi
        BdPBvhuR0j3+5ft77MnDhn/6Q8zaG0FcLEWD4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CD62D7D446;
        Sun, 23 Apr 2017 22:36:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 479367D445;
        Sun, 23 Apr 2017 22:36:28 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Genz <liebundartig@freenet.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc: update SubmittingPatches
References: <1492964264-29423-1-git-send-email-liebundartig@freenet.de>
Date:   Sun, 23 Apr 2017 19:36:27 -0700
In-Reply-To: <1492964264-29423-1-git-send-email-liebundartig@freenet.de>
        (=?utf-8?Q?=22Ren=C3=A9?= Genz"'s message of "Sun, 23 Apr 2017 18:17:44
 +0200")
Message-ID: <xmqq60hu351w.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D17EFAC6-2896-11E7-A323-E680B56B9B0B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Genz <liebundartig@freenet.de> writes:

 (updates for minor irritations skipped as I do not have strong
 opinions against them).

> @@ -261,7 +261,7 @@ smaller project it is a good discipline to follow i=
t.
>  The sign-off is a simple line at the end of the explanation for
>  the patch, which certifies that you wrote it or otherwise have
>  the right to pass it on as a open-source patch.  The rules are
> -pretty simple: if you can certify the below:
> +pretty simple: if you can certify the below D-C-O:

OK.  There is another instance of D-C-O away from here and new
people who read the document would not know without this addition
what it refers to.  This is a good addition.

>          Developer's Certificate of Origin 1.1
> =20
> @@ -376,6 +376,25 @@ from the list and queue it to 'pu', in order to ma=
ke it easier for
>  people play with it without having to pick up and apply the patch to
>  their trees themselves.


An oversimplified one is not necessarily welcome.  Can you split
this patch into "fixes" (all of the above) and the remainder?

> =20
> +
> +An oversimplified summary of the commands to run:

> +* clone repo
> +  $ git clone https://github.com/git/git
> +
> +* change files in your local repo copy
> +
> +* commit your changes
> +  $ git commit -a
> +
> +* create '.patch' file for the latest commit
> +  $ git format-patch HEAD^
> +
> +* install 'git-email' package and configure it, f.e.
> +    https://www.freedesktop.org/wiki/Software/PulseAudio/HowToUseGitSe=
ndEmail/
> +  send an email to yourself using your MUA in order to find out the va=
lue
> +  for the "--smtp-domain" option; look at the 'Received' header option
> +  $ git send-email --annotate --smtp-domain=3DLONGSTRING --to=3Dgit@vg=
er.kernel.org --cc=3DMAINTAINER --smtp-debug=3D1 NAME.patch
> +
>  ------------------------------------------------
>  Know the status of your patch after submission
