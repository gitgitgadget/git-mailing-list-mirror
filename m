From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5] rev-list: refuse --first-parent combined with --bisect
Date: Thu, 19 Mar 2015 15:43:57 -0700
Message-ID: <xmqqh9tghaky.fsf@gitster.dls.corp.google.com>
References: <1425934575-19581-1-git-send-email-me@ikke.info>
	<1426803248-6905-1-git-send-email-me@ikke.info>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Kevin Daudt <me@ikke.info>
X-From: git-owner@vger.kernel.org Thu Mar 19 23:44:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYjAf-000360-J5
	for gcvg-git-2@plane.gmane.org; Thu, 19 Mar 2015 23:44:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752079AbbCSWoF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 18:44:05 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51047 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751458AbbCSWoA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2015 18:44:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B84FF42106;
	Thu, 19 Mar 2015 18:43:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=H1e6rjdWxFnxr0/pBS+89KyU/9w=; b=v5sqsR
	eqAl3xSK8gSa09X5JNDx6tqWAYEvWWWfGXkROcevrHRAr0biIUqwXNSm7wXchnNZ
	nNBMDG7Oo2dALfZB0Z891/fQh7IAB3fXPwgDIUBiY7o/1xl61kbvh90t1mLznsqW
	fibRn/ZbNgWVpVvkRRoNEX7LDrk5q50+RWoh8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Q+TC/3E1EmrrG0rH2/XzW3MYFYcrpc65
	2jH4/bI67ZHeXZhOWHZ9e+uzJMQXcuRz7baXETjB8C5c20LODvrTB/gdDdKbL4RP
	zu/yj4fi847Lxj9bACb0JKyJKFfO8WZxBE4xbePG0xc+WzjBceyLAjMdXBeFaCgA
	GgMSUqTkvnw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B213542104;
	Thu, 19 Mar 2015 18:43:59 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 54FC642103;
	Thu, 19 Mar 2015 18:43:58 -0400 (EDT)
In-Reply-To: <1426803248-6905-1-git-send-email-me@ikke.info> (Kevin Daudt's
	message of "Thu, 19 Mar 2015 23:14:08 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6E42357C-CE89-11E4-A94E-FAE19E42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265849>

Kevin Daudt <me@ikke.info> writes:

> rev-list --bisect is used by git bisect, but never together with
> --first-parent. Because rev-list --bisect together with --first-parent
> is not handled currently, and even leads to segfaults, refuse to use
> both options together.
>
> Because this is not supported, it makes little sense to use git log
> --bisect --first parent either, because refs/heads/bad is not limited to
> the first parent chain.
>
> Helped-by: Junio C. Hamano <gitster@pobox.com>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Kevin Daudt <me@ikke.info>
> ---

Thanks; will queue.
