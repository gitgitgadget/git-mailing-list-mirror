From: Junio C Hamano <gitster@pobox.com>
Subject: Re: plain text only policy prohibits the use of android based mobile
 devices
Date: Thu, 19 May 2011 10:32:43 -0700
Message-ID: <7vtycq7g04.fsf@alter.siamese.dyndns.org>
References: <BANLkTik5g+oahTuTZ5BSOunQMfzGNRZ-7Q@mail.gmail.com>
 <7v39kbbn7h.fsf@alter.siamese.dyndns.org> <8ya4o4qlhxa.fsf@huya.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eugene Sajine <euguess@gmail.com>, git@vger.kernel.org
To: David Brown <davidb@codeaurora.org>
X-From: git-owner@vger.kernel.org Thu May 19 19:33:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QN75n-0006Bs-7I
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 19:32:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933732Ab1ESRcx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 13:32:53 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58062 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933494Ab1ESRcw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2011 13:32:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 902AE5641;
	Thu, 19 May 2011 13:34:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PoqbMEKegBrxM5Z2w6h33KcQUco=; b=kH5s1F
	Wn8seiXZGLzEnR+HYD/Q2Lf8HEHu56Mjzg4aXroaj4HslhX8KddPWq8l8BSEL7Cj
	4953YLQtVIeiDICwGfs+yVk1AfKrLhb3D4egHEv66eqMlJ90Pf8bYOsusf1aqsi4
	BDOt5AyJ21IDfdlnJ0zHSIKnncLg83X/oiwEw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=v+03vejai7nSiMgjayjFo9PitJ1us8jj
	JAanv/9vowoV7gPJ6aD6eQuDYiTMWjdIr5YdfA1SeUFZ9wEuaib5TJD1F3oiwFR4
	3YnfUEMGeJlyvLVrb2kVDTNGmPbIdixK9+Ph/t62usO0k1yKzwT2sL2XknQcHHrq
	bs76aDb7JMM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5D9B1563F;
	Thu, 19 May 2011 13:34:55 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 55E67563E; Thu, 19 May 2011
 13:34:51 -0400 (EDT)
In-Reply-To: <8ya4o4qlhxa.fsf@huya.qualcomm.com> (David Brown's message of
 "Thu, 19 May 2011 10:27:29 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4F69BA26-823E-11E0-9111-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173977>

David Brown <davidb@codeaurora.org> writes:

> On Wed, May 18 2011, Junio C Hamano wrote:
>
>> But I tend to consider that not allowing pure text messages is a gmail
>> bug/misfeature and needs to be fixed not by allowing html cruft on the
>> list, but by enabling poor gmail users to send pure text when they
>> want to.
>
> Doesn't clicking on "Plain text" work?  There are several people on lkml
> (includng Linus, I believe) who use gmail.

The WebMail interface let's you do that, but that is not what is discussed
here (see the original message from Eugene).

On phones and Honeycomb tablet, no. The app gives "Reply Inline" and
"Include Original" control, and when both are active, the user is fooled
into thinking it would be sent in the text/plain, but it always seems to
send mixed.
