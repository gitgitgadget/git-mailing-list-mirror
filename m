From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pkt-line: Fix sparse errors and warnings
Date: Sun, 24 Feb 2013 00:36:42 -0800
Message-ID: <7v1uc66rc5.fsf@alter.siamese.dyndns.org>
References: <51290DF4.4040309@ramsay1.demon.co.uk>
 <20130223223134.GA2504@sigill.intra.peff.net>
 <20130223223700.GB2504@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 24 09:37:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9X5B-0007xk-6w
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 09:37:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754119Ab3BXIgq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2013 03:36:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39956 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752202Ab3BXIgp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2013 03:36:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7527BAC56;
	Sun, 24 Feb 2013 03:36:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VpFFx679JRvbLgBW2TMafAGnwOY=; b=SfK3ho
	2wsxFQl7+2NOX2gUTsungF2ERwG4PBEEQHYz58XyPHGdhYmtnehGllA+1PzgX88T
	Vr7rSDJkHteFC+Gh6q93/Dmj4YshwORt7PiXlp0gRfcsfELtIiAUvGbjzGPSyknR
	kZMjuyLg8+uHg3wSyGpwtVutMbU4wFuB2Wh7I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xg7V8/KhiXF3/+YbD3awf0i5B6yjgEX/
	T4A6C5Kk+jdXLszXc7v6FoCvAwIOREg/WLaAa9Yxj55ddZyfYcFt7zhEcpswXafJ
	35xpivOBt52lqgZ5zYXKuIdZE3ZtdNLn/Dv6Joiffb0h+Kj2IdRFt4vwlCFTP7Ln
	YKltDOiNLb0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 55ABBAC4F;
	Sun, 24 Feb 2013 03:36:45 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B6029AC4B; Sun, 24 Feb 2013
 03:36:44 -0500 (EST)
In-Reply-To: <20130223223700.GB2504@sigill.intra.peff.net> (Jeff King's
 message of "Sat, 23 Feb 2013 17:37:00 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5203296C-7E5D-11E2-B995-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216979>

Jeff King <peff@peff.net> writes:

>> Oddly, you seemed to miss the one in connect.c (which my sparse does
>> detect).
>
> Ah, I saw why as soon as I finished off the rebase: that (NULL, 0) goes
> away in the very next patch,...

Yeah, I noticed that myself while replacing 15.  The patch in the
message I am responding to seems to match byte-for-byte with the
result of my rebase, too.

Thanks.
