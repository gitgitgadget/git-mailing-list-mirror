From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: git diff --check respects core.whitespace
Date: Wed, 22 Jun 2011 16:12:16 -0700
Message-ID: <7vwrgd4g1b.fsf@alter.siamese.dyndns.org>
References: <1308756782-30241-1-git-send-email-git@christof-krueger.de>
 <BANLkTik-zxSTd-hJjsdjuc7m9XE2PLUsQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christof =?utf-8?Q?Kr=C3=BCger?= <git@christof-krueger.de>,
	gitster@pobox.com, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 23 01:12:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZWav-0007eP-5X
	for gcvg-git-2@lo.gmane.org; Thu, 23 Jun 2011 01:12:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758222Ab1FVXMT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Jun 2011 19:12:19 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62778 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757743Ab1FVXMT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Jun 2011 19:12:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AF9795788;
	Wed, 22 Jun 2011 19:14:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=zJ9yLa88/cyD
	VzlKtk/Y6X053QU=; b=h4pTFpiko8QAoWQlDLOh/HGzLyV6aNuy94E5gSTfYnQN
	NnKLCrhSIZCjSE7Slnw7hw/isn2J5jC3m1Fe5th7V8o/xYOWCNNvsGscDfyow7EV
	zmXbNJ3HV2nY7REe8QLvNEbejOpLKLn2NsfWVlItYQrn6Bs4KFrHSpLrBTqLLGc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=krmxdM
	kI2u1EEH0q6Vu/Jmf7RxdEpVN8/5q40yG+20phxeKZr6XbTkS7J1K3qeTe47dqFS
	KXIj+DIUsLeftTL9tz0VXcok+kfWe/dPyzlOdaXNE181IEvhObw90Ve6svg4r0gR
	Jio39ylUjHwKj8wTYncwD6WfTbaz8RqBqqAbQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A77D95787;
	Wed, 22 Jun 2011 19:14:29 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 09A975786; Wed, 22 Jun 2011
 19:14:28 -0400 (EDT)
In-Reply-To: <BANLkTik-zxSTd-hJjsdjuc7m9XE2PLUsQQ@mail.gmail.com> (Sverre
 Rabbelier's message of "Wed, 22 Jun 2011 23:43:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6127FD0C-9D25-11E0-BECD-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176258>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> Heya,
>
> 2011/6/22 Christof Kr=C3=BCger <git@christof-krueger.de>:
>> What are considered whitespace errors is controlled by `core.whitesp=
ace`
>
> Am I the only one who fees that "What are considered <plural>" would
> sound better if phrased "What is considered a <singular>"? Is it
> because I haven't heard the phrase much, or is the latter actually
> better somehow?

Perhaps. In any case, the original description seems to have been
inadequate for somebody to understand what it does, so the patch is an
improvement; I've queued it.

Thanks.
