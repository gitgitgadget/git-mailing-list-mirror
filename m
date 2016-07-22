Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BA97203E3
	for <e@80x24.org>; Fri, 22 Jul 2016 17:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754813AbcGVR4G (ORCPT <rfc822;e@80x24.org>);
	Fri, 22 Jul 2016 13:56:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64568 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754777AbcGVR4D (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2016 13:56:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CF1982D15B;
	Fri, 22 Jul 2016 13:56:01 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Pk4h+c98Rd4YkSxkQJ1ZDTnSWC4=; b=aGGHNT
	bsKxf/HD9CLj3M3Whgyzebxz+0pb8d2coWb/78XV6B0ojL9fm1c67xCg7+V6rg/9
	3YeHprF38H+2bJ+hWrSIOi+2lz/FfatFMnkcw/iKLNkWkQ5lrGmpcV1wfsqPYtQ+
	moOifnkQ/DSYf5x7uCctcrzMofMgKftDTJpFo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YiZTKSTBOK8Q4nuax/RKcjuulM68XAAI
	lpQSmi630a56jhSKm0HjdUvyl1GT4k5Qw5vZIUI3uVdMZxbCEY1cHwDopCW3IKAk
	Y3i3iWDTN7ilQwNenk1p0MyRjbhaIrhih1l5kN9FBtx6PDnZFC0RbS7lIEgZ8w1R
	yjHHa/otGcc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 806392D15A;
	Fri, 22 Jul 2016 13:56:01 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4919C2D159;
	Fri, 22 Jul 2016 13:56:00 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Parker Moore <parkrmoore@gmail.com>
Cc:	git <git@vger.kernel.org>, Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] contrib/persistent-https: update ldflags syntax for Go 1.7+
References: <CAOiOGAePh6syq8XMWdzE_H8UQxzpgnsCsiYx-TG+mg46FRgXKQ@mail.gmail.com>
Date:	Fri, 22 Jul 2016 10:55:58 -0700
In-Reply-To: <CAOiOGAePh6syq8XMWdzE_H8UQxzpgnsCsiYx-TG+mg46FRgXKQ@mail.gmail.com>
	(Parker Moore's message of "Wed, 20 Jul 2016 18:58:57 -0600")
Message-ID: <xmqq1t2lblqp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8C903E78-5035-11E6-BAB6-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Parker Moore <parkrmoore@gmail.com> writes:

> From: Parker Moore <parkrmoore@gmail.com>
>
> This fixes contrib/persistent-https builds for Go v1.7+ and is
> compatible with Go v1.0+.

Thanks, applied.
