From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] string-list: remove print_string_list, since it is not
 used anymore.
Date: Mon, 11 Jan 2010 14:14:27 -0800
Message-ID: <7v3a2ccmrg.fsf@alter.siamese.dyndns.org>
References: <1263245389-1558-1-git-send-email-tfransosi@gmail.com>
 <alpine.DEB.1.00.1001112252040.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thiago Farina <tfransosi@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 11 23:14:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUSX4-0003JR-Vi
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 23:14:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191Ab0AKWOi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2010 17:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134Ab0AKWOi
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 17:14:38 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54024 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809Ab0AKWOh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2010 17:14:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AA711908C1;
	Mon, 11 Jan 2010 17:14:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nhgvnUcOlG16S8qGcRPS7RygBmU=; b=iv0kpe
	LqBz1LQrCpL9MfJVfWXtob49guBMcs7fWy+cnec/ukhbmot1yF8uGYlHGV95fXaB
	1MPanTMoSCdbicDiZtQ3jGm0mzwZplo6FiA7n1JLrvRV19Mv2dKRusbsft/zylc/
	fCGM3JyoRbvUtx+3X42o3XVuvqg100Xuuq5oU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ERRY0sJrYWZuWHiKZmRojZ6/yDSSDJHd
	RkAo52MmgSy25qrRPISkmckP05VhnDHQvVPvlCfhAoWA6pMAcXypynbrH+Ew9MgC
	g19MXsotYNSJRk3W+Z7yvGPhv1PKiuuAcuXxtIkkm2EDnShi0+t1X4bvrhw3bFoz
	2NQPS3Muq1o=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7487D908BD;
	Mon, 11 Jan 2010 17:14:32 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A9815908B9; Mon, 11 Jan
 2010 17:14:28 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.1001112252040.4985@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Mon\, 11 Jan 2010 22\:52\:27 +0100
 \(CET\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B1B81E44-FEFE-11DE-8EEC-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136671>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Mon, 11 Jan 2010, Thiago Farina wrote:
>
>> Signed-off-by: Thiago Farina <tfransosi@gmail.com>
>> ---
>
> It was never used, except for debugging.  Does it hurt you really all that 
> much?

Exactly my feeling.

I think I discarded at least two other patches sent to me to remove this
"unused" (but obviously meant for debugging) function in the past.  I
guess we'll keep the function this time, too.
