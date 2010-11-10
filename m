From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 0/5] Handling of rfc1991 signatures
Date: Wed, 10 Nov 2010 09:41:27 -0800
Message-ID: <7vk4klhy9k.fsf@alter.siamese.dyndns.org>
References: <cover.1289041051.git.git@drmicha.warpmail.net>
 <cover.1289387142.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thiago Farina <tfransosi@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Nov 10 18:41:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGEg2-0000lC-4H
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 18:41:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752152Ab0KJRlh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Nov 2010 12:41:37 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53830 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751556Ab0KJRlg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Nov 2010 12:41:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 46F9424A6;
	Wed, 10 Nov 2010 12:41:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=d8SN2ftBLo8S+nEqUgWPPSiFfoY=; b=mUPJsc
	J9pU2dP7WsT6wY0yJl3pyxb85HU99sOsRzMGioOLMimcOOd35jhMm0DbjPFKpUcw
	s9IknJ6UpiAmCmrZlg7vwO6NsN2q5L9M6WeH7n4Ws1sdfOAaC0MhkQmLcO/tYClV
	wflLRS5gY0nNCcIQpvpSK6X64E8MoWQyb5KLY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KlYmMMOXEzng/UL6CIPLI0X0qT7pEPVR
	KRT4lqmm89R35Y1PVeoe6jbSIWtCiqIhv7qDU6E98CH+uKgkqFNcxGJuIAkhQ2Dx
	EMjr5GPw02E1lxGnMnhy5zjEM2aJTiu4cvL/ElaBl7K03ijzrwsLIJFEmyBtSD/t
	TLwA8O1aR/4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 17BA124A5;
	Wed, 10 Nov 2010 12:41:37 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id F06D5249E; Wed, 10 Nov 2010
 12:41:32 -0500 (EST)
In-Reply-To: <cover.1289387142.git.git@drmicha.warpmail.net> (Michael J.
 Gruber's message of "Wed\, 10 Nov 2010 12\:17\:25 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C4645AB2-ECF1-11DF-B91F-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161165>

Thanks, will queue.
