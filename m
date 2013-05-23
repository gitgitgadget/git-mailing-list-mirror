From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6] Add new git-related helper to contrib
Date: Thu, 23 May 2013 10:05:26 -0700
Message-ID: <7v38tdhbjd.fsf@alter.siamese.dyndns.org>
References: <1368978823-18247-1-git-send-email-felipe.contreras@gmail.com>
	<7vr4gyizti.fsf@alter.siamese.dyndns.org>
	<CAMP44s0pXLmjVUwsVWiN2G5QReh80spXjvy_6GuUGRz1RmUbLQ@mail.gmail.com>
	<7vd2siiqsr.fsf@alter.siamese.dyndns.org>
	<CAMP44s2ETSxebGxXJV_BYEqTC5gJMVdQLbnTUomrie2rHhdmDg@mail.gmail.com>
	<7v8v36iq3e.fsf@alter.siamese.dyndns.org>
	<7v4nduipvb.fsf@alter.siamese.dyndns.org>
	<7vzjvmh98r.fsf@alter.siamese.dyndns.org>
	<CAMP44s20njF9u9tRKM6J92-oqeLHoLqd30R-A7opTG7bdrTJzA@mail.gmail.com>
	<CAMP44s1e-kjVnAHQx3GOAG6ge_GZBmOBaCnr8YeyU6t5CveuzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 23 19:05:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfYxM-0003G3-SU
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 19:05:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758008Ab3EWRFa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 13:05:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60797 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757737Ab3EWRF2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 13:05:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 347D621A27;
	Thu, 23 May 2013 17:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gKpPjMHaWhYq+vgoxEsgay0sNi8=; b=H/1B6j
	NSifrukHRlqghGEz3ND6EkHJhuPgk3mcD7dDErFE+zlI5curNMlKeWo1IoiqdpKr
	z6pU/vKJlKtG2neYszFupO8VxDIpM6APJUV6tL2HQHR2K79OQeE39vAVSeOReNUi
	hNkqbdYy/lIcPdHNPacmti4ySN7vDmvAYQ9Y0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TaG8nLtoawBRD8/Yyck4yIQvrG76o8G9
	TCydeL2PMY8bu+vG+OQgxYiLo70yMja3z+9ix2HITE/LKrdmAEq3boiAQHCK0GAR
	Dyg/j8vvl+pN/URg/6GBOqRqXkzd768wC1mE1tNybSJxe/aYIiE8jIFFq7yiIvhV
	PSCQz9ab/LI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 22C4A21A26;
	Thu, 23 May 2013 17:05:28 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 98A1E21A24;
	Thu, 23 May 2013 17:05:27 +0000 (UTC)
In-Reply-To: <CAMP44s1e-kjVnAHQx3GOAG6ge_GZBmOBaCnr8YeyU6t5CveuzA@mail.gmail.com>
	(Felipe Contreras's message of "Wed, 22 May 2013 22:50:39 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F76AEEFA-C3CA-11E2-819F-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225269>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Wed, May 22, 2013 at 10:23 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> This doesn't make any sense:
>
> Ah, never mind, it's COPYING the one being modified, not EXTRACTING.

Yes.

The different levels of -C happens to correspond to the software
engineering practice from best to sloppy:

 - When you refactor to have a block of lines in a file , the
   original of that block would have come from another file (or the
   same file) you touched to remove duplication, so a single -C
   looks for an origin only from modified files (best).

 - When you start a new file, you may have to start from some
   boilerplate material that already exists in another file that is
   not (and does not have to be) changed in the commit you add that
   new file, so double -C -C looks for an origin of lines from other
   files, even unmodified ones, when looking at the lines in a new
   file (unfortunate but acceptable).

 - When you copy and paste without making any effort to refactor,
   you modify a file by adding new lines that match identically from
   another existing file, the latter of which does not change in the
   commit you do that copy and paste.  To find this, you need to
   look for an origin for any file from all the other files, and
   triple -C -C -C lets you do so (sloppy).
