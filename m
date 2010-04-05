From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Link against libiconv on IRIX
Date: Mon, 05 Apr 2010 10:15:59 -0700
Message-ID: <7vfx39q0q8.fsf@alter.siamese.dyndns.org>
References: <20100329105748.GD14869@CIS.FU-Berlin.DE>
 <1UypQMCHLT57SnjSQIM66RTkLalsvavG8xXoQJv4rEQ@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: holger@zedat.fu-berlin.de, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Mon Apr 05 19:16:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NypuN-0007qv-AB
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 19:16:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755658Ab0DERQO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Apr 2010 13:16:14 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42982 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755630Ab0DERQM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 13:16:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 19CFFA8ED9;
	Mon,  5 Apr 2010 13:16:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=i7M8oBl82Eo2bCpGC8JBrDLenMA=; b=VEWNhY
	o6wkqc9leUBs5p9ekg6QKGi5HIRGuhEo44INM6sQeQjY3WZi66OEpagqv9FegGQt
	3yTXgllBgqz1e1PK9iPXZf1JVpjQrT9fqNiqEFOiY9SWvK0LEd3V3GLmJT6lNklP
	X/Ics9rUrn8+gKoUBG+y+hU2573Pp6iw4Jca8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BLYa7imLyTC/0Wg60oKXP9wQR09eD/4s
	5WuLDxQyDYziY3/TEiyYzNS5iwej71KCduCv4gf0MqLlz4rn+rxALaBILFTt2Orx
	fWk59Lng1plhua+kUYWjgA9g/lx2uvySauh7cAy/UHzw2/dbxQ528IxGrBWqAikD
	XYXoHAMoims=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D9615A8ED8;
	Mon,  5 Apr 2010 13:16:05 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1F634A8ED5; Mon,  5 Apr
 2010 13:16:00 -0400 (EDT)
In-Reply-To: <1UypQMCHLT57SnjSQIM66RTkLalsvavG8xXoQJv4rEQ@cipher.nrlssc.navy.mil> (Brandon
 Casey's message of "Mon\, 05 Apr 2010 11\:45\:32 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EB41EB94-40D6-11DF-9676-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143994>

Thanks for the report.

In the meantime I'll revert 2170422 (Link against libiconv on IRIX,
2010-03-29) and wait for an improved, probably a conditional, change.
