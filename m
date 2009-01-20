From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v2 1/1] bug fix, diff whitespace ignore options
Date: Mon, 19 Jan 2009 23:04:36 -0800
Message-ID: <7vmydmlapn.fsf@gitster.siamese.dyndns.org>
References: <1232275999-14852-1-git-send-email-hjemli@gmail.com>
 <1232275999-14852-2-git-send-email-hjemli@gmail.com>
 <1232275999-14852-3-git-send-email-hjemli@gmail.com>
 <alpine.DEB.1.00.0901181635290.3586@pacific.mpi-cbg.de>
 <8c5c35580901180945u17a69140vff2736765ee6073@mail.gmail.com>
 <alpine.DEB.1.00.0901181929220.3586@pacific.mpi-cbg.de>
 <8c5c35580901181145x2e14fe0fq4ab0e94c13bad38a@mail.gmail.com>
 <alpine.DEB.1.00.0901182201140.3586@pacific.mpi-cbg.de>
 <8c5c35580901181331v5e54f82fxc6a042962ff1cd06@mail.gmail.com>
 <alpine.DEB.1.00.0901182244310.3586@pacific.mpi-cbg.de>
 <8c5c35580901181446n3c36a345m5d8e78764a85c123@mail.gmail.com>
 <alpine.DEB.1.00.0901190218470.3586@pacific.mpi-cbg.de>
 <alpine.GSO.2.00.0901181754190.9333@kiwi.cs.ucla.edu>
 <alpine.DEB.1.00.0901190446480.3586@pacific.mpi-cbg.de>
 <alpine.GSO.2.00.0901191000520.25883@kiwi.cs.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Keith Cascio <keith@CS.UCLA.EDU>
X-From: git-owner@vger.kernel.org Tue Jan 20 08:06:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPAge-0007Im-4o
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 08:06:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754083AbZATHEn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 02:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753958AbZATHEn
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 02:04:43 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51386 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753795AbZATHEm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 02:04:42 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 4E68B1CD8B;
	Tue, 20 Jan 2009 02:04:42 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id DAA4D1CD89; Tue,
 20 Jan 2009 02:04:37 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9C67050C-E6C0-11DD-BB51-BE78113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106448>

Keith Cascio <keith@CS.UCLA.EDU> writes:

>  Fixed bug in diff whitespace ignore options.  It is now
>  OK to specify more than one whitespace ignore option
>  on the command line.
>
> Signed-off-by: Keith Cascio <keith@cs.ucla.edu>
> ---
> Dscho,
> You are right.  The code and the patch are more readable this way.

Thanks; I've fixed it up so there is no need to resend but your patch was
whitespace mangled (format=flowed), by the way.
