From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 0/2] allow git-svn fetching to work using serf
Date: Thu, 18 Jul 2013 16:34:49 -0700
Message-ID: <7v8v131lye.fsf@alter.siamese.dyndns.org>
References: <8a6adfae744011599e410da7a46808b@f74d39fa044aa309eaea14b9f57fe79>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Rothenberger <daveroth@acm.org>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 19 01:34:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uzxiq-0001fD-Kr
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 01:34:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934742Ab3GRXew (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 19:34:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46294 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933880Ab3GRXev (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 19:34:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7E7A732EA9;
	Thu, 18 Jul 2013 23:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CUN5mkmOPB9v6EZI8vAhvo96KH0=; b=MbDAwk
	SM/nBLYiaIzeb7jNdPuIJLj1UP8irCna7B3Df3BkoYfuDRVBC92bBwAQjziv9zd6
	hUrFDha5cTz2VfUKFaaz4PA1y0J9f6YynDot2nCj592wnRopv5Gm/bLfSVd2hRxF
	2YXL9mEAyC/DJt7nN9uMdaXV6dWIZsKPhxD4Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lGzmMUdNTHOVWDNCwaCaX7JnSJAepSkC
	K+idxtpDgui5lOqI8PDZJovDWT3BlqThw1QIt0GlIDL+gvXXkfH7j3JzJVKtNUPI
	168YJkj5ErnUCs38KzSpEKKBfWVSuJ6OKt8Zf3vwkPHaMpbRz5dAwadQS2LEsE6g
	K/Q4S2ks0Z8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 72E3532EA7;
	Thu, 18 Jul 2013 23:34:51 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C190832EA5;
	Thu, 18 Jul 2013 23:34:50 +0000 (UTC)
In-Reply-To: <8a6adfae744011599e410da7a46808b@f74d39fa044aa309eaea14b9f57fe79>
	(Kyle J. McKay's message of "Thu, 18 Jul 2013 12:15:27 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A4159E76-F002-11E2-9EE5-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230768>

"Kyle J. McKay" <mackyle@gmail.com> writes:

> This patch allows git-svn to fetch successfully using the
> serf library when given an https?: url to fetch from.
> ...
> Versions v2-v3 of the patch introduced a bug when attempting
> to change the _temp_cache function to use the new
> temp_is_locked function at the suggestion of a reviewer.

Err, excuse me, is this meant to _replace_ what is already in 'next'
for the past 6 days?

Could you feed an incremental update, highlighting where the update
improves compared to the previous attempt in the log message?
