From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] tests: eliminate unnecessary setup test assertions
Date: Sat, 07 May 2011 15:05:24 -0700
Message-ID: <7voc3eupy3.fsf@alter.siamese.dyndns.org>
References: <20110503090351.GA27862@elie> <4DC1CE16.5030808@dailyvoid.com>
 <7vsjsuc704.fsf@alter.siamese.dyndns.org> <20110506205441.GA20182@elie>
 <20110506205851.GB20182@elie> <20110506214801.GA17848@sigill.intra.peff.net>
 <20110506221300.GB17848@sigill.intra.peff.net>
 <7voc3fxy6b.fsf@alter.siamese.dyndns.org>
 <20110506222951.GA24474@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Michael Grubb <devel@dailyvoid.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun May 08 00:05:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIpdA-0001OX-CS
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 00:05:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755824Ab1EGWFk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 May 2011 18:05:40 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48038 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755110Ab1EGWFj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 May 2011 18:05:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8EED94E14;
	Sat,  7 May 2011 18:07:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9UScwrdDyVeBMm06ihGXSATYsMc=; b=yBTF9v
	A/+rg41sIXidY3UdyCiUrMkQK/yqYNPvuMs8C6RSrtxjVkXecukuCnztcezpP9RX
	76RZ3j417CZq5YEbtX5rIH6OX8M+VmtPMeOscV2n0k65NygiEjyCTr1qRn5dSI/e
	rrccVl7nJxWooTWe1mNdd6Cn02ko/segVWuQA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SBtXXpzD2qpRTLZoPd/spybPb+bDHaF5
	N2sWdc4mWTO5EjudVd9q/86zBerTTwI4VrRD+QYMOhwlwq/ZJOcVc1S1qHvyLRDq
	8NuomujekzyhPWLRqiMeqE2GgFa/1NptBegIvWj7XEF8MI6IVG25HF+6Y2BAIls3
	aEsciWfMj/M=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4DC144E10;
	Sat,  7 May 2011 18:07:37 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0BA0E4E0E; Sat,  7 May 2011
 18:07:31 -0400 (EDT)
In-Reply-To: <20110506222951.GA24474@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 6 May 2011 18:29:51 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6AEDF556-78F6-11E0-8417-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173068>

Jeff King <peff@peff.net> writes:

> I think multiple -L is not quite enough. I want a single "-L" that
> matches every instance of a pattern, like:
>
>   -L "/ ()/,+0"

Of course I am aware that needs to be a part of the multiple -L topic;
after all I was the one who invented -L "$regexp" support ;-)
