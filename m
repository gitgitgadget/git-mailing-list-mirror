From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 11/18] gitweb: add isDumbClient() check
Date: Fri, 10 Dec 2010 16:07:01 -0800
Message-ID: <7vzksd9nq2.fsf@alter.siamese.dyndns.org>
References: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net>
 <1291931844-28454-12-git-send-email-warthog9@eaglescrag.net>
 <m3hbem1o7a.fsf@localhost.localdomain> <4D01A5F3.8030108@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: "J.H." <warthog9@eaglescrag.net>
X-From: git-owner@vger.kernel.org Sat Dec 11 01:07:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PRCzh-0005on-4k
	for gcvg-git-2@lo.gmane.org; Sat, 11 Dec 2010 01:07:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756646Ab0LKAHN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Dec 2010 19:07:13 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56795 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755531Ab0LKAHM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Dec 2010 19:07:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9A8833EAA;
	Fri, 10 Dec 2010 19:07:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hIHHlfXZFBI0KtN+623rSPPHTro=; b=jgyoWC
	5MUvndF4lga+TQxSBhBUf3kpKHAxPJT2iz9ulL+j/I2xywxNi6ct1cV+k5RT27Up
	p3n5FVA9naMeiaFcPUbq0TGjJb7ZG3d1OBbi0IkdsGsNX4kvWty8pI5tyz/Vbfz7
	jH9Ws7oekTwdOyUQ3gqH0iY+fYTQFs5NjDuz0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r1Q85L1qjnpFjLR+R3kNpgME4yFDbzxb
	RXKCBrQZbYbZBINlr443m/HQXJHLjSDS8pX6gLwypimNg0pu8rA6e0e6l8YUb0l0
	NAUExtGxrPCp/jjxxGE1EqzFm65NkMESbvQ2zU8iJTt/vwglnebuXqbrgOMrLr9L
	lVixw1fqCn8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 596173EA8;
	Fri, 10 Dec 2010 19:07:32 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3C3763EA6; Fri, 10 Dec 2010
 19:07:27 -0500 (EST)
In-Reply-To: <4D01A5F3.8030108@eaglescrag.net> (J. H.'s message of "Thu\, 09
 Dec 2010 20\:00\:51 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A6667820-04BA-11E0-BADB-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163451>

"J.H." <warthog9@eaglescrag.net> writes:

> My initial look indicated that perl-http-browserdetect wasn't available
> for RHEL / CentOS 5 - it is however available in EPEL.
>
> However there are a couple of things to note about User Agents at all:
> 	- They lie... a lot
> 	- Robots lie even more
>
> Blacklisting is still the better option, by a lot.  I'll re-work this
> some in v9, as I'm fine with the added dependency.

Thanks, both.  I sense that we finally are going to get a single version
of gitweb that can be used at larger sites ;-)
