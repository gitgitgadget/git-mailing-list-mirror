From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] t3700: note a .gitignore matching fault
Date: Tue, 03 May 2011 10:56:54 -0700
Message-ID: <7voc3jis61.fsf@alter.siamese.dyndns.org>
References: <1304340464-14829-1-git-send-email-pclouds@gmail.com>
 <1304340923-15927-1-git-send-email-pclouds@gmail.com>
 <4DBEC766.8020008@viscovery.net>
 <BANLkTik=GYXUOeo3hA5yyXfOuBydT40koA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 03 19:57:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHJqV-0007iN-EC
	for gcvg-git-2@lo.gmane.org; Tue, 03 May 2011 19:57:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754271Ab1ECR5K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2011 13:57:10 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43092 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753396Ab1ECR5I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2011 13:57:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BA46C3549;
	Tue,  3 May 2011 13:59:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=e2PTDzbMLhgS9iR1vySJawdo75o=; b=LCeRkOK36UvHsgDMjT2b
	g2DUhikmB+nIsZfVHvqNOBj1Cavav8QS1/Q0rLmJuJCtIs1d1RVGyxL4pDS2HIO4
	8S2UmThhOYZzbhzdun1hgCTerWLbPHBcbgjV/k/0G7XmZCdwpb+y5BNsM8r8jatn
	4hPZLFDfJGrzseVI4stfNO4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=ZQ0H5SczfFKSCTMPJAnntLAgjNxpufh8YCTkA2Ce5WlUo+
	BG3XuFdUbt78tiMQIES5RopIWMwvHZ6xEPURsWSemof5kj6BZJjZXx4oDChbcrht
	hWYUj8a07VYVzEC+4UTfMOtpPHtnoQlWRdppjtQu25NyhjR53D5x16U5Y2DQQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 86F563548;
	Tue,  3 May 2011 13:59:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C1B803545; Tue,  3 May 2011
 13:58:59 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0893491E-75AF-11E0-9EAC-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172679>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> ... The point is make it
> configurable with sane default. It's up to users to decide how they
> want to pay.

Hmm, I am confused.

Isn't that what we already have?  If you want to pay, you just do not
define a do-not-descend ignore entry at such a location so close to the
root of the working tree.
