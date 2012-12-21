From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Python version auditing followup
Date: Fri, 21 Dec 2012 10:28:29 -0800
Message-ID: <7va9t71cqa.fsf@alter.siamese.dyndns.org>
References: <20121220143411.BEA0744105@snark.thyrsus.com>
 <7vobho60fs.fsf@alter.siamese.dyndns.org> <kb001v$vps$1@ger.gmane.org>
 <7vzk182yka.fsf@alter.siamese.dyndns.org>
 <000d01cddf4c$8cbf2ca0$a63d85e0$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "Joachim Schmitz" <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Fri Dec 21 19:28:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tm7L1-0002wM-7A
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 19:28:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751948Ab2LUS2e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2012 13:28:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47747 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751504Ab2LUS2c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2012 13:28:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E55AA5A3;
	Fri, 21 Dec 2012 13:28:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wzT2jfP8nLlVHm5UBPfoUClF1ac=; b=GOnMQD
	N3mw73DiK9u7BS9/S8DffveNqIA9wplOq3tRX8b2L616IjSkMpYF/eOJZ8lbATKc
	SW3pyDukjanBIYj8TwWQsc74G1pl3xd98gIVIW3R6ndM2A03ArVIbPZFi9G96XG5
	+KtSl52p3JTdx93voS2AwSOdQ9eUDC44W+rL8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=P7u2kztpM5RI9TCw4NtJMA7IVkbZaTqc
	Zv/PjbGoYeMezS97QxDeq9Om0im4sqZuUVFLrcYxEs63zWNZ9mXl9xvni9s6qCYD
	7ns8uW4uMQIz1OQXiWsyE7BcduLU1BPX+Tw2d4gRmhByJZyv97dt8OzBvxjMgU/B
	csXIDF1s2/M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F025AA5A2;
	Fri, 21 Dec 2012 13:28:31 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3D2F0A5A1; Fri, 21 Dec 2012
 13:28:31 -0500 (EST)
In-Reply-To: <000d01cddf4c$8cbf2ca0$a63d85e0$@schmitz-digital.de> (Joachim
 Schmitz's message of "Fri, 21 Dec 2012 08:26:52 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 38B00032-4B9C-11E2-B9CA-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211999>

"Joachim Schmitz" <jojo@schmitz-digital.de> writes:

>> > We have a working 2.4.2 for HP-NonStop and some major problems getting
>> > 2.7.3 to work.
>> 
>> I do not think a platform that stops at 2.4.2 instead of going to
>> higher 2.4.X series deserves to be called "long term maintained by
>> their vendors".  It sounds more like "attempted to supply 2.4.X and
>> abandoned the users once one port was done" to me.
>
> Well, not entirely wrong, but not all true at too.
> I guess I need to defend the vendor here: It is not really the
> Vendor (HP) that provided Python 2.4.2 or tries to provide 2.7.3,
> it is a volunteer and community effort. HP did sponsor the 2.4.2
> port though (by allowing an HP employee to do the port inn his
> regular working hours). It is not doing this any longer (since
> 2007). Since then it is a small group doing this on a purely
> voluntary basis in their spare time (one HP employee amongst them,
> me).  Same goes for the git port BTW.

For the purpose of "if we draw the line at 2.6, would it hurt many
people who have been happily using the existing release of Git that
was happy with 2.4", it is dubious HP-NonStop counts.  It is not
like the users on that platform have been happily using Python based
Porcelain at the fringe of Git, and drawing the line at 2.6 will not
give them any regression.

It does add more things that needs to be done to the volunteer
developers for that platform and the organization that may want to
support the platform (as they have to finish 2.6 port if we decide
to draw the line there), but that is a secondary consideration.
