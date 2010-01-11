From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to check new commit availability without full fetch?
Date: Sun, 10 Jan 2010 23:12:50 -0800
Message-ID: <7vd41hxggd.fsf@alter.siamese.dyndns.org>
References: <ee2a733e1001100312j786108fct1b4c8abd0acc5afc@mail.gmail.com>
 <alpine.LFD.2.00.1001101501520.10143@xanadu.home>
 <7v8wc5itlc.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001101556490.10143@xanadu.home>
 <ee2a733e1001101736p2f395de6ka05044fe7cca624d@mail.gmail.com>
 <be6fef0d1001101757w7f54c9b2ye58c66179137efb1@mail.gmail.com>
 <7vk4vpcs1q.fsf@alter.siamese.dyndns.org>
 <b4087cc51001102129n5d5ac022s4f6f3ee9512eefd2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 11 08:13:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUESZ-0004Ii-Q8
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 08:13:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751745Ab0AKHNA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2010 02:13:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424Ab0AKHNA
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 02:13:00 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55739 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751108Ab0AKHM7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2010 02:12:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2CF568F88D;
	Mon, 11 Jan 2010 02:12:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z8TZSmL7qhsov7TfuTJTuWMDPy4=; b=Nel1UW
	pcpM4+CtqFihNgaKgj8iy06CQdhYqPYRfEaMo9ytoKE7nqHrE2SA82LcdNmnG9oJ
	h8JTvAHfy5iBACUdxDqmfddWINMM5OS+jkK1aBUwlY6uyEJi8Z9PUFVb3WUbKUIY
	LJs5fnYOHE0zustCQVMRanV6FwCZkp2sA32ik=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s8n30Dd0VvkxQ+ZKiVbXc05nkyNccw4b
	YmkJdwhuXw/417ITvdiXWWYT9Xqi5mC1s60on0UcD6wTCC34BEs5kPuVMBFn5Sro
	FthtnKpvl/s+CEZSqqMcnhO2ye3P4V+e5yNC1geYIo2ts2F+f4SX4i8FDyYwWfor
	eZw1yLgo8J8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 06FFD8F88C;
	Mon, 11 Jan 2010 02:12:55 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 600418F888; Mon, 11 Jan
 2010 02:12:52 -0500 (EST)
In-Reply-To: <b4087cc51001102129n5d5ac022s4f6f3ee9512eefd2@mail.gmail.com>
 (Michael Witten's message of "Sun\, 10 Jan 2010 23\:29\:52 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BD1F3624-FE80-11DE-A9AC-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136608>

Michael Witten <mfwitten@gmail.com> writes:

> I suggest adding this kind of information to the fetch/pull (and I
> suppose push) documentation.

Sounds good.  Pleaes make it so.
