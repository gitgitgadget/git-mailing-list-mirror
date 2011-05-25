From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 00/10] Sequencer Foundations
Date: Wed, 25 May 2011 16:15:16 -0700
Message-ID: <7vwrhez81n.fsf@alter.siamese.dyndns.org>
References: <1306333025-29893-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <christian.couder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 26 01:15:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPNIl-0005gH-KT
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 01:15:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754527Ab1EYXPc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 19:15:32 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55741 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754078Ab1EYXPa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 19:15:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2FF7F557A;
	Wed, 25 May 2011 19:17:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kNzpf3RbFmLR0mSGR5sbHbilk68=; b=Q3RhmI
	GN7eRg7NtjxeqlHXKnoshp46K6PakOZ2t59sRycx17Y9Az/UOnPdcqpy+C5rF4BV
	Il9k5sfRoyQlobYJkCF0KuoPi3JeIJAgzwf3RUERp005l2F5cdmsoU7S5CgSr7Kg
	Upd9ZA/1EqumsOSMRTgrq+AHG8bT8aeB8F98w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VxxlqWaxbh2AUKKPUoeGfiNthN4ahP3V
	D4zDCr356ATMgRf6HYD8K7wdU+UegtPB34rFZmqAQ3zGZyjsMglvStXbEQufQm9s
	R6CLDdvWpW8OFVAPZmNYUtuZc6H6c2zP7RDHgUpOmAGgT/xxTxnQuh5o39Dk/3SO
	1W04W2bJOpA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B36B75579;
	Wed, 25 May 2011 19:17:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 39B225575; Wed, 25 May 2011
 19:17:24 -0400 (EDT)
In-Reply-To: <1306333025-29893-1-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Wed, 25 May 2011 14:16:55 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2A6CE680-8725-11E0-9ACD-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174473>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> I hope there are no major issues with this iteration.

I've scanned up to 07/10; except for the internal API issues in 03/10
overall you seem to be going in the right direction.
