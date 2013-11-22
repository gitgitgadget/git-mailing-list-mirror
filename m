From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] drop support for "experimental" loose objects
Date: Fri, 22 Nov 2013 09:23:32 -0800
Message-ID: <xmqqli0g1hbf.fsf@gitster.dls.corp.google.com>
References: <20131120203350.GA31139@kitenet.net>
	<20131120213348.GA29004@sigill.intra.peff.net>
	<20131120222805.GC26468@kitenet.net>
	<20131121114157.GA7171@sigill.intra.peff.net>
	<20131121160426.GA21843@kitenet.net>
	<CAP8UFD2S1HUDYLbmEGFqLcBFExuB0h7=gqwsQ0qjpMSc+YaXog@mail.gmail.com>
	<20131122095801.GB12042@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <christian.couder@gmail.com>,
	Joey Hess <joey@kitenet.net>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 22 18:23:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjuSD-0003ml-63
	for gcvg-git-2@plane.gmane.org; Fri, 22 Nov 2013 18:23:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755578Ab3KVRXh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Nov 2013 12:23:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34959 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753041Ab3KVRXg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Nov 2013 12:23:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 748CF53DA9;
	Fri, 22 Nov 2013 12:23:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0uOQyFWGt921EzihuwpOH+RRBSg=; b=VMJFU9
	PvlG3JALQFt/V4DoEBfDK+WETOmdW7qFIQY/bAEyKLD7ebOEqld4Ljt+4qjullwq
	kxezUMjwmf3v3eF4qgNBn0YsBcOa6kv602vnZ3hUeRAEnsmjIKtXC9W3StL9zXMj
	O+6xALV7JK9mVRSqWI/huI7t7F2IxFW1f1cFA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mb0ct03bHjUP7uqJKgdVgqlQDpEpWD3g
	MLHjKUu8uA+oQNDSYjOD0XSHgSLPbKFECYKo9fi2dOLoYCxAw96G/ROROwn7g6cZ
	M7rPtP8Wo88bJWx3A1H3AG773NZYyYfoY+OS3NkjjVes3z50GWnhzGfZ6JklohhH
	PjwiGaEf4uA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 629BA53DA7;
	Fri, 22 Nov 2013 12:23:35 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A0F2D53DA6;
	Fri, 22 Nov 2013 12:23:34 -0500 (EST)
In-Reply-To: <20131122095801.GB12042@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 22 Nov 2013 04:58:02 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D0EFA6F2-539A-11E3-A56B-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238198>

Jeff King <peff@peff.net> writes:

> I guess we would need to audit all the sha1_object_info callers.

Yup; I agree that was the conclusion of Christian's thread.
