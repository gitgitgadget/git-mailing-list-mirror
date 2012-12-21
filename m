From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Python version auditing followup
Date: Fri, 21 Dec 2012 10:48:28 -0800
Message-ID: <7vy5grz1fn.fsf@alter.siamese.dyndns.org>
References: <20121220143411.BEA0744105@snark.thyrsus.com>
 <7vobho60fs.fsf@alter.siamese.dyndns.org> <kb001v$vps$1@ger.gmane.org>
 <7vzk182yka.fsf@alter.siamese.dyndns.org>
 <000d01cddf4c$8cbf2ca0$a63d85e0$@schmitz-digital.de>
 <7va9t71cqa.fsf@alter.siamese.dyndns.org>
 <006101cddfab$2afb0cf0$80f126d0$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "Joachim Schmitz" <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Fri Dec 21 19:48:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tm7eS-0003lj-NJ
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 19:48:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751827Ab2LUSsi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2012 13:48:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60940 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751293Ab2LUSsg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2012 13:48:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 900F9AC86;
	Fri, 21 Dec 2012 13:48:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dPrxOdIdVheWimRV3xbcre3Z/tc=; b=VEizF+
	IxA/os/KcaDF1LQWl0SM8J2T/uHv5lf2nRUs4uO+ojS6IgiafpjrVLNofEjKwHw8
	07OyXf0zSZbveC+JJSziKlkHwqhlNFmQzCkYWhHs0/V12PnD6X0/jpGxKl3Hm+Le
	ngB7Z4eazXPq7hAwQ4Zz7RBPKAm7EB6xBKTJA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iT29GREWK8oP8dsoTmJnfA7v9uHxlPnO
	wnHYMdQetatOBeabldEfhFCBWqXZYU5ECSSoRwizAuGvGlxFJ9PSjAy6f96zFfPP
	6CMBm9Dl/PFPhGLCShpqu0Mr3e9hA17x101M7TJEDSLX2zNYsv5awpi34uSeZzSk
	kBmqN1II++s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7DA62AC85;
	Fri, 21 Dec 2012 13:48:31 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 84D39AC83; Fri, 21 Dec 2012
 13:48:30 -0500 (EST)
In-Reply-To: <006101cddfab$2afb0cf0$80f126d0$@schmitz-digital.de> (Joachim
 Schmitz's message of "Fri, 21 Dec 2012 19:44:10 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0385A634-4B9F-11E2-AF0E-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212002>

"Joachim Schmitz" <jojo@schmitz-digital.de> writes:

>> From: Junio C Hamano [mailto:gitster@pobox.com]
>> Sent: Friday, December 21, 2012 7:28 PM
>> To: Joachim Schmitz
>> Cc: git@vger.kernel.org
>> Subject: Re: Python version auditing followup
>> 
>> "Joachim Schmitz" <jojo@schmitz-digital.de> writes:
>> 
>> >> > We have a working 2.4.2 for HP-NonStop and some major problems getting
>> >> > 2.7.3 to work.
>> >>
>> >> I do not think a platform that stops at 2.4.2 instead of going to
>> >> higher 2.4.X series deserves to be called "long term maintained by
>> >> their vendors".  It sounds more like "attempted to supply 2.4.X and
>> >> abandoned the users once one port was done" to me.
>> >
>> > Well, not entirely wrong, but not all true at too.
>> > I guess I need to defend the vendor here: It is not really the
>> > Vendor (HP) that provided Python 2.4.2 or tries to provide 2.7.3,
>> > it is a volunteer and community effort. HP did sponsor the 2.4.2
>> > port though (by allowing an HP employee to do the port inn his
>> > regular working hours). It is not doing this any longer (since
>> > 2007). Since then it is a small group doing this on a purely
>> > voluntary basis in their spare time (one HP employee amongst them,
>> > me).  Same goes for the git port BTW.
>> 
>> For the purpose of "if we draw the line at 2.6, would it hurt many
>> people who have been happily using the existing release of Git that
>> was happy with 2.4", it is dubious HP-NonStop counts.  It is not
>> like the users on that platform have been happily using Python based
>> Porcelain at the fringe of Git, and drawing the line at 2.6 will not
>> give them any regression.
>
> You asked for opions and obhections, you got mine ;-)

Yeah, duly noted, and appreciated.
