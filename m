From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: do not set setgid bit on directories on
 GNU/kFreeBSD
Date: Mon, 03 Oct 2011 12:16:18 -0700
Message-ID: <7vlit1ga2l.fsf@alter.siamese.dyndns.org>
References: <20111003064120.GA24396@elie> <20111003071949.GC17289@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Petr Salinger <Petr.Salinger@seznam.cz>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 03 21:16:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAo01-0003aa-Fv
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 21:16:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757365Ab1JCTQX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Oct 2011 15:16:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35713 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757361Ab1JCTQV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 15:16:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A2E9E53DE;
	Mon,  3 Oct 2011 15:16:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/PAPAnhghbVcqSuunkzL63bH6Kg=; b=gBnZNz
	INbHxrD+QvrCdVhTIXkXh5WabNOJk4N7GOW6Rdfu2Yix3L7lbjOBUcpk1X2MclYv
	5uDHsXs7gopjIZ4ntW62WDclnEOFDbm1u0+SPCXfSkf5rONdvNBPElTcXInpdepl
	+SEOmbuJn7KwF+HrctxBJuPN1/zY0JQyB5ngE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s4vCPNA8FxbxTUUOYnr+ttU2E+UaCEwC
	6tHqHc9CTScBetp1Rgeh3x71MZ772nYsQLYZTDkwxpoMmH1PlcPQNyO3PZLyVUeb
	jZRx+WL+ZyMOCJyXUYUbqxJsYK9HXY60nMuljh/eX+wku/iUN7McKx0rCfW6SBff
	r7AeBWYT2nc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A93C53DD;
	Mon,  3 Oct 2011 15:16:20 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3220453DC; Mon,  3 Oct 2011
 15:16:20 -0400 (EDT)
In-Reply-To: <20111003071949.GC17289@elie> (Jonathan Nieder's message of
 "Mon, 3 Oct 2011 02:19:49 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2CE57AC2-EDF4-11E0-A4D5-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182699>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Jonathan Nieder wrote:
>
>> Since the setgid bit would only mean "do what you were going to do
>> already", it's better to avoid setting it.  Accordingly, ever since
>> v1.5.5-rc0~59^2 (Do not use GUID on dir in git init --share=all on
>> FreeBSD, 2008-03-05), git on true FreeBSD has done exactly that.  Set
>> DIR_HAS_BSD_GROUP_SEMANTICS in the makefile for GNU/kFreeBSD, too, so
>> machines that use glibc with the kernel of FreeBSD get the same fix.
> [...]
>> Sorry to have taken so long to send this one out.  Anyway, it seems
>> to me like the right thing to do.  Petr, what do you think?
>
> fwiw:
>
> Acked-by: Petr Salinger <Petr.Salinger@seznam.cz>
>
> Thanks for looking it over.

Sorry, this is very confusing. Are JN and PS one and the same person?
