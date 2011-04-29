From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] merge-one-file and GIT_WORK_TREE
Date: Fri, 29 Apr 2011 09:27:47 -0700
Message-ID: <7v4o5hyqd8.fsf@alter.siamese.dyndns.org>
References: <20110428223822.GA16004@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Aman Gupta <themastermind1@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 29 18:28:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFqY5-0005jW-DK
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 18:28:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759984Ab1D2Q2D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2011 12:28:03 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33254 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759837Ab1D2Q2B (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2011 12:28:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 885105192;
	Fri, 29 Apr 2011 12:30:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=hhB0NqarzoGG7OBFwdUtY2opDU8=; b=awLqq1XCYyrYt8XjL9Wa
	5Tqg071oVCAs6gpNlTtRC5C6eXbaU6ylKp/XyLiUPgJWnZOvQznMMEb24jm+PAh8
	frH4WAdRCvaLoXuKnkf1foKkeppIvXIYrrgZLVd3KCN47t6+XBMUY4UreX5mEsDA
	4Od68h3JN335OIrfCPCcQbU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=e+EGy1LKP1CYyv6kQbonn9DLVQ9Q/cNizeX7OwuxPlin4a
	bt4M+aApIsdOx7xjFQiHJhGbmnQ3RK5mlFTq4drgA4U3op6fYJUHdyCQvJYkyY5S
	YqNnILwVE3H821Tr34bMqTa/ZNnznfb3nBnQHM3rLKsnOfJZty5CCY6Htz9Ts=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 38FB2518E;
	Fri, 29 Apr 2011 12:29:57 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E87D8518C; Fri, 29 Apr 2011
 12:29:51 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EBABF636-727D-11E0-8EBB-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172464>

Jeff King <peff@peff.net> writes:

> The problem is that merge-one-file simply assumes it is in the root of
> the working tree without any checking.

It is kind of surprising that there was only one place that you needed to
touch ;-).

Thanks.
