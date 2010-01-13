From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add `commit.signoff` configuration variable.
Date: Wed, 13 Jan 2010 00:30:21 -0800
Message-ID: <7v1vhuquea.fsf@alter.siamese.dyndns.org>
References: <alpine.LNX.2.00.1001131635510.16395@vqena.qenxr.bet.am>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steven Drake <sdrake@xnet.co.nz>
X-From: git-owner@vger.kernel.org Wed Jan 13 09:30:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUyce-0006DH-Up
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 09:30:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755126Ab0AMIac (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 03:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755119Ab0AMIac
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 03:30:32 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51704 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755014Ab0AMIab (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 03:30:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 393CA90829;
	Wed, 13 Jan 2010 03:30:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=n627nbVG7+mPCY1+hUwx/u9lx6k=; b=oBj5Vx
	GSUm3+aEJVA7iny6fbNXaDNXk/9ovY1xb9XcyIur60NL6xksL8O0HfvQ1298yNPo
	P1QSUj/w9a7nn025v5++gBUUQwq6Opfp2eal3pr7JClODPVbv/ni1bkMtGZiaRIi
	E+tKRXn/yr4UnnoCAE1u0Lofzih9Uk8G1xyH0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KtmGQ4PtJamxdtnmX0z5tzrsPsUCBtRR
	fbNBIUJIBZ9azZFIQMoZcGozYTsaknkQHRnM2odJ/41BxAO+D+bGl3ghOg1Qbwaa
	eyZEtwMD387z/JmL62GbbK/TqwKB3Y5D9aITOdXX2qv5o+Z+rbYBB65oB7QNiNQ6
	v1iqzoDBfKU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1500690825;
	Wed, 13 Jan 2010 03:30:27 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8F51390823; Wed, 13 Jan
 2010 03:30:22 -0500 (EST)
In-Reply-To: <alpine.LNX.2.00.1001131635510.16395@vqena.qenxr.bet.am> (Steven
 Drake's message of "Wed\, 13 Jan 2010 16\:36\:44 +1300 \(NZDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E6CAF26C-001D-11DF-9FEF-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136791>

You need to defend this one better, in fact a *lot* better, than other
ones.  See

  http://thread.gmane.org/gmane.comp.version-control.git/32503/focus=32522
  http://thread.gmane.org/gmane.comp.version-control.git/103939/focus=104207

for starters.  Your justifications should address all the points raised in
previous threads.
