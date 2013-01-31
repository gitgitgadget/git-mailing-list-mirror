From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/7] Undocument deprecated alias 'push.default=tracking'
Date: Thu, 31 Jan 2013 12:42:12 -0800
Message-ID: <7vwqutf5jv.fsf@alter.siamese.dyndns.org>
References: <1334933944-13446-1-git-send-email-Matthieu.Moy@imag.fr>
 <1335170284-30768-1-git-send-email-Matthieu.Moy@imag.fr>
 <1335170284-30768-3-git-send-email-Matthieu.Moy@imag.fr>
 <CACBZZX552fnD+u9Zp-BhqDyYWN+OiyvCyub-xjMZ-_GXCG-vQA@mail.gmail.com>
 <7vvcadgss0.fsf@alter.siamese.dyndns.org> <20130131190747.GE27340@google.com>
 <7vip6dgmx2.fsf@alter.siamese.dyndns.org> <20130131195712.GH27340@google.com>
 <7va9rpgm06.fsf@alter.siamese.dyndns.org> <20130131201144.GJ27340@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 31 21:42:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U10xx-0008RY-M0
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 21:42:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753568Ab3AaUmQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 15:42:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39815 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753114Ab3AaUmO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 15:42:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B909C1D3;
	Thu, 31 Jan 2013 15:42:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YVTfAlq4cLGIr55U/bWipv6m5wQ=; b=c9YcZJ
	gW3kpU8y+nrpKCzZjKwQ5yZp5KBeP6uPA8SiTerCcBFx48Oe858T9CadKOoV8AJe
	Dkj22grQpqcog+LOr+xVEAy7j16xE/wqrcHvrS1FeTzAJxcGhNT++ZXbt7DhbHit
	4pTuNCanXay3VwY4HsWOpBR/JHefXg/qqT63w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F8m2qzXzSPAbqIa/bdoURhzCXUCOn7l2
	Wg8MQT8OLeBMLJ80Dj+owaQDVQ3C/aWBPmwnByaYKAnRamoE9QGf2Nb5WCrCJqNp
	sMlJsSilbPqSI4pONYLNBLdrjF8EvYuitibGNoMo1Zg7tjbAGKLhGsXF+IQWty26
	J2ZRhf2B8Cw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E87BC1D2;
	Thu, 31 Jan 2013 15:42:14 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E21CDC1D0; Thu, 31 Jan 2013
 15:42:13 -0500 (EST)
In-Reply-To: <20130131201144.GJ27340@google.com> (Jonathan Nieder's message
 of "Thu, 31 Jan 2013 12:11:44 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B1859D54-6BE6-11E2-94E0-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215168>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Am I really the only one that doesn't see the "--print" change as
> hiding an option and sees burying "tracking" in the text as
> qualitatively different?

Sorry, but I do not understand the question.

We are hiding/burying the "--print" option to make it clear that it
is not a member with the same footing as others belonging to the
group of options to the command.  It is accepted, but there is no
reason for the user to choose it over --normalize.

We want to make sure that "tracking" does not appear as if it is a
member of the pull.default set with equal rights as others.  It is
accepted, but there is no reason for the user to choose it over
"upstream".
