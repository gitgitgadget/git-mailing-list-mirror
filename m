From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] Expand ~ and ~user in core.excludesfile,
 commit.template
Date: Thu, 19 Nov 2009 10:12:54 -0800
Message-ID: <7v7htmbcyh.fsf@alter.siamese.dyndns.org>
References: <1258529351-4045-1-git-send-email-Matthieu.Moy@imag.fr>
 <1258534693-7220-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, Karl Chen <quarl@quarl.org>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Nov 19 19:13:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBBVG-0002wE-Ux
	for gcvg-git-2@lo.gmane.org; Thu, 19 Nov 2009 19:13:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752598AbZKSSM7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2009 13:12:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752432AbZKSSM7
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 13:12:59 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40484 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752131AbZKSSM6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2009 13:12:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 477447F0AC;
	Thu, 19 Nov 2009 13:13:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=Oy3QSQGdJFLh0LlPoHcKySAkrbQ=; b=LQVXTHkuLdAmPBRK6AAgzNP
	ScBN9Xl4J00B0eyAesCP0X2HU3toN1x/vHhH99n6uAGtsfKHv6SwkmvFp3nAhDEB
	6CN6B/kCyubefUJAKu8aXHpOorDab2KHLm32S2Xxa+2sF/wIYB0cher2BgWdhecF
	CuuLr8rvThRfbOBSXEZk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=BCCduC9NZjvUsry/nPqyH9r3lWyZGg5M6p1xyM59N0u1e4Usf
	ERgYQekyr6IdOb3++egGaDahz+0RkhJNIERmBaA84uFGYgXYRKh/dYcnU7naHtCm
	cEQEnvXP/fu0uCXQjuLg1Q74pmC305pvvS2Q8pqsOeoUxR2ydhgmLEbuKg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 13CBC7F0AA;
	Thu, 19 Nov 2009 13:13:01 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 39C757F0A9; Thu, 19 Nov
 2009 13:12:56 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2C4784B6-D537-11DE-A5BA-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133241>

Oops; last night I wrote

    Thanks; v3 was already in next so I'll make an interdiff into a separate
    "fix-up" commit.

but didn't send it out.  Thanks for rerolling the patch.
