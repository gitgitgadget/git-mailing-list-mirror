From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] attribute "eol" with "crlf"
Date: Sat, 17 Dec 2011 11:48:24 -0800
Message-ID: <7vehw3dlo7.fsf@alter.siamese.dyndns.org>
References: <CAN0XMO+OOdTJ+aNMSc2G3RVc7Wfypr4+7dU3US9GVAmMiSJ7cg@mail.gmail.com>
 <vpqr504wf70.fsf@bauges.imag.fr> <7vmxasgqlm.fsf@alter.siamese.dyndns.org>
 <7vr504f5v5.fsf@alter.siamese.dyndns.org>
 <CAN0XMOK0=uxRHcsUmbOE_UrkUcqmRFk-OYnY7kOZkZcWxWOycQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Carlos =?utf-8?Q?Mart?= =?utf-8?Q?=C3=ADn?= Nieto 
	<cmn@elego.de>, git <git@vger.kernel.org>
To: Ralf Thielow <ralf.thielow@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Dec 17 20:48:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rc0FD-00049P-SP
	for gcvg-git-2@lo.gmane.org; Sat, 17 Dec 2011 20:48:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752722Ab1LQTs2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Dec 2011 14:48:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50722 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752440Ab1LQTs1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Dec 2011 14:48:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE0A87A85;
	Sat, 17 Dec 2011 14:48:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=05MJ7UF8f4EN/TsyDneHKt5OcS8=; b=RPDt3W
	twQ77mqhryrmuegFaKwge8GYWhqhjd/wC+6e8fiCIGHjW2fFswLEM2uKjopULxTj
	STUGI6uSfQOhSwXTaQeATsLYRnYnhcJKkzPX3YGhVcGt6qvusCbVNW55Vodl+Xbk
	1chRkpapEHfpVdxs/kcq7oruqYKJ9keT/FdhI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YtLF2Z/ncN6sNnVkVOj135mITCdQjK9Z
	HdW3OTrT50NppQWjmXXIYKZI5ekzJJNevyk+IAdsOsHZrz5fwPPVvhSamMONJXoK
	9RFMIo3hOWhcUIvhr4MQHBdoqkh9vdM93+wM98KgaHgxiu9w66mJ78nyCJ21HfhV
	wZMQM/8ells=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DA96D7A84;
	Sat, 17 Dec 2011 14:48:26 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 445197A83; Sat, 17 Dec 2011
 14:48:26 -0500 (EST)
In-Reply-To: <CAN0XMOK0=uxRHcsUmbOE_UrkUcqmRFk-OYnY7kOZkZcWxWOycQ@mail.gmail.com> (Ralf
 Thielow's message of "Sat, 17 Dec 2011 19:04:14 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 15E8B1AC-28E8-11E1-BBC1-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187404>

Ralf Thielow <ralf.thielow@googlemail.com> writes:

>> Perhaps something like this, but I do not use CRLF myself, so it probably
>> needs to be checked by extra sets of eyes.
>>
>> Thanks.
>>
>
> Works fine for me. Thanks

Ok; thanks. Will queue.
