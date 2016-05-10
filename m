From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] modernize t1500
Date: Tue, 10 May 2016 11:29:30 -0700
Message-ID: <xmqqa8jxpy0l.fsf@gitster.mtv.corp.google.com>
References: <20160510052055.32924-1-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Rappazzo <rappazzo@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue May 10 20:29:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0CPb-0003vB-2a
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 20:29:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751584AbcEJS3f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 14:29:35 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54428 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751442AbcEJS3e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 14:29:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4EB971A826;
	Tue, 10 May 2016 14:29:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=6SstpmN66Mgeo7hc8tsWPzzn1w4=; b=jCaZMV
	gsZXsHGvl/6czGsgAkWS40LTSfwf8qOiqFBwx8MC55vZkP+aOWbhdPS8mFdPZ7Q9
	8F7F4vyWtjN6r90nLv/pYzRy0HbmZ5dB6UxU1FmfawqRmFDlKyX4quKKiQIJUQCy
	mJ2XwbmQ+aie9CFco0InyG2/kDNHAkYKH7n9s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=plTIaM3eE5pN9OONgLZT8g5//1vyn8dv
	KN0LqcwsEmbCoH8tJ3w8wvcNZLfruMJrDZC4Y1pLIMYR+lc3rHTLC9GkHFNszWvX
	jx1tMh/EA1kd/m5azd1XMZYanq7XBc7he2KGVJZVn5pRQAxaoDtM/6rPdcKpSHcG
	yqiAuSrZAQA=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3C4891A824;
	Tue, 10 May 2016 14:29:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 995311A81E;
	Tue, 10 May 2016 14:29:32 -0400 (EDT)
In-Reply-To: <1456754714-25237-1-git-send-email-szeder@ira.uka.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 23E3B4FE-16DD-11E6-9FBC-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294171>

Eric Sunshine <sunshine@sunshineco.com> writes:

>   t1500: test_rev_parse: facilitate future test enhancements
>   t1500: reduce dependence upon global state
>   t1500: avoid changing working directory outside of tests
>   t1500: avoid setting configuration options outside of tests
>   t1500: avoid setting environment variables outside of tests
>   t1500: be considerate to future potential tests

When you reroll sg/completion-updates series (87a213f^..2be685a, 21
patches), please pay attention to this series, as it changes the way
you would check the output from your "--absolute-git-dir" option.
