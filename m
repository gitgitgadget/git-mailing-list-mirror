From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git 1.7.0.rc1
Date: Sun, 31 Jan 2010 10:28:53 -0800
Message-ID: <7v4om2f7ru.fsf@alter.siamese.dyndns.org>
References: <7vaavvi4r5.fsf@alter.siamese.dyndns.org>
 <vpq3a1maa4y.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Jan 31 19:29:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbeXo-0002NT-Jy
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jan 2010 19:29:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752631Ab0AaS3F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2010 13:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752593Ab0AaS3E
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jan 2010 13:29:04 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55118 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751323Ab0AaS3D (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2010 13:29:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0372495C74;
	Sun, 31 Jan 2010 13:29:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PuzHsr74DQhOD1CABwAu5nZMGuo=; b=eY6iEH
	gc89DZ1iZlRNhzRmQJ4zwyKWE51X0gytazcSSlghRSTuuKtKV+lChuoFiZcHL5Nx
	z2VxXg9uzUhUyUXu+Ix88Z7Ows39dgutw/Cab7T7SOTeF3JqMoC7r6S8tCDEcWvW
	GH3qk7g4povWni7L22DT6fWExOYI1zIrLrmh8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nswAfBoIpyhOv6ZMtKl5rhBf+UOinQ8X
	aMK3fF/+7AmVW4dhiPj35DljM296u5VVS5UB5uUA/0Lc6lJG6JhjaSyE6VS/6rqf
	euEIN5fJCoPwzgTJ2uy4ITVtcLah5PTRzAdLHWry1qrQVPrPIpyDBEKPbJ/DpaCW
	XByuxkLtW70=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D029495C72;
	Sun, 31 Jan 2010 13:28:57 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3FB2995C71; Sun, 31 Jan
 2010 13:28:55 -0500 (EST)
In-Reply-To: <vpq3a1maa4y.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Sun\, 31 Jan 2010 10\:36\:45 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7EB6E62C-0E96-11DF-9F08-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138547>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> I suggest s/pathspec/argument/ in the sentence above:
>
> * "git status" is not "git commit --dry-run" anymore.  This change does
>   not affect you if you run the command without argument.

Thanks; that makes sense.
