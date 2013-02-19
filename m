From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Google Summer of Code 2013 (GSoC13)
Date: Tue, 19 Feb 2013 08:32:48 -0800
Message-ID: <7vppzw6z7z.fsf@alter.siamese.dyndns.org>
References: <87ehgd1qq2.fsf@pctrast.inf.ethz.ch>
 <20130218174239.GB22832@sigill.intra.peff.net>
 <CALkWK0nDEwgDwnVktmM8abv3ZgQmJCOm8LBe25UKR485PZMPfA@mail.gmail.com>
 <7vip5p9rtm.fsf@alter.siamese.dyndns.org>
 <CALkWK0=s4XX0mmUTAcNBHyqdrryhMYvhtrNZCFFccJJBUUVdUg@mail.gmail.com>
 <7v7gm492ty.fsf@alter.siamese.dyndns.org>
 <CALkWK0=zpZ25X_jVBoF77E75kmV38VC+nwtQ6MYA9=UO99HqyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, Jeff King <peff@peff.net>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Paul Mackerras <paulus@samba.org>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Thomas Gummerer <t.gummerer@gmail.com>,
	David Barr <b@rr-dav.id.au>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 17:33:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7q84-0000Jm-P5
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 17:33:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758589Ab3BSQcw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 11:32:52 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48038 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758549Ab3BSQcv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 11:32:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A2EBB85F;
	Tue, 19 Feb 2013 11:32:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8y36psbyHT8A+ZwxlF87K/lKcig=; b=byDOP7
	oMY3ajfoulHr9jn305zunkK2nvcF8IhLwrsUuw4eBfNuqG+YqeeRHjwl7M++ne69
	yRD6JxG2B4JDyGsKYHeAw2ucaWAo0bffPzc4faKdvPK+hoKNCyPsTfgqgM8Bvcdg
	e7QqFI+rkP0ddK3/zsqukgs+D1l2noBk0JHRw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d7w5vCQDahlgycCwBqX0o5Bud//kdxWY
	zTph/9urCi7iLSLg8NuQYhY+YXFJLA99KiCJMUyGMakYCApWjFYUIYwVTUbfBSCt
	JBL+cM31Pvgja6hGojYuEQAMh7ulGefsspUAHOMfw9Kl4D1qksRlnBA1nEmT+8u7
	VY13p3fHZsQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EFD7BB85E;
	Tue, 19 Feb 2013 11:32:50 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 53B2CB85A; Tue, 19 Feb 2013
 11:32:50 -0500 (EST)
In-Reply-To: <CALkWK0=zpZ25X_jVBoF77E75kmV38VC+nwtQ6MYA9=UO99HqyQ@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Tue, 19 Feb 2013 13:52:17 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 00634C26-7AB2-11E2-988E-21622E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216631>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

>> I was conflating between people who add "suggested project" and who
>> act as mentors.  I do not think mentors are primarily responsible
>> for bad suggested projects.
>
> Why do mentors pick badly sketched-out projects to mentor?  They're
> free to pick anything they want/ propose what they want.

I've had an impression that these Wiki entries were written by
people with names of mentors (who are different from the proposers)
already assigned to them, and if an unfortunate student picked an
unrealistic one, these mentor candidates were too nice to push back
and decline, saying "it is unrealistic", leaving the student and
proposal without any mentor.
