From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Why /var/cache/git?
Date: Tue, 26 Oct 2010 11:30:04 -0700
Message-ID: <7viq0ohknn.fsf@alter.siamese.dyndns.org>
References: <20101025103006.GA18782@brong.net>
 <4CC5A13F.2090702@eaglescrag.net> <20101026012224.GA3360@brong.net>
 <1288099299.8291.6.camel@drew-northup.unet.maine.edu>
 <20101026152218.3931.qmail@d862ae2b10e11a.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Drew Northup <drew.northup@maine.edu>,
	Bron Gondwana <brong@fastmail.fm>,
	"J.H." <warthog19@eaglescrag.net>, git@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Tue Oct 26 20:30:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAoIA-0003Zp-Av
	for gcvg-git-2@lo.gmane.org; Tue, 26 Oct 2010 20:30:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933494Ab0JZSaU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Oct 2010 14:30:20 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56099 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756342Ab0JZSaT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Oct 2010 14:30:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 97A31E15A2;
	Tue, 26 Oct 2010 14:30:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SzTgC3uFD/1vK36Qcx27jJji7VQ=; b=evXvFD
	Prv7RlHglF52rdIccZlo2MVzarFG8sgbKYfFekxUS7zDbaSV7MQczBU4zKyGDI+8
	VzrSHbFemtLtU0InN0EUKccQ2wPM2zq7quCFi/41l61drKLawe2wkpVCrg9Pzzt8
	IYtxZbHYqEcGUi3dQUEj96CS7Hako/Ij9MSpE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iVJJ0wVD37Ai/SnRU5gzw/fEA56V0GDZ
	9yMHJCdyDjPWoj9iK81NPgph9JCjjTVNG55pCpjhpXj29Z5Tc+Es805ljswdRFej
	XuNjoFoygRT0nIbhyCzCGNULyKOrIQjRIczZaM2Vr6C+X+UmAegzuT0YzdEYkpMy
	tZ3Vlq27RDg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 469F2E159B;
	Tue, 26 Oct 2010 14:30:12 -0400 (EDT)
Received: from pobox.com (unknown [76.102.169.49]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5CEEDE1598; Tue, 26 Oct
 2010 14:30:06 -0400 (EDT)
In-Reply-To: <20101026152218.3931.qmail@d862ae2b10e11a.315fe32.mid.smarden.org> (Gerrit
 Pape's message of "Tue\, 26 Oct 2010 15\:22\:18 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 11CA819C-E12F-11DF-B4ED-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160002>

Gerrit Pape <pape@smarden.org> writes:

> Hi, it's also not my preference, but Debian adheres to the FHS.
> Unfortunately /var/git is not allowed by the FHS, so a different
> location must be chosen for Debian.

It seems that /var/lib/ seems to be more appropriate place to store
persistent database-y stuff. I see e.g. /var/lib/postgresql there.
