From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t1507: change quoting in test_did_you_mean to a more
 general one
Date: Fri, 06 May 2011 07:23:00 -0700
Message-ID: <7vmxiz3o3f.fsf@alter.siamese.dyndns.org>
References: <20110505191027.GA3242@camk.edu.pl>
 <7vsjss6hmf.fsf@alter.siamese.dyndns.org>
 <4DC3A685.4080300@drmicha.warpmail.net> <4DC3CBEF.6080303@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kacper Kornet <draenog@pld-linux.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri May 06 16:23:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QILw9-0004Pf-8m
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 16:23:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751712Ab1EFOXQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 10:23:16 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35334 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469Ab1EFOXP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 10:23:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C560F4CC5;
	Fri,  6 May 2011 10:25:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=x2PHoCtNm/ICOLRgk9WSUDptIGM=; b=dd4W1C
	HKiHi0Bir+OaPz5arOXB2GrbW5+u12KS4ldGC5YfqKiTXTUDRO9UMyv6uJaaY6kG
	HZ+aztO85X65K80jGe99Csdf0royCq8mUbLodfMFG9A6x7uUTx7RgWIV9g/85568
	l8Kp288Ne5qaeNQp9libmhPPMCyAjBm6n93NE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vZbE0sB67Qppf/fA5uiq3ELuxXN5QWNX
	/ZXMjUoz+YrLIL+h+Del7xxaKppbTZH6Qwxk1Sr3jacEwDtWTXg1qXjKmy5CaH3L
	/ejYwHZhSoow2Mw9XeNKuWeRoNxavHoo5IdTMR2hdEjRrO4X8YYHc9WiQPvpGdu0
	KVvQMhn68/I=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 843D04CC4;
	Fri,  6 May 2011 10:25:14 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 231C44CBD; Fri,  6 May 2011
 10:25:06 -0400 (EDT)
In-Reply-To: <4DC3CBEF.6080303@viscovery.net> (Johannes Sixt's message of
 "Fri, 06 May 2011 12:22:39 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A889A8C0-77EC-11E0-B8C7-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172976>

Johannes Sixt <j.sixt@viscovery.net> writes:

> - The behavior of quoting at the right of :- when the ${...:-...} exansion
> appears in double-quotes was debated recently at length at the Austin
> group (which revises the POSIX standard).

Nice to have somebody who follows that stuff on the list.
