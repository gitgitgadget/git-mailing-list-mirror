From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git push --track
Date: Fri, 15 Jan 2010 10:18:06 -0800
Message-ID: <7vska7z0yp.fsf@alter.siamese.dyndns.org>
References: <op.u6g8jnixg402ra@nb-04>
 <be6fef0d1001131727r128c7727td2b948018d308719@mail.gmail.com>
 <20100114070316.GC1528@rm.endoftheinternet.org>
 <7vr5ps5jx1.fsf@alter.siamese.dyndns.org> <87y6k06wgz.fsf@catnip.gol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rudolf Polzer <divVerent@alientrap.org>,
	Tay Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Fri Jan 15 19:18:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVqkY-0005CP-2h
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 19:18:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757986Ab0AOSSS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 13:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757984Ab0AOSSS
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 13:18:18 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33887 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757960Ab0AOSSR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 13:18:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D64B919C4;
	Fri, 15 Jan 2010 13:18:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=Kj+Vg4gt3MBbpGqYrCYjchf9dLk=; b=CKhxpLHZlBtdDOEJ1FvLpqP
	VHOS+JyMRgqSRcSxZmzE6L/PzmDvYarYdnku269VjuxRrMN9W6oqZ1KVUtBEFWbs
	wOJJRavZPfl4ni51y9yMrUXFir/ErYPLlHySZu8tHKkmSAOidh0RTrYs1lMnym6f
	X2jdEFuh1csuzVA/n00g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=wDlCK6PD969ieKD38puD1idWFHooEGbt/2OgtG3PXjVncARJT
	mF/zphPyIcxEKFCvS0sJrnXD2jnI+rTEGwkM5j7DNV/ROnhBKaU8YzcVo9SQe7uz
	o3w/wErnduh109PR1uT4l/asZWy3MLoqcsXt3rZPiBZrCoemSvyQXfv9xM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E7DB6919C3;
	Fri, 15 Jan 2010 13:18:12 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 19DFB919BD; Fri, 15 Jan
 2010 13:18:07 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 57B6A3DC-0202-11DF-9691-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137094>

Miles Bader <miles@gnu.org> writes:

>> And it doesn't add --track to the UI.
>
> That's not a positive...

Oh, that is definitely a *HUGE* plus.  I wouldn't go so far as to say that
the word --track was a mistake.  But the thing is, unfortunately it has
already been contaminated by people using it in two completely different
ways and ended up confusing new people.  Some use it to mean "this branch
forked off of and builds on top of", and others use it to mean "this ref
holds a copy for reference purposes".
