Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DDB12018A
	for <e@80x24.org>; Fri,  1 Jul 2016 20:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752678AbcGAULZ (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 16:11:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59876 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752671AbcGAULW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 16:11:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9309227BC1;
	Fri,  1 Jul 2016 16:11:00 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=hu7we0
	TNU1vc2QY/6YU2imIIMfK2qJRFd010opztGHmLfrN2y1iRuKMAKgskJe+T1pUPyM
	nqAy5t7UVeZ9hfqxKrjwFyiWToRnKylTtj+dwqnnOz/JA8Wcsn4hlOY0IWNQ/zYE
	bnDq846A2vPOdipHcNmHJL81EpZWL6hoR2S38=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TctFXqk686N0gk7IY7cfbb9O4qdf7/h/
	PQLF/Cq08ZYoLIRzOw5gixCDztZA3xc5xXeKtNhgTjJ+pgaoMghEblpGugv5+7oQ
	2XJFVH60vjHJ9aLvyzh24z9hR7nhfH+tbO285/x9R8iJysEKQeXYRrq2rzioWVn5
	jgPvQm35SOc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7A97827BC0;
	Fri,  1 Jul 2016 16:11:00 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E8E4A27BBE;
	Fri,  1 Jul 2016 16:10:59 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Vitor Antunes <vitor.hda@gmail.com>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH v2] git-p4: place temporary refs used for branch import under refs/git-p4-tmp
References: <xmqqeg7h87yg.fsf@gitster.mtv.corp.google.com>
	<1467185727-8235-1-git-send-email-larsxschneider@gmail.com>
	<loom.20160701T154359-664@post.gmane.org>
Date:	Fri, 01 Jul 2016 13:10:58 -0700
In-Reply-To: <loom.20160701T154359-664@post.gmane.org> (Vitor Antunes's
	message of "Fri, 1 Jul 2016 13:45:44 +0000 (UTC)")
Message-ID: <xmqq37ntxgod.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EDA853FE-3FC7-11E6-8AFC-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Thanks.
