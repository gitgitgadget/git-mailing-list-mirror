From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Why Is There No Bug Tracker And Why Are Patches Sent Instead Of
 Pull Requests
Date: Thu, 01 Mar 2012 12:23:29 -0800
Message-ID: <7vy5rkkr3y.fsf@alter.siamese.dyndns.org>
References: <CAM=oOO2i-9zraF-YG5YzvZEmN1eXTnQfhJ-eMF04NP7HGtf41w@mail.gmail.com>
 <7vhay9tqs6.fsf@alter.siamese.dyndns.org> <20120229225304.GA9099@burratino>
 <CAH5451miv_Mo_9tZV+mfDEHuEX0491duqAYh66aOzLsMLTNkaA@mail.gmail.com>
 <rmifwdti2ap.fsf@fnord.ir.bbn.com>
 <CAP2yMa+op58gbUPXvyHdx+cLcCBgHmmuBKGBojxA+puDRPSp1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Greg Troxel <gdt@ir.bbn.com>,
	Andrew Ardill <andrew.ardill@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	opticyclic <opticyclic@gmail.com>, git@vger.kernel.org
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 21:23:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3CXK-0006ns-Rx
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 21:23:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757487Ab2CAUXd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Mar 2012 15:23:33 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57533 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754882Ab2CAUXc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 15:23:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7E642705D;
	Thu,  1 Mar 2012 15:23:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cWnlqvP0Y4cebqFfi5UFrYyEw3o=; b=TURZk5
	VOzJXpqGiVF5LFUmysdhWzDRkcyEk6t3L2ZENuMWzOZSc0P6Kh5NYpK8jAaK647G
	0i64d1kIKUKeVHENDHg45z9a0dzDFoIKLQte1FL7Tqmjeq54n7UcGuvNrQQG5W7T
	8QbQLwfaG7+FVD62e3c8JQjY/bMAq0h1C/G0I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UBMl+KOzAsMd8Rf+I/j7ovObEanWYd8K
	Rlcg8nd2ky6f3jFFnUFWYOxek6Xy0SDADRL2Rh5e8/dzTO2x7H2cV09pz9qpoMu6
	bECXk3u2kScyTc1zBizkiTR7InYoRhMRW7zmwau/axMe5x8ToVsMOiMZeY+LRP+a
	LZfQy7bJ+R8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 72441705C;
	Thu,  1 Mar 2012 15:23:31 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F26C47058; Thu,  1 Mar 2012
 15:23:30 -0500 (EST)
In-Reply-To: <CAP2yMa+op58gbUPXvyHdx+cLcCBgHmmuBKGBojxA+puDRPSp1Q@mail.gmail.com> (Scott
 Chacon's message of "Thu, 1 Mar 2012 08:52:53 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6969B6E4-63DC-11E1-968A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191968>

Scott Chacon <schacon@gmail.com> writes:

> So free is great, but what is more important in the tooling and
> services that help you develop?  Is it freedom to some arbitrary
> level, or is it simplicity and availability? I value my time a lot
> more than if I can get the source code to the issue tracker that my
> open source project uses.

I do not particularly want to say this, but I couldn't resist wondering
how the above "The best tool for the job, be it libre or commercial"
compares with what Linus would have had in his mind when the kernel
project decided to use BitKeeper.
