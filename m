From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] MSVC: link dynamically to the CRT
Date: Wed, 30 Apr 2014 12:54:15 -0700
Message-ID: <xmqqha5aegpk.fsf@gitster.dls.corp.google.com>
References: <20140429102509.GA16706@camelia.ucw.cz>
	<xmqqa9b2fyve.fsf@gitster.dls.corp.google.com>
	<536150E8.20809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stepan Kasal <kasal@ucw.cz>,
	GIT Mailing-list <git@vger.kernel.org>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marat Radchenko <marat@slonopotamus.org>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 21:54:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfaaI-0002Ao-1I
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 21:54:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759443AbaD3TyV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 15:54:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57131 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759118AbaD3TyT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 15:54:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4AA8F7FC28;
	Wed, 30 Apr 2014 15:54:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HCzbYni7c+xBbZOuu0NTJouQJ18=; b=uA4uwS
	Aa3n/s34VdQnut5Wszf/RHcJrzILPZHGLqq6dGrGOfJGZ8bo+oXO/3Cn5wfS/g3P
	5FbwC1MHMIlQ7H5WLSMSScgXW6CZK6bE+IPnl/jINLFelY+MtVJWCwuxmUKStdC8
	cnClt8q/KoFQs8jPSpEajV4qj4dmN6Y/wsOqc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vRK9YbajdWGljXf3S444J5h26b7+YhAM
	ljrAgXcWdQdKonD0f9/C/q7kZhIYjwFokeLUHU6QdSn7+uko5VZWdCrIaMFJ12iq
	81uX5gOJfGHq4I6EWMDpxchPXuHeEEnzcpSkDvQkGDdQqW1hSRPygMI7wVNnWadR
	vQN0zVv8E/I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E8447FC27;
	Wed, 30 Apr 2014 15:54:19 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 05CE07FC24;
	Wed, 30 Apr 2014 15:54:16 -0400 (EDT)
In-Reply-To: <536150E8.20809@gmail.com> (Sebastian Schuberth's message of
	"Wed, 30 Apr 2014 21:37:12 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 36543822-D0A1-11E3-B10C-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247768>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> On 30.04.2014 20:36, Junio C Hamano wrote:
>
>> I am not intimate with the msysgit developer community, and I do not
>> know if it is appropriate for me to respond with a
>>
>> 	Does this look OK with msysgit folks?
>
> This patch has been carried in the msysgit tree since more than 3
> years, although strictly speaking it does not affect the msysgit build
> but only the MSVC build. Stefan is just bringing Karsten's patch
> upstream with this patch.
>
> So yes, this is fine.
>
>> cc'ed to the usual suspects (Erik Faye-Lund, Dscho and J6t).  Just
>> like I do not have to ask "does this look ok?" question when seeing
>> a patch from Erik or J6t, is it unnecessary for me to do so for a
>> patch from you?
>
> I'm putting Marat in CC who has been recently active in building Git
> with MSVC.

Thanks, very much appreciated.
