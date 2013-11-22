From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git p4: Use git diff-tree instead of format-patch
Date: Fri, 22 Nov 2013 15:35:52 -0800
Message-ID: <xmqqmwkwyppj.fsf@gitster.dls.corp.google.com>
References: <528E2467.4030900@gmail.com>
	<xmqqa9gx4jv6.fsf@gitster.dls.corp.google.com>
	<20131122231245.GA30589@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Crestez Dan Leonard <cdleonard@gmail.com>, git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Sat Nov 23 00:36:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vk0GW-0006Uj-NU
	for gcvg-git-2@plane.gmane.org; Sat, 23 Nov 2013 00:36:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755917Ab3KVXf5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Nov 2013 18:35:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59463 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755484Ab3KVXf4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Nov 2013 18:35:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E9F3552E7;
	Fri, 22 Nov 2013 18:35:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=BpWtXj
	N1LKZb8YEqFzOKtdUeL3IVtreRk9DDDo5Ygx6ZycmtLHQr0xg2xEWY4NU9g7gCmH
	xZRT7Frce2X0TQK+iJ6lPyP/lLNvFenm+3ohFw1CPWCnd30YEhnFCNJa1qvT77pE
	GHzuGXmBNxJ2N52nUB9yDjR4S7Q9CexXxjGk4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eLY2xwO+rTzI6VXJiZu380H2PG0k661l
	WWI6SWTsGiKrFXWRH4gB+8ih6kfaWL3GPxi99RAHaIe2oc69qo+rHORWZZVpI6Kz
	4XuRZMsVVkBa8ABbx+D2KHyXfumpWqfcTh1XZcbqLWZ6ePoiqAwHDEGcapCyxvuZ
	PtShcuyEEsM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8DCB9552E6;
	Fri, 22 Nov 2013 18:35:55 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E8475552E5;
	Fri, 22 Nov 2013 18:35:54 -0500 (EST)
In-Reply-To: <20131122231245.GA30589@padd.com> (Pete Wyckoff's message of
	"Fri, 22 Nov 2013 18:12:45 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D4C99466-53CE-11E3-B6D8-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238222>

Thanks.
