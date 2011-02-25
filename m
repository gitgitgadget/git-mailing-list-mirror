From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 24/73] gettextize: git-checkout "Switched to a ..
 branch" message
Date: Fri, 25 Feb 2011 11:33:21 -0800
Message-ID: <7vmxljaozi.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
 <1298418152-27789-25-git-send-email-avarab@gmail.com>
 <20110225081048.GH23037@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 25 20:33:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pt3Q4-0004Cn-1U
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 20:33:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932749Ab1BYTdf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Feb 2011 14:33:35 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47262 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932709Ab1BYTde (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Feb 2011 14:33:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BB4814AEA;
	Fri, 25 Feb 2011 14:34:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EZN6ZqFt2ewiERR/BMFzk0+Y1Ns=; b=XsMqg+
	QkwljwFRuzFPgZxZGaX2aHANiuf2R7i3M3KZeDYX39qtfvICllumjOl0XIqb3Nbu
	rXgYpWQYYdgstqpBXzg8ct7fo0RbThBiiw5oOyXpcHdANPUSUsDWCq9YivBKNOUH
	DpbwM8rVPW9+HvFscWcupmQpeB9z7x9oiwp8k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=m7SwFomwoi+wq37LM6yUrcy8MBaBcMVW
	TGzoCJjWv9ecpoKWuI4GoYaLnYLh2bI679Cvnm7WKi8dzaqPsG+qqUbPIBUdyxiH
	a9yUSMJiiWHsY3n8A7T1GVA9xYd6nFudrqieEKpyYRgDHKm3RV6UhSaLTiZ0oOVj
	TkgcR+PayMo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 751C64AE3;
	Fri, 25 Feb 2011 14:34:44 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E30874AE1; Fri, 25 Feb 2011
 14:34:38 -0500 (EST)
In-Reply-To: <20110225081048.GH23037@elie> (Jonathan Nieder's message of
 "Fri\, 25 Feb 2011 02\:10\:48 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4C2E8D32-4116-11E0-91AD-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167923>

Jonathan Nieder <jrnieder@gmail.com> writes:

> C grammar is on your side, but the following seems worthwhile for
> the sanity of readers and those who might modify the code in the
> future.

Good point.  Thanks.
