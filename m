From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Including git-describe info as version strings for generic "-v"
 output
Date: Sat, 21 Jan 2012 14:03:28 -0800
Message-ID: <7vd3acbtn3.fsf@alter.siamese.dyndns.org>
References: <CAG_NL2So7cf6o+en9ktHGr94Eu5WJ9giWq6OmSxK+ZL4RdtaGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Harry portobello <harryportobello@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 21 23:03:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Roj27-0001rD-Pw
	for gcvg-git-2@lo.gmane.org; Sat, 21 Jan 2012 23:03:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751659Ab2AUWDb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jan 2012 17:03:31 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64165 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751635Ab2AUWDb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jan 2012 17:03:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CB9C273E7;
	Sat, 21 Jan 2012 17:03:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=N0AZMEKyx2kSMoM2ExdQ8y/4cXI=; b=bSl9KO
	SRWjCMHCKuhyL4+E3+gd6TaVEOgJFkkPMLn2CJ8FQpqwZNpVBMz/4PttADaTHZr+
	FGKDtjmpnzXJ++OqYdlCRN3KLuhqwSt49q3zTSBp6tnszlxtcbVSdjR8kgOE7goM
	3V/NhDbr2SiOJfRkVoLPmc1mgTDg8LGRbQM3g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XKq7GkhceRu5slxbB/KscmHZQj9WtcHn
	xuSvCcTrOAPfgFpxFeclW84RzMA1sB82OyC9LdnoYQKhwai9sJeEUrYX1OsN8Wzu
	jpoqL93Zb2C98aMlyooh/NaA4ferS5Rhqrq/iRZydjYZ7q/aLGjermjEqdFgpn4u
	O61ddacFx7w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C343D73E6;
	Sat, 21 Jan 2012 17:03:30 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 570FF73E5; Sat, 21 Jan 2012
 17:03:30 -0500 (EST)
In-Reply-To: <CAG_NL2So7cf6o+en9ktHGr94Eu5WJ9giWq6OmSxK+ZL4RdtaGA@mail.gmail.com> (Harry
 portobello's message of "Sat, 21 Jan 2012 19:09:56 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C0C58BB4-447B-11E1-B148-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188934>

Harry portobello <harryportobello@gmail.com> writes:

> I hope the subject makes sense -- I'll explain what I'm trying to do.

Perhaps take a look at GIT-VERSION-GEN that is part of the Git source?
