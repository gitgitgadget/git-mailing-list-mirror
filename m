From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] repack_without_refs(): convert to string_list
Date: Fri, 21 Nov 2014 10:00:09 -0800
Message-ID: <xmqq61e81ljq.fsf@gitster.dls.corp.google.com>
References: <1416423000-4323-1-git-send-email-sbeller@google.com>
	<1416578950-23210-1-git-send-email-mhagger@alum.mit.edu>
	<546F4B5B.2060508@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Nov 21 19:00:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrsVK-0005Sn-8P
	for gcvg-git-2@plane.gmane.org; Fri, 21 Nov 2014 19:00:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbaKUSAR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2014 13:00:17 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50557 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751097AbaKUSAQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Nov 2014 13:00:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 423A81F7BB;
	Fri, 21 Nov 2014 13:00:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QseWSdt/+X6Qr0KO2GQ6lcNKhEU=; b=dk0PJ7
	16UN5G9sCg0yL9qSnNeuNifeAeYyS7TxW9Aaisyjp5QBdwlm/BrnNTZzX0gPOH6i
	VGu+4jS5bO8Hp6tO1N78EnOj4SUS9awVITQ4rJNNL612j1czgd95D1ycwInIzUDh
	dAOwWcFLEDG8rt615FJGQBuw+5x/K61Ic6UAg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H2JZNWOWVXVix9a3qqy3niC1TG1VzyY6
	o67LjwVF2hcAoZF8iOQDm0Js/yFkZIHg3EacWWHfn07CEGkI/DjbJQ0ewORNjgGw
	6WIQnL7MQYrXyGBTiLpFfN5em5Kln2wXzfIg4uFGdQ76XCA6gzxsGB9K5V6lfI0K
	DvyclP9fD/U=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 370071F7B9;
	Fri, 21 Nov 2014 13:00:15 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1EB861F7AA;
	Fri, 21 Nov 2014 13:00:11 -0500 (EST)
In-Reply-To: <546F4B5B.2060508@alum.mit.edu> (Michael Haggerty's message of
	"Fri, 21 Nov 2014 15:25:31 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3C7F3618-71A8-11E4-B088-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> I don't think that those iterations changed anything substantial that
> overlaps with my version, but TBH it's such a pain in the ass working
> with patches in email that I don't think I'll go to the effort of
> checking for sure unless somebody shows interest in actually using my
> version.
>
> Sorry for being grumpy today :-(

Is the above meant as a grumpy rant to be ignored, or as a
discussion starter to improve the colaboration to allow people to
work better together instead of stepping on each other's patches?

FWIW, I liked your rationale for "many smaller steps".

One small uncomfort in that approach is that it often is not very
obvious by reading "log -p master.." alone how well the end result
fits together.  Each individual step may make sense, or at least it
may not make it any worse than the original, but until you apply the
whole series and read "diff master..." in a sitting, it is somewhat
hard to tell where you are going.  But this is not "risk" or "bad
thing"; just something that may make readers feel uncomfortable---we
are not losing anything by splitting a series into small logical
chunks.

Thanks.
