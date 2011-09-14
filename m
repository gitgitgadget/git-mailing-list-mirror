From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Survey] Signed push
Date: Tue, 13 Sep 2011 17:02:42 -0700
Message-ID: <7vty8guh25.fsf@alter.siamese.dyndns.org>
References: <7vaaa8xufi.fsf@alter.siamese.dyndns.org>
 <20110913232640.GA4189@ericsson.com>
 <7v1uvkvw68.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Guenter Roeck <guenter.roeck@ericsson.com>
X-From: git-owner@vger.kernel.org Wed Sep 14 02:02:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3cwH-00005Q-3S
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 02:02:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314Ab1INACq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Sep 2011 20:02:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46742 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751055Ab1INACq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Sep 2011 20:02:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C0952551D;
	Tue, 13 Sep 2011 20:02:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rqGifaYqC+7+YwY15TSChHyQxXo=; b=Aa96mN
	Njz+Hxlmpn53qBd7hUfx8Jpdmyu2Ge3H864/egC+Ir1Qdn+Vb2GZOfjln6XrcHaS
	P/roBZ5m+hwij69SYhbmP2XzVMzljqBZiwTa8VTdFly3gWOJ+bdwVPwctJyUg1pa
	bVt3IRQBknOD/YgTUEj0R+9Dmeagh8mNFFUiw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jT2erO9nbX2P31Ug4zZ7QeWTTM8qGcfr
	9iOjRLmImTrRnnwn3h+sTo7gk1hwA/WcdSr5HOa/PylQyKBMVjXoT9le8X90g10F
	PVj35Qt3MteoP4kjhcK8VaiR4+Nna/r/uYy4B3UQVcBziJ254Dl7JeVmLyscbJWB
	Idy0n5b9UoI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B898F551C;
	Tue, 13 Sep 2011 20:02:44 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8A8C9551B; Tue, 13 Sep 2011
 20:02:43 -0400 (EDT)
In-Reply-To: <7v1uvkvw68.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 13 Sep 2011 16:50:55 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DEB783C0-DE64-11E0-B971-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181330>

Junio C Hamano <gitster@pobox.com> writes:

> Guenter Roeck <guenter.roeck@ericsson.com> writes:
>
>> On Tue, Sep 13, 2011 at 12:45:37PM -0400, Junio C Hamano wrote:
>> [ ... ]
>>
>>> 1. Improved pull requests.
>>> 
>> noise for me
>
> Are you among the ones who respond to pull requests?

Sorry, this didn't come out quite the way I intended.

As I do not know every developer on earth, I would like to know in what
capacity you (figuratively---I mean everybody who gives his opinion on
this topic) fit in your ecosystem. Otherwise I cannot tell if many people
who receive pull requests find it noise but senders do not care, or many
people who send them find it noise but receivers do appreciate, etc.

For the purpose of commenting on "pull requests" topic, one can be (1)
a bystander, who does not request nor respond to pull requests, (2) who
gets requests to pull, or (3) who sends requests to pull.

The same for "signed pushes". In this case, one can be (1) who pushes, (2)
who fetches and wants to verify what he gets, (3) both (e.g. Linus
playing role (3) while fetching from his lieutenants and then role (1)
when pushing his integration results out).
