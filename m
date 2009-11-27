From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: determine the list of header files using a
 glob
Date: Fri, 27 Nov 2009 10:28:38 -0800
Message-ID: <7v7htbom95.fsf@alter.siamese.dyndns.org>
References: <4B0F8825.3040107@viscovery.net>
 <20091127082624.GA19875@glandium.org> <4B0F92E7.8090403@viscovery.net>
 <20091127085802.GA21217@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri Nov 27 19:28:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NE5Yr-0006Hv-UZ
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 19:28:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752752AbZK0S2m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2009 13:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752425AbZK0S2m
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 13:28:42 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36888 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422AbZK0S2l (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2009 13:28:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A296CA23B8;
	Fri, 27 Nov 2009 13:28:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=ZldCpt6Yjsy1BHKKmRsHAwuYsc8=; b=iGI6oXBSAXgKVtTiRnrbKPJ
	Vy697CiVQSOLF1OV4v6gJNQB3363JT3Hl5rpqBw9d3Z67gl97wU5GFKQFqEAcxV1
	fmw7q9A89l2fxptpnKznok97MUzxCigeqXHmPil+hgET7RiQniAE/HoFNkMcwKmx
	3HVVcu3Gaz84YZU1S6TA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=TKPPVbdCIfjcvJz4Y7SL6Jjz4rGQ3jvJK35X3jtI2mdqKKLSH
	vwV1DqyffA0Fy0jYecAoTO/nV4H6dO0xCfj03xcXN/Ap1FaJaDcGnIXxg8yZAyXq
	69AnphrL0/pxJOJ9yPL4vssuoNW2QqRMZ3ecqIxdiU+qvNdVOLlkUtQPls=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 74DB6A23B3;
	Fri, 27 Nov 2009 13:28:44 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2B4C5A23B2; Fri, 27 Nov 2009
 13:28:39 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B1E2236E-DB82-11DE-A5A6-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133916>

Mike Hommey <mh@glandium.org> writes:

> On Fri, Nov 27, 2009 at 09:50:47AM +0100, Johannes Sixt wrote:
>> Mike Hommey schrieb:
>> > I don't know if the current Makefile works with Solaris' make,...
>> 
>> No, it doesn't. You have to use GNU make anyway.
>
> Then it's fine. But shouldn't that be noted somewhere, like in the
> INSTALL file ?

Surely.  Please make it so.
