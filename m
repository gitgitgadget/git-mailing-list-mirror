From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2 (v2)] reset: make the output more user-friendly.
Date: Mon, 17 Aug 2009 12:50:08 -0700
Message-ID: <7vr5vate33.fsf@alter.siamese.dyndns.org>
References: <7vvdl0kau4.fsf@alter.siamese.dyndns.org>
 <1249676676-5051-1-git-send-email-Matthieu.Moy@imag.fr>
 <1249676676-5051-2-git-send-email-Matthieu.Moy@imag.fr>
 <7viqgztj76.fsf@alter.siamese.dyndns.org> <vpq7hxeu4un.fsf@bauges.imag.fr>
 <vpqljlipcs6.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Aug 17 21:50:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md8Dn-00030G-5J
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 21:50:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755217AbZHQTuO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 15:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755158AbZHQTuN
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 15:50:13 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38805 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754328AbZHQTuM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 15:50:12 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 005A7E1FB;
	Mon, 17 Aug 2009 15:50:13 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4FD9EE1F3; Mon, 17 Aug
 2009 15:50:09 -0400 (EDT)
In-Reply-To: <vpqljlipcs6.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Mon\, 17 Aug 2009 19\:31\:53 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2D8CD656-8B67-11DE-A9A1-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126264>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>>>
>>>>  cat > expect << EOF
>>>> -file2: locally modified
>>>> +Unstaged changes after reset:
>>>> +M	file2
>>>
>>> It simply feels backwards when plumbing output says something in human
>>> language (e.g. "needs update") while Porcelain output spits out a cryptic
>>> M or U.  If the goal is human-readability and user-friendliness,
>>
>> The goal here is just consistency.
>>
>> And I do consider 'git diff --name-status' as porcelain.

Ok.
