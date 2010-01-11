From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to check new commit availability without full fetch?
Date: Mon, 11 Jan 2010 00:09:46 -0800
Message-ID: <7vljg5ukol.fsf@alter.siamese.dyndns.org>
References: <ee2a733e1001100312j786108fct1b4c8abd0acc5afc@mail.gmail.com>
 <201001110831.28278.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: SLONIK.AZ@gmail.com, Git Mailing List <git@vger.kernel.org>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Jan 11 09:10:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUFLg-0001Ty-5I
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 09:10:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752488Ab0AKIJ6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Jan 2010 03:09:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752262Ab0AKIJ6
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 03:09:58 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38150 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355Ab0AKIJ5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jan 2010 03:09:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 796268FD80;
	Mon, 11 Jan 2010 03:09:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=4VlfPR9nM7nh
	uiOVmG8w5bhZfUo=; b=F3QyfR/9N++pjUxEs71nQ/DiZICKFaQofGnjEfBk168x
	I6la4r6fGyDuLbAXoDXHriZwaogZ5eQBrOM35zKEb5aB/3/+p8kg56lWUuj/nQP2
	Z/AyfUddelr33KIsWeGoHO/H2dRcKI7ev7KseDN+R3ESDR7XKu/ps9ocRefB0xI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=cxyvOb
	l39LVTkA+dsAgzmsbfG2jI16hTUEvyR8atLa8jBBRHZ2+cAy9fKoM+KjOmTriuEc
	Qd6/j8QVt4NDd+HRGD8ZC61JSHAUKuKiC1oPoVjq+23vth+2PlUdmQ+5qlV+R4EA
	MCizRRTBwUEW3XsAHTpceS4a+fFMFC08mxjWY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 387B78FD7E;
	Mon, 11 Jan 2010 03:09:52 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3903E8FD77; Mon, 11 Jan
 2010 03:09:48 -0500 (EST)
In-Reply-To: <201001110831.28278.robin.rosenberg@dewire.com> (Robin
 Rosenberg's message of "Mon\, 11 Jan 2010 08\:31\:28 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B1E4B9AC-FE88-11DE-8E58-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136616>

Robin Rosenberg <robin.rosenberg@dewire.com> writes:

> s=C3=B6ndagen den 10 januari 2010 12.12.09 skrev  Leo Razoumov:
>> Hi List,
>> I am trying to find a way to check availability of new commits
>> *before* doing fetch or pull. Unfortunately, neither fetch nor pull
>> take "--dry-run" option (unlike push)
>
> Fetch has --dry-run. It's a fairly new option. The drawback is that i=
t
> still does the fetch, but it does not update the refs. If you re.run =
it
> again it'll be quicker.

Doesn't that worry us if it really is quicker?

If --dry-run doesn't update the refs, why do the objects that were
transferred by them not get asked the next time?  There must be a bug
somewhere, but it is getting late already, so I'll leave it to experts =
in
the transfer area to figure it out...
