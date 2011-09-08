From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 4/5] branch: introduce --list option
Date: Thu, 08 Sep 2011 14:03:52 -0700
Message-ID: <7vr53qwxtz.fsf@alter.siamese.dyndns.org>
References: <20110825175301.GC519@sigill.intra.peff.net>
 <0785cac235c3b45537cf161c86dde8e798c4ff3e.1314367414.git.git@drmicha.warpmail.net> <7vfwkodq5s.fsf@alter.siamese.dyndns.org> <4E5A5290.4050005@drmicha.warpmail.net> <20110907195611.GD13364@sigill.intra.peff.net> <4E6889DF.7030404@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Sep 09 01:01:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1nbY-00077n-Ac
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 01:01:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756731Ab1IHXBs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Sep 2011 19:01:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41431 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753112Ab1IHXBk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2011 19:01:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F1D7D52E9;
	Thu,  8 Sep 2011 17:03:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IB0dzhu+bXkpEKv9nhsjswsilBI=; b=ZtRNe6
	AYIMuCrQs3PslU7TxGEqWRGV0ha6GAb4tiJqwCe8yu2RAKW1jVCEmue3hUYC9Evj
	8NopEsHuHniiWK1S2ukgWAwt0KC/UaRN+WhN/4gZl3RlV4Lag/EI04bX4SPGQZoT
	VOWtc2yEFfsMA0HeJ8jg9wwlrKNCcY4+2rMko=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vqjA3OOAMXHffzs3EAeEyczYDXeH3bkM
	+lDdJLjGdyaV7QPjpa0OynmVtRz+54JSCkIquQLeNqgAfAqPRjccAxBoHyTj4lvh
	4a4bz6waU0JMNxSBgUYPKr7IwnTl6GDHQCPgSf+HfzPr8OqDyfxu+UGeKzNyczua
	XyaSYhrMrQQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E7F5952E8;
	Thu,  8 Sep 2011 17:03:53 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7F4FB52E7; Thu,  8 Sep 2011
 17:03:53 -0400 (EDT)
In-Reply-To: <4E6889DF.7030404@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Thu, 08 Sep 2011 11:24:47 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0F0BC942-DA5E-11E0-9D96-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180992>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Jeff King venit, vidit, dixit 07.09.2011 21:56:
> ...
>> It does make me a little nervous about the "'git branch -v'
>> automatically means 'git branch --list -v'" patch, though. It closes the
>> door in the future to us being more or less verbose about branch
>> creation details (and while helpful, it creates a slight inconsistency
>> in the interface).

Hasn't 'git branch -v' meant listing in verbose mode for a long enough
time that changing it now would mean a moderately major regression?

At least my copy of v1.7.0 seems to list with "git branch -v".
