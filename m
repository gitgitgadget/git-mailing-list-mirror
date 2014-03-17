From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-am: Document supported --patch-format options
Date: Sun, 16 Mar 2014 23:39:42 -0700
Message-ID: <7vlhw92us1.fsf@alter.siamese.dyndns.org>
References: <1394509917-9679-1-git-send-email-judge.packham@gmail.com>
	<532559D2.3050802@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 17 07:38:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPRC3-0002Wf-UU
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 07:38:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbaCQGif (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 02:38:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58130 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751107AbaCQGif (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 02:38:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B3DA66B830;
	Mon, 17 Mar 2014 02:38:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dnwyYfn3qBVnVySXRV8MoPlFAhw=; b=t8CnTl
	ZIF/76G63mb7W8yJh/tpwqc6EN9y4LT9qN3Tguu12ChD39gp2XWq2Utc713d33Bx
	OmB8vwumaegXe1PJHmynxBlY0041wUL8zvnumNka4c/CZNYEyEqSeLq6wor2qkPG
	PgzhxKVofLVXy0wNtIhQg/2N4ZI/RaV/c73wc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W0R5OKqfTcmd+QSjRMoYXnShtmlLApM2
	6AO0kQ9Vpqf1EEr34jH2OofZqHqHaIrMMtao6lJLwbXM4sHxeMpGWG6osdDam5+U
	j7QFE6wiuvvGV4QWpb+ltE2dxPd1XN/DZMethVINEAB4sHBA8TK74ReeWJXHYJl6
	pyHcloCBQeM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A9896B82F;
	Mon, 17 Mar 2014 02:38:34 -0400 (EDT)
Received: from pobox.com (unknown [198.0.213.178])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EF9F16B827;
	Mon, 17 Mar 2014 02:38:32 -0400 (EDT)
In-Reply-To: <532559D2.3050802@gmail.com> (Chris Packham's message of "Sun, 16
	Mar 2014 20:59:14 +1300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Pobox-Relay-ID: C271A4E6-AD9E-11E3-8A7D-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244223>

Chris Packham <judge.packham@gmail.com> writes:

> Ping?

Hasn't it been already cooking in 'next' for a few days?
