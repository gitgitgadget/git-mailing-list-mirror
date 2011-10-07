From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git remote doesn't show remotes from .git/remotes
Date: Fri, 07 Oct 2011 11:08:59 -0700
Message-ID: <7v1uuowu6c.fsf@alter.siamese.dyndns.org>
References: <26866FC7-4D4D-46D0-89DE-85AF459AC48C@jetbrains.com>
 <20111007150423.GA2076@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kirill Likhodedov <kirill.likhodedov@jetbrains.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 07 20:09:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCEr6-0000Sb-6J
	for gcvg-git-2@lo.gmane.org; Fri, 07 Oct 2011 20:09:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758308Ab1JGSJD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Oct 2011 14:09:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33121 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758262Ab1JGSJC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2011 14:09:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 35AF46D7C;
	Fri,  7 Oct 2011 14:09:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5DG1zoqAsCa8X8W29qwz46m4T24=; b=MQHpNf
	eMGjz82ZQLqUY0DgtC8F7ehIJY0BXrHQaeTIzTN1eUXqpi1XP7pIjDE/ix5BQLx4
	9aA/dCTFDXYwNtyv0oLO3m8pLlCtf0F1UI4bK2KRhpvAnjPNRudR0n4YKsDtJwQr
	f7TQU5/KxgqUcOfibNdo/ErfeLIt5E9cr/t8s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fAxLrg8JSeuL3sMTP/AD9jqvfvlwrcF4
	HMcNt/23cJsImIHp8zycQw/i3JZW4nwMtgl5vIdMY8x3+evO0TerdgKQnk+XJX1Z
	+Ft5YNqak9JjnK297VKRi8snpQJ9sqNNGmsOjdv258o1MU7aXxc2jXJKpqcGQgDZ
	irwaqRTH5Fc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D1776D7A;
	Fri,  7 Oct 2011 14:09:01 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B97BC6D79; Fri,  7 Oct 2011
 14:09:00 -0400 (EDT)
In-Reply-To: <20111007150423.GA2076@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 7 Oct 2011 11:04:24 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6EDA1BFE-F10F-11E0-BD36-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183095>

Jeff King <peff@peff.net> writes:

> On Thu, Oct 06, 2011 at 07:33:23PM +0400, Kirill Likhodedov wrote:
>
>> It seems that 'git remote' doesn't display remotes registered not in
>> .git/config but in .git/remotes/.
>> Is it a bug?
>
> It seems to have been lost in 211c896 (Make git-remote a builtin,
> 2008-02-29).

Sad.

> I don't think there is a specific plan. They're kept for backwards
> compatibility. But really, there is no reason to be using them at all at
> this point.

I've been thinking about making a list of deprecations/deletions for Git
2.0. The only two requirements needed to be added to the list are that it
gets list concensus and it is backed by a solid patch (or patch series).
