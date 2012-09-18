From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/8] Doc: Improve shallow depth wording
Date: Tue, 18 Sep 2012 14:54:26 -0700
Message-ID: <7vwqzrj8tp.fsf@alter.siamese.dyndns.org>
References: <1347793083-4136-4-git-send-email-philipoakley@iee.org>
 <7vlig9w6a7.fsf@alter.siamese.dyndns.org>
 <7vmx0nkr06.fsf@alter.siamese.dyndns.org>
 <060D2B93282044BBB6189F04CB34E828@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "gitList" <git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Tue Sep 18 23:54:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TE5kc-00060u-Kp
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 23:54:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755517Ab2IRVya (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 17:54:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41518 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755341Ab2IRVy3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 17:54:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 09BDD8282;
	Tue, 18 Sep 2012 17:54:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YogXYJwLn870Yz5WmZQFqxjOJqI=; b=cv9yXI
	KUrUphfhZgHJ6DhVpy9sewL4GrvpwVp9DN8o8u3cqYloayfT4Hwu1fZTLrm4pzQV
	mN08sJFYxZrlP7Ef3qiEYoyGpUssSNd/R+oDd6sKrBWcnGyCHVTKWptPzp+oqRJt
	QJ6JyGRSsOgnZhBxjdBRh39u5bfjvnpVYI3xM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vGkfUX95ENHpJ227Wl28VL5WJQ5SEkpz
	kfAtSXTN0Kv6lM+vKpmNnfrAbiOOCHvGtsXFnnV2DbOAIbw8ogQ8eLoXylRWEQ66
	KS29kToWKRGPdou7GPv6hdU5qPy1hfOw5L9jmatPLqUnf9AQYMzy9zSN7pGeTsf4
	zDRl9MqXhO8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E6F6D8280;
	Tue, 18 Sep 2012 17:54:28 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5DE6B827D; Tue, 18 Sep 2012
 17:54:28 -0400 (EDT)
In-Reply-To: <060D2B93282044BBB6189F04CB34E828@PhilipOakley> (Philip Oakley's
 message of "Tue, 18 Sep 2012 22:30:07 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6B48BCD8-01DB-11E2-AD76-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205880>

"Philip Oakley" <philipoakley@iee.org> writes:

> And the simple corrections to patches 5/6/7 ? Shall I send?

Juggling topics from many people, it is hard to keep track of how
many out of how many patches in the original series are still
relevant, so I would appreciate [PATCH vn N/M] with revamped values
for n, N and M as appropriate ;-)
