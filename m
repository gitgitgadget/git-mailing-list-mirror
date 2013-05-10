From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Pending changes before 1.8.3-rc2?
Date: Fri, 10 May 2013 14:13:51 -0700
Message-ID: <7vfvxuzgfk.fsf@alter.siamese.dyndns.org>
References: <7vwqr6znn4.fsf@alter.siamese.dyndns.org>
	<CAMP44s0Y7QGrfavBsFL17LEQga3eGRyMHbNMbLZFpC4WeEZTBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>,
	Eric Wong <normalperson@yhbt.net>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Jiang Xin <worldhello.net@gmail.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 10 23:14:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uaudo-0005eJ-Mo
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 23:14:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754483Ab3EJVNz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 17:13:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52984 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754207Ab3EJVNy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 17:13:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB8981E22F;
	Fri, 10 May 2013 21:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GA2rQ0v1WM7wNE2GgUCtulLhr74=; b=HTifSz
	ZhpVcoKHBcjlYEdkYf/uDUP5GeAYOkm4/Kiznvbwc8El4cFOFjA+Kv8gNfLHP684
	2CFzA7TTTwRaVte/js8vkGwpQf4HDto99S3ZWDGRca0TaVFqiurXog54WTdlge3c
	wWAUmGq3YAd2h4Atup8NBTKcS/cIvmGR4rX9Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TIw8u9W6bjpeARAD8VT35c9GHPzmInJd
	JeYPpfvRzwfBsw2+5KQCqNpjB7OHO8mwRB7dV9//BFnuHaDBQaxOOVqut2vVHLhV
	5uIH7O81ILUrtQUxLUb8zGIgd/5rplm0VRymwxiWuLl6wqj/Z+RfgL9oSa/ywBgU
	UuZUxB0205I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DF02F1E22E;
	Fri, 10 May 2013 21:13:53 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6417D1E22D;
	Fri, 10 May 2013 21:13:53 +0000 (UTC)
In-Reply-To: <CAMP44s0Y7QGrfavBsFL17LEQga3eGRyMHbNMbLZFpC4WeEZTBQ@mail.gmail.com>
	(Felipe Contreras's message of "Fri, 10 May 2013 16:02:55 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8497047C-B9B6-11E2-8B06-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223916>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Fri, May 10, 2013 at 1:38 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> I should learn to start bugging you folks a lot earlier in the
>> release cycle (except for Jiang, as localization strings will not be
>> finalizable until very late), but anyway, we will soon be tagging
>> the hopefully final -rc for the upcoming release.  Please throw me a
>> "pull this now!" if you have stuff that needs to be in 1.8.3.
>
> I guess this doesn't include me, but:
> http://article.gmane.org/gmane.comp.version-control.git/223908

If you mean by "this" my "To:" list, no, it did not include you, but
that was only because I forgot to.  Sorry about that.

remote-hg and its test in contrib/remote-helpers/ are yours, and as
long the changes do not affect other parts of the system (judging
from the diffstat, the 6-patch series wouldn't), I do not mind too
much about late changes in the cycle.
