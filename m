From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bringing a bit more sanity to $GIT_DIR/objects/info/alternates?
Date: Sun, 05 Aug 2012 12:01:12 -0700
Message-ID: <7va9y940zr.fsf@alter.siamese.dyndns.org>
References: <7vmx2a3pif.fsf@alter.siamese.dyndns.org>
 <501E3F04.4050902@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Aug 05 21:01:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sy64m-0003A8-Dn
	for gcvg-git-2@plane.gmane.org; Sun, 05 Aug 2012 21:01:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754899Ab2HETBP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Aug 2012 15:01:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40576 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754836Ab2HETBO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2012 15:01:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F00C8A7F;
	Sun,  5 Aug 2012 15:01:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pzen4u6+9n0HyXBWM58JaXhZoa4=; b=NsDRFn
	h+l/AKk5g0uucB2MmO3J2nd0DDte37ZlHIeGCwCV53WpcjRn1ODaOKALzGDVckJE
	FKeY9Su+t/x/nyt/caCKxLzYl7GLU7HgMJzS+ClWbgkC0DZ2y7a/FzJgHn5jvwGg
	l2c8u6+24va5FEuNZ8X3LqQ23QNJmeFZz5CE4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XkV00A7nPSp03H20+jNDnDNqo7gSmCK0
	onMpMEQDumjTPwusFkYMms6qxVaeQtOevwcgIkNdGCcIS+fiQYjSlW7We8NgB40c
	DhKpRRuiY8hefWOsXpxcThHV0yf4DNw17ipEb88PWnsu/QLUMHu0Pz5EViAcboot
	Gshjs6TgnfY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5CF8B8A7D;
	Sun,  5 Aug 2012 15:01:14 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CE9DE8A7B; Sun,  5 Aug 2012
 15:01:13 -0400 (EDT)
In-Reply-To: <501E3F04.4050902@alum.mit.edu> (Michael Haggerty's message of
 "Sun, 05 Aug 2012 11:38:12 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ED7AE790-DF2F-11E1-B116-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202917>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> I have some other crazy ideas for making the concept even more powerful:

Sorry, but the "a bit more sanity" topic is not interested in making
the concept powerful at all.

This is about making it usable with ease without the user having to
worry about "oh, I was about to shoot myself in the foot by running
repack; it is good that I remembered objects in this repository are
borrowed by other repositories" and things like that.

For the purpose of "a bit more sanity" topic, adding new things
users have to worry about to the mix, e.g.  "what happens if my
network goes away?  I can afford not to have access to these kinds
of objects for a while, but I must always have access to those
objects, so I can borrow the former but not the latter", is going in
the other way.

The ideas in your messages are *not* useless.  Enhancements along
those lines may be useful, but they do not fit in the same
discussion of making the current mechanism simmpler and easier for
users to use the mechanism in a safe and sane way.
