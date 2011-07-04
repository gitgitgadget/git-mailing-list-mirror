From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jun 2011, #05; Thu, 30)
Date: Mon, 04 Jul 2011 14:35:44 -0700
Message-ID: <7v62nhohjj.fsf@alter.siamese.dyndns.org>
References: <7viprmq4sy.fsf@alter.siamese.dyndns.org>
 <4E0F67A3.2030001@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Jul 04 23:37:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qdqp6-0007ML-RD
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jul 2011 23:36:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752169Ab1GDVft (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jul 2011 17:35:49 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57918 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055Ab1GDVfs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jul 2011 17:35:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 016106B93;
	Mon,  4 Jul 2011 17:38:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iSX8CKyJKgc1RtfE1gp7Qlmts5g=; b=dlyxlD
	iBEKISvFsepm63lb8/+u+YAsS4qtZqWpqntWwhpm7OcbtCPj8iz8sIeiipzTw8ov
	ANmeedzteoAoTThP8qTeQzQjX6Z86FPaY3B5tE5jlPV0xHsakzcwrsyKzuR0PCLY
	zsKtSQkMjSy9dfeO5i1goMIB/aJU4u5wOqRZk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WoitXafJ82oVjGsYysFua7D1mwhxHXG7
	nBvUWM7CuinYw2NK5BSdZEylN1AMeFEjEKzEUg0OgXHL9v/q6nuiAsIsporZRLvR
	VpYvNv/pPikcmXU5gk52fohG9bHN2N0eayPH3yiqsdirlN+qCpCZnnYtQv5/TMvb
	ZPrJAHYgSsU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id ECE716B92;
	Mon,  4 Jul 2011 17:38:01 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3F3856B90; Mon,  4 Jul 2011
 17:38:01 -0400 (EDT)
In-Reply-To: <4E0F67A3.2030001@web.de> (Jens Lehmann's message of "Sat, 02
 Jul 2011 20:46:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E4542336-A685-11E0-8879-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176604>

Thanks for catching a mismerge before it hits 'next'.
