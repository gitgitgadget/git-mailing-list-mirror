Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A6C3203E3
	for <e@80x24.org>; Fri, 22 Jul 2016 22:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751589AbcGVWqu (ORCPT <rfc822;e@80x24.org>);
	Fri, 22 Jul 2016 18:46:50 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56916 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751378AbcGVWqt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2016 18:46:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 590EA2F83C;
	Fri, 22 Jul 2016 18:46:48 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nM7ZnPPhPMqft7xvRcyBlYYJMR8=; b=n5dHH8
	KR9FLpERuEY4Ui/mISsHFMXalhbCL9qWCeoRuG34qaIhTkBIfemRhL/DQSRDgabg
	J7jsV+yNLquJpokAQRm1vtR/6O1yOMGRUwJQWBSZOUbdSkJAavAdXnO/TPWO2LKf
	Yvzi5cTlWrcXZlUIY2y18Acd1ffm22DsBH6/8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pCCmSN0Uw8qW+RPiZISMyqiICj/IJ3Pn
	U5PJPl5e88jGkcqpoD90YNEx353KO97O9yoiX+v1EEY83gX/Q5ribFAYStNX0rvt
	+j8NI7lFUdeAriXlJfzR3ta/OxOpRviDq/NbwhQnhBzMg8MBMCAwl9QgAdF3Nmje
	ZFpPIBh1+nU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 50BE72F83B;
	Fri, 22 Jul 2016 18:46:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CAD4F2F83A;
	Fri, 22 Jul 2016 18:46:47 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Philip Oakley <philipoakley@iee.org>
Cc:	GitList <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v4 4/8] doc: give headings for the two and three dot notations
References: <20160711202518.532-1-philipoakley@iee.org>
	<20160720211007.5520-1-philipoakley@iee.org>
	<20160720211007.5520-5-philipoakley@iee.org>
Date:	Fri, 22 Jul 2016 15:46:45 -0700
In-Reply-To: <20160720211007.5520-5-philipoakley@iee.org> (Philip Oakley's
	message of "Wed, 20 Jul 2016 22:10:03 +0100")
Message-ID: <xmqqoa5p8f56.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2C19E3EA-505E-11E6-A3E7-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Philip Oakley <philipoakley@iee.org> writes:

> +Special '<rev>{caret}' Shorthand Notations
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +Two other shorthands exist, particularly useful for merge commits, is
> +for naming a set that is formed by a commit and its parent commits.

As these are not all that "special", how about retitling this
section as:

	Other Shorthand Notations
        ~~~~~~~~~~~~~~~~~~~~~~~~~


> -To summarize:
> +The 'r1{caret}@' notation means all parents of 'r1'.
> +
> +'r1{caret}!' includes commit 'r1' but excludes all of its parents.
> +
> +Revision Range Summary
> +----------------------
>  
>  '<rev>'::
>  	Include commits that are reachable from (i.e. ancestors of)
