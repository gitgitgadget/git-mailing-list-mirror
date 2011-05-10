From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 (for maint)] git-completion: fix regression in zsh
 support
Date: Tue, 10 May 2011 11:27:50 -0700
Message-ID: <7vd3jqjtqx.fsf@alter.siamese.dyndns.org>
References: <1305030039-16044-1-git-send-email-felipe.contreras@gmail.com>
 <7vr586jwzm.fsf@alter.siamese.dyndns.org>
 <BANLkTinRB-hUwOdZsWRFZWxUAebkFeaGVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 10 20:28:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJrfF-000156-Kr
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 20:28:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750884Ab1EJS2E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2011 14:28:04 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51298 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814Ab1EJS2C (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2011 14:28:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2DD984FCB;
	Tue, 10 May 2011 14:30:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cfNtdnx14kOihmOYbKK2Pggdrq0=; b=A1twKM
	MYV5Mff8H/DJ3u7QUwkhDeN1uIJVKRWPkc/czor9ZouC85tj6u70sQhK/SyfZwpW
	HzP2zb+9OG632vNQItX59mFpX1cR9yx6Y8lSUZi6Q8CRAXqwVr86ksaFRURY04wH
	c4vkrY0VjhLcQwLcu+1XOSs2Bb0kZut8LeIbQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GKfkii3y3xR7X8KzJX1xhB43olSWOVXm
	0dtCt3EZGuzrjHnVkr91y4W47I6X5Eaa8gqpSvNJo271VxIT2T0gmTY0/IdBCKgP
	APRzbCWgRHXokqnbR7s/OrtSmylMlQDCqUvsaqWZKHnX2K5TrFjQTfL1MnuBOXJ7
	1kmQK5YPyKg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DBAC24FC8;
	Tue, 10 May 2011 14:30:03 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6E2D14FC6; Tue, 10 May 2011
 14:29:58 -0400 (EDT)
In-Reply-To: <BANLkTinRB-hUwOdZsWRFZWxUAebkFeaGVQ@mail.gmail.com> (Felipe
 Contreras's message of "Tue, 10 May 2011 20:36:33 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 85B91638-7B33-11E0-8B80-B44DF9BAD297-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173345>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Well, "right now" all versions of zsh are before 4.3.12.

I was trying to help people who read the log in 12 months.  They can
certainly see the date of the commit, but then they have to correlate that
date with the then-current version of zsh if you do not mention it.

> I also don't
> see the point mentioning of 1.7.5. Maybe "The git-completion script in
> contrib/ is quite broken".

That is Ok by me, if you mean this zsh breakages is not something our
recent change has exposed.  Mentioning 1.7.5 only helps the users if
git-completion.bash in 1.7.4 did not have an issue even on the current zsh
and 1.7.5 had an issue. I thought you may know which without me having to
dig that information out.
