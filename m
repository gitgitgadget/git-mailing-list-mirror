From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] request-pull: Include newline in output
Date: Wed, 09 Feb 2011 16:00:20 -0800
Message-ID: <7vlj1on4h7.fsf@alter.siamese.dyndns.org>
References: <4d51fd61.8937e30a.096e.0a65@mx.google.com>
 <7vr5bgoow3.fsf@alter.siamese.dyndns.org>
 <4d531707.9104df0a.4da1.386e@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 10 01:00:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnJxk-0002Xv-65
	for gcvg-git-2@lo.gmane.org; Thu, 10 Feb 2011 01:00:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756180Ab1BJAAb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Feb 2011 19:00:31 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38473 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756153Ab1BJAAa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Feb 2011 19:00:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 097934262;
	Wed,  9 Feb 2011 19:01:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=v1Dk9LGC+ZlnMslpUXYq9CiTKaY=; b=pbGnxa
	rf1+HF/TpfCdGdrWIj94KSCaCFkkzXSk7PY4Cko4shkDZIW81Cp8lG1pAzefmw7t
	deWBqjjdkIoRbS/C98/xj2UXdLWdqv0QbJI0evClSwHkEGXsugtFStoY9YcYBm02
	RQ5McAgarYqbJrQXyxsU/MOSj8kxIzP970zqU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K9BWhhiTg8vOkpuZ2Xxu9TcmDayQXasS
	VnQbmUx47f7s8rRXHfj6SNHtWWi7JFUGTiYtzgdDrKVUdTZX2Sa3c1hN/sn5s3aD
	U8ySKB9K9MmPM8wKuqoJZtNLKqIxyqlnoL1+DLpQqt4tklJ2fjUHdyzkM1acJVgs
	kevBrWWy2Og=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D98D7425E;
	Wed,  9 Feb 2011 19:01:26 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CA01D425D; Wed,  9 Feb 2011
 19:01:22 -0500 (EST)
In-Reply-To: <4d531707.9104df0a.4da1.386e@mx.google.com> (Michael Witten's
 message of "Wed\, 09 Feb 2011 22\:35\:06 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E7C2053C-34A8-11E0-A11C-F13235C70CBC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166459>

Michael Witten <mfwitten@gmail.com> writes:

> On Wed, 09 Feb 2011 13:54:04 -0800, Junio C Hamano wrote:
>> Michael Witten <mfwitten@gmail.com> writes:
>>
>>> Date: Tue, 9 Feb 2011 02:17:47 +0000
>>
>> WTH?
>
> Woops! I typed that by hand...

Please don't.  We'll pick the dates up from your e-mail.
