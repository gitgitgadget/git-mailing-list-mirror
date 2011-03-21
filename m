From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Work around broken ln on solaris as used in t8006
Date: Sun, 20 Mar 2011 22:00:11 -0700
Message-ID: <7v4o6xukys.fsf@alter.siamese.dyndns.org>
References: <1300669724-sup-450@pinkfloyd.chass.utoronto.ca>
 <1300669946-26326-1-git-send-email-bwalton@artsci.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Mon Mar 21 06:00:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1XEB-00051K-Ox
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 06:00:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752319Ab1CUFAX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 01:00:23 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62169 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751805Ab1CUFAV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 01:00:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8EEA13505;
	Mon, 21 Mar 2011 01:01:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lj5qAi5yuoUpavhYty6C4LteZRw=; b=sLUrI7
	Q06elxbJ+4yrA5Kh1DxY04SjAnjUHJyIS2fGDyED2CCTGnmt31+E/6+iRkKm5GDR
	Cfexn1v8pfqVt8VZ+ghH2rVPKYPipzmPoJucbpBj9O5ahFyZshjc0itV49i/5X8j
	9Ksb6MYgRzb4ibcucz1RYaFxohRa8Hi8616Ng=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mS9BX1reFDqww7jDnZZDyVLTbCqcCE9m
	DBXVFnMOCefQLedVV2byMF4gIORvL4Dm0W9M8DPUEUhe4UmrUJXWX3mZ/e/jn3RT
	CZAHvEYLT/PNmtTUqwJiJSV2hYVPZkYitROLvoh5SrD31YOZXZbpFIq7SpmM8GG5
	83mY32Q9jvg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6CAEF3500;
	Mon, 21 Mar 2011 01:01:53 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 806F834FE; Mon, 21 Mar 2011
 01:01:50 -0400 (EDT)
In-Reply-To: <1300669946-26326-1-git-send-email-bwalton@artsci.utoronto.ca>
 (Ben Walton's message of "Sun, 20 Mar 2011 21:12:26 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 567FF126-5378-11E0-8AB4-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169554>

Ben Walton <bwalton@artsci.utoronto.ca> writes:

> The upstream Solaris bug (fixed in 10, but not 9) is documented here:
> http://bugs.opensolaris.org/view_bug.do?bug_id=4372462
>
> Signed-off-by: Ben Walton <bwalton@artsci.utoronto.ca>

Thanks; will queue.
