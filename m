From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] gitweb: Make linking to actions requiring JavaScript
 a feature
Date: Thu, 26 Nov 2009 18:39:01 -0800
Message-ID: <7vy6lsy9mi.fsf@alter.siamese.dyndns.org>
References: <1258659887-5244-1-git-send-email-bebarino@gmail.com>
 <200911262112.16280.jnareb@gmail.com>
 <7vws1d3tzk.fsf@alter.siamese.dyndns.org>
 <200911262224.36371.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Stephen Boyd <bebarino@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 27 03:39:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDqjy-0004d0-Ly
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 03:39:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753714AbZK0CjG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2009 21:39:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753711AbZK0CjG
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 21:39:06 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63329 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753674AbZK0CjE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Nov 2009 21:39:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 248D283155;
	Thu, 26 Nov 2009 21:39:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=8T4f0zY/fDQhgcOxGvH24rRRywU=; b=xCt/wF+VQq9NRLoGuDTjquV
	i5RghL19WB0NPZH1txn+So6lczbleNoCo+Tov3kp8CHnxvYBYnPiQVBDD4639orz
	mPsy1aZ+XKfTU3jXv9LLNY2xLb28MAHilXyeIJ3hUpGZY5gW77wLxXKZ5ZERMeMU
	B8ZrbuMxAQwg0X3wLT6s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=YTylfH/2dlcTZRgRebfpujO8g9nNh4Y+VRinPUgwVNx0u3D3q
	8SR5GI9TeY2A/q4K0bS0mr8k+D3Vb0+jHPDlnoRXShxUfZa0xyNkx29cUJI9pY6M
	AIdogz6eDWfvLAE/iwPpW3dGYn72Iel7ZoB2ji13NPzeEeMNzUwxG8L+II=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D200283150;
	Thu, 26 Nov 2009 21:39:07 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 105FD8314F; Thu, 26 Nov
 2009 21:39:02 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 092A789A-DAFE-11DE-89FF-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133854>

Jakub Narebski <jnareb@gmail.com> writes:

> It might be however good *interim* solution, so people would be able
> to test 'blame_incremental' view without having to edit gitweb links.

Exactly.  I thought you were responding to my earlier "ship it as a new
feature with known breakage so that people can choose to enable to help
debugging and fixing".  If flipping on the new implementation makes an
alternative working implementation unavailable, that would be one reason
the site owners might consider _not_ enabling it.  By making them both
available, the result will have one less reason not to try for site
owners.
