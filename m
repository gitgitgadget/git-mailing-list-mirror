From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: add a README file
Date: Thu, 21 Mar 2013 10:39:16 -0700
Message-ID: <7vzjxwabzv.fsf@alter.siamese.dyndns.org>
References: <1363873555-8274-1-git-send-email-ydroneaud@opteya.com>
 <7v8v5gbwh6.fsf@alter.siamese.dyndns.org>
 <64e67681cf5584b51bc84082fe6304c0@meuh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>
To: Yann Droneaud <ydroneaud@opteya.com>
X-From: git-owner@vger.kernel.org Thu Mar 21 18:39:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIjSs-0002U9-Ku
	for gcvg-git-2@plane.gmane.org; Thu, 21 Mar 2013 18:39:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412Ab3CURjT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Mar 2013 13:39:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62111 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751186Ab3CURjS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Mar 2013 13:39:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F907A187;
	Thu, 21 Mar 2013 13:39:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ec1eBaJzmYpGComQcvR4W8j3VcQ=; b=Lz1KZM
	vYcTHiuZMSCqF6HTOpEC2hCBFiwmcMfBrbas5Ewlsqje4tXNQiEJZJ3MfeXGVqJs
	qzXY4kIpnyNjH4chruVSHMVs2e4AW2G63UM+3gjmjnkyureohib8SPBplkcFt/iu
	d4F9r7lT3uvQcUWmjvEdEr6rEpAevAANk9lss=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KD0OZIpfFeGxJQj516EnUnnFBFt6EpMK
	LqoyKtXKUwObSSewVNtpnqg3Mcm4Tm/eZwkRl53gKCslAZonkvfOGm867JEoE9N7
	PlM4FG3P3YQbUFDxZgfnD1e9m2oTEgyMY3OEyxPDyB73gJMNz0RmL2w6rlznOoI4
	TeB/QWCsXTI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3EB5FA186;
	Thu, 21 Mar 2013 13:39:18 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B764BA17F; Thu, 21 Mar 2013
 13:39:17 -0400 (EDT)
In-Reply-To: <64e67681cf5584b51bc84082fe6304c0@meuh.org> (Yann Droneaud's
 message of "Thu, 21 Mar 2013 16:49:47 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 41717536-924E-11E2-9139-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218745>

Yann Droneaud <ydroneaud@opteya.com> writes:

> There were no indication about how to write documentation
> in SubmittingPatches.

I would agree that is probably the right place for it if we were to
add insns/hints.
