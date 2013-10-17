From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6] diff.c: keep arrow(=>) on show_stats()'s shortened filename part to make rename visible.
Date: Thu, 17 Oct 2013 12:53:14 -0700
Message-ID: <xmqqfvrzznbp.fsf@gitster.dls.corp.google.com>
References: <38848735-7CFA-404E-AE51-4F445F813266@gmail.com>
	<A15CCF08-83FD-4F3C-9773-C26DEE38FD33@gmail.com>
	<660A536D-9993-4B81-B6FF-A113F9111570@gmail.com>
	<AFC93704-D6C5-49AF-9A66-C5EA81348FFA@gmail.com>
	<79A13931-694C-4DDC-BEDF-71A0DBA0ECA1@gmail.com>
	<89A4E8C6-C233-49E2-8141-837ABDBBC976@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Yoshioka Tsuneo <yoshiokatsuneo@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 17 21:53:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWtdK-0002dM-4t
	for gcvg-git-2@plane.gmane.org; Thu, 17 Oct 2013 21:53:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759117Ab3JQTxS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Oct 2013 15:53:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41246 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758714Ab3JQTxR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Oct 2013 15:53:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 103D54B1DC;
	Thu, 17 Oct 2013 19:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=t2ijB7vcEupfiLNZHrJN4oFU1Sc=; b=T4gg1x
	S2waxaubMzp3UWCnHXxW5gjMWlLaAcjP3zBRLrLBVjnfJd0xzMQ8hU+V0ny16lV+
	A6KQqNqu4skETYPCxJEV4VrM5CcC9uCvXBIqoPKRneEPscQweLvUZk2IVvRDpAlE
	VUOnZx6BVMTAIX702dgYKzFwdTskQSiNNYQ54=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ntackwsCcIgJS5f2r/biXy42dNQ8bdls
	gzf3N2TBYXNxPah+FnkeqrAUm0xHRjhyCVoe25JyeIDME/e+6XZxVkJwhBS9Qbr1
	Ttr3oAzKB1wlvYoLRs92t4h5cKBga8f0CFuwA/wpa31jKmakoVvWiM30GJNsv/GF
	NnHt9lE/ykw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 025B34B1DB;
	Thu, 17 Oct 2013 19:53:17 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 635A04B1D5;
	Thu, 17 Oct 2013 19:53:16 +0000 (UTC)
In-Reply-To: <89A4E8C6-C233-49E2-8141-837ABDBBC976@gmail.com> (Yoshioka
	Tsuneo's message of "Wed, 16 Oct 2013 12:53:44 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C39A7406-3765-11E3-A70F-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236312>

Yoshioka Tsuneo <yoshiokatsuneo@gmail.com> writes:

> Before this commit, this output is shortened always by omitting left most
> part like "...foo => barbarbar". So, if the destination filename is too long,
> source filename putting left or arrow can be totally omitted like
> "...barbarbar", without including any of "foofoofoo =>".

This is an explanation much easier to understand than the one in the
previous iteration.  Thanks.
