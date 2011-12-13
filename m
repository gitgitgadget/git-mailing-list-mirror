From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 02/51] refs: rename "refname" variables
Date: Mon, 12 Dec 2011 16:37:31 -0800
Message-ID: <7v1us9z4qc.fsf@alter.siamese.dyndns.org>
References: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
 <1323668338-1764-3-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Dec 13 01:37:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaGNH-0000no-Mr
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 01:37:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753890Ab1LMAhf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 19:37:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62084 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753642Ab1LMAhe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 19:37:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B61E0797D;
	Mon, 12 Dec 2011 19:37:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=Y0m4Q6pvXHKcoJ7/Fbac2dt75g4=; b=rDm29F8ITTJNTi36eFGI
	AeYoTS22OSznoy1Vu9LKODZWwprcjtnSUU+vk9LExOtzloEbrsh2PUz30jxKVd5r
	e3NwdDARx0oixeAh0euc+YqMuSRvzHXpV+sPDV6uvdsvGqkYzKLPxhUGfps6kfqc
	ivSx2AYyNjTQiDle/2bpH5A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=tftCxDO8dIikMEwbWGE/jSAFrOE8ZBRSJxj6cC12Ybwi3Z
	DRN46Bc00pmbT1PDK43C9mQTUI8wJXI09ESRl503QwYJrkLoR76/5LHTyFWr04ql
	JePuHbYCUkAMNN1UWG5FWXzkSRbTXxQsK5r8SCD/eYbXfKD//gYHZPEmsp3iE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ACD5C797A;
	Mon, 12 Dec 2011 19:37:33 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 314967979; Mon, 12 Dec 2011
 19:37:33 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A56E8C08-2522-11E1-A9F1-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186982>

This added otherwise unnecessary conflicts with topics in flight, but the
conflicts were nothing Git and a human couldn't manage, and overall it is
not a bad readability change for the longer-term code health.

Thanks.
