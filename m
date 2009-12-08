From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 1/2] t3404: Use test_commit to set up test repository
Date: Tue, 08 Dec 2009 01:25:28 -0800
Message-ID: <7vy6ldg6lz.fsf@alter.siamese.dyndns.org>
References: <7vskbn9s1k.fsf@alter.siamese.dyndns.org>
 <1b82a55c2a45b8f40ac0fe42d4ce2a55e72a2557.1260177312.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, git@drmicha.warpmail.net,
	Johannes.Schindelin@gmx.de, bgustavsson@gmail.com
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Dec 08 10:25:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHwKK-00041u-LP
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 10:25:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752468AbZLHJZh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 04:25:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752421AbZLHJZg
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 04:25:36 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44682 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752233AbZLHJZf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 04:25:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 119BDA525E;
	Tue,  8 Dec 2009 04:25:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=Al2DqyiWW/seICJu6mIq5GMbegE=; b=MQBt+n3m93j2wIZdVWnNR7x
	NdYfENR/PUXcAhbSIcZD0mN+A0Q9pIFKm/H9cHowFC75se3NS7yNwNr05xWEwUX4
	iwYzbbfm/Te7h37swAvs9dRbJ2EPxr60QGaC32/TzKyXn5fejADFe1Ta5ANcFnmM
	FcJE678CPyF3VnCFAQg8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=fdzoVmg7HKazHL25siGNIRpB1H/Y7UYimrLr/duM8F6D1PtS/
	bPzqTCa3RwatJ1ATkyZLYT4uWl2rhZbcUIgnYPeX4uCz5OmugVOGIXPouVUW8qNZ
	beEVZQfL1nQC/RZtt3tnd1BX75xF0jVUzpImUmg7uM6TiploBdN40fRZT4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B981EA525D;
	Tue,  8 Dec 2009 04:25:36 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0A0A6A525C; Tue,  8 Dec 2009
 04:25:29 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A4A2EED4-E3DB-11DE-ABBB-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134846>

Thanks; will re-queue [2/2] as [1/2] seems to be unchanged.
