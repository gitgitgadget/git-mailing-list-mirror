From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Q about the date format in "git commit --date=..." and such
Date: Mon, 07 Mar 2011 16:20:59 -0800
Message-ID: <7vzkp6zclw.fsf@alter.siamese.dyndns.org>
References: <4D73B158.5040409@dirk.my1.cc>
 <20110307165448.GD11934@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dirk =?utf-8?Q?S=C3=BCsserott?= <newsletter@dirk.my1.cc>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 08 01:28:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwkmO-0005tq-PY
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 01:28:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756835Ab1CHA1y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Mar 2011 19:27:54 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43414 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754439Ab1CHA1x (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Mar 2011 19:27:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 93DC3459A;
	Mon,  7 Mar 2011 19:22:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=eAV6D4XEihOmxV3YBAyTTks0SD4=; b=FA5Pu+aPhu9RmLUBSApp
	pY9VKOhv5eV3/TGYPyfLnSIGGbmTNkUD+20mZsHqxPla3uOfVaYoYTbZT0JgL9lS
	jX1TlczpD5DwHZ0+YCMAinayruQJIqujwjkqfMz/lTYZnXcB8zVc5phoAmspHhPk
	4jmB8fuFyP4TWk7ErcWfOMw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=q0xaCiAGjb7mQtIUgEA73D8VercJ8Up40b2TICO75SJWoL
	L7yDp6R8yUOGfRuBeltKjn5RdCFz7Dz+PGzoMAWOJnEWmHjryis+8rW1N9uGH9+c
	7DnDr/WUkJgtz1MUAG/nbUroujTUcyMPH7s28qBsKmxnXDuC774C8ruZdmor8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4987F4599;
	Mon,  7 Mar 2011 19:22:32 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 422544598; Mon,  7 Mar 2011
 19:22:28 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 28B79E8C-491A-11E0-907C-B86344810875-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168623>

Jeff King <peff@peff.net> writes:

> That being said, with --reset-author I have never needed --date, so I
> don't personally care if it gets done or not.

In short, should I take that the resolution of this issue is "I didn't
know about --reset-author and asking for --date=loose was an X-Y problem"?

I agree with you that we would not want to loosen the specification side
(i.e. "commit --date=" as opposed to the selector side "log --since=")
unless we absolutely have to.
