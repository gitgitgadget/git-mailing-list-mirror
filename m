From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Change octal literals to be XEmacs friendly
Date: Fri, 23 Jan 2009 21:16:17 -0800
Message-ID: <7v3af9p9lq.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0901240219530.19590@linmac.oyster.ru>
 <874ozp79y4.fsf@Astalo.kon.iki.fi> <878wp1mphq.fsf@linmac.oyster.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: malc@pulsesoft.com
X-From: git-owner@vger.kernel.org Sat Jan 24 06:17:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQaty-0005QA-PK
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 06:17:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbZAXFQZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 00:16:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbZAXFQZ
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 00:16:25 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42645 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750724AbZAXFQZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jan 2009 00:16:25 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A8CB91D085;
	Sat, 24 Jan 2009 00:16:21 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id ECE6C1CD24; Sat,
 24 Jan 2009 00:16:18 -0500 (EST)
In-Reply-To: <878wp1mphq.fsf@linmac.oyster.ru> (malc@pulsesoft.com's message
 of "Sat, 24 Jan 2009 05:01:21 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 23606A7C-E9D6-11DD-9FCF-BE78113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106953>

malc@pulsesoft.com writes:

> Kalle Olavi Niemitalo <kon@iki.fi> writes:
>
>> Vassili Karpov <av1474@comtv.ru> writes:
>>
>>> #ooctal syntax on the other hand produces integers everywhere.
>>
>> GNU Emacs 20.7 doesn't support #o, but neither does it include
>
> Bummer

To be portable you could certainly spell them in decimal integers, no?
