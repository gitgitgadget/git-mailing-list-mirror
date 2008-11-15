From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach/Fix pull/fetch -q/-v options
Date: Fri, 14 Nov 2008 19:10:28 -0800
Message-ID: <7v3aht8z17.fsf@gitster.siamese.dyndns.org>
References: <1226708064-19432-1-git-send-email-tuncer.ayaz@gmail.com>
 <7v7i7594cx.fsf@gitster.siamese.dyndns.org>
 <4ac8254d0811141753y18567966h934a5701e168a7bd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Tuncer Ayaz" <tuncer.ayaz@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 15 04:17:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1Bes-0000S1-Er
	for gcvg-git-2@gmane.org; Sat, 15 Nov 2008 04:17:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751739AbYKODKu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2008 22:10:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751736AbYKODKu
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 22:10:50 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47278 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751704AbYKODKt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2008 22:10:49 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 41EBF16B4F;
	Fri, 14 Nov 2008 22:10:43 -0500 (EST)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 803F816B46; Fri, 14 Nov 2008 22:10:30 -0500 (EST)
In-Reply-To: <4ac8254d0811141753y18567966h934a5701e168a7bd@mail.gmail.com>
 (Tuncer Ayaz's message of "Sat, 15 Nov 2008 02:53:33 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FD363132-B2C2-11DD-8D59-C128113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101042>

"Tuncer Ayaz" <tuncer.ayaz@gmail.com> writes:

>> The approach with enum { Q, N, V } cannot express this, unfortunately.
>>
>> So let's do something like the attached patch, instead.
>
> That's ok. We should not break anything.
>
> Do you want me to resubmit a new patch with the changes?

As long as you are happy with the suggested change, there is no need to.
You'd need to sign-off the patch, though...
