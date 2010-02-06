From: Junio C Hamano <gitster@pobox.com>
Subject: Re: notes TODOs
Date: Sat, 06 Feb 2010 10:01:28 -0800
Message-ID: <7vr5oy2qh3.fsf@alter.siamese.dyndns.org>
References: <cb7bb73a1002050444y55f57696gb1b3bd06ab9261ac@mail.gmail.com>
 <m3aavma9gg.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 06 19:02:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ndoyg-00038k-SX
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 19:01:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755908Ab0BFSBn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Feb 2010 13:01:43 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64623 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755746Ab0BFSBm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2010 13:01:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C6BC97CB4;
	Sat,  6 Feb 2010 13:01:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jFdkLnShhArx1ZfXK8NDg2W9Ps4=; b=oYFMyw
	xlYWGFnG1qjnP/yewNuTUSKQRrw3KEALh8cX4SKVPBIZoWVObVg3DyrAzjXUel9g
	PzsweM9L3ldGMIoSNuD1XNIWKgv2orlRoP1NM0K8MI24iKfmZzerD13uLcQujD07
	VOM2hHm1ZxAXzwY+0SgM+2yx+nXi+X5ALgrB8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L2doh+9jYU8EiB4Ie5gFBdR76NLnkLJY
	9o1N3OH02LwBpbjQgdWHM++1B2U60PH5+FU4QacbrI9q4L9WIn84x4uNw1LxC4jm
	tClShhF4T7ipXWulyJJdv8hbKIl3fiOD0JUV8t/gJ3OjreOBdRYmCSZcKE1SWMP6
	Y2HH0egi7yQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4DFA697CB3;
	Sat,  6 Feb 2010 13:01:36 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 60D7797CB1; Sat,  6 Feb
 2010 13:01:30 -0500 (EST)
In-Reply-To: <m3aavma9gg.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Sat\, 06 Feb 2010 03\:30\:45 -0800 \(PST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AAC2F064-1349-11DF-BEC1-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139180>

Jakub Narebski <jnareb@gmail.com> writes:

>   'git notes' move [-f] <oldobject> <newobject>

I suspect "copy" to keep the old one than "move" would be a lot more
sensible, especially when you are talking about people (like me) who amend
often.  They cannot get it right in their first try by definition ;-), and
their very original edition is sometimes easier to start from than their
second edition, when they are trying to come up with the final edition of
the commit.  Using "move" to lose the notes from the old object will make
it harder to go back to the original and start amending from there.
