From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RESEND] Fix a bunch of pointer declarations (codestyle)
Date: Wed, 25 Feb 2009 02:14:54 -0800
Message-ID: <7vprh64ych.fsf@gitster.siamese.dyndns.org>
References: <1235512745-26814-1-git-send-email-felipe.contreras@gmail.com>
 <7veixnaqrn.fsf@gitster.siamese.dyndns.org>
 <94a0d4530902250202rb12a4e7leb9856258dafc488@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 25 11:16:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcGog-0001Ly-EM
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 11:16:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760127AbZBYKPE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 05:15:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760052AbZBYKPE
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 05:15:04 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36371 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759985AbZBYKPB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 05:15:01 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4DDE29D7CF;
	Wed, 25 Feb 2009 05:14:59 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2ECE99D7CE; Wed,
 25 Feb 2009 05:14:55 -0500 (EST)
In-Reply-To: <94a0d4530902250202rb12a4e7leb9856258dafc488@mail.gmail.com>
 (Felipe Contreras's message of "Wed, 25 Feb 2009 12:02:25 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2853B29C-0325-11DE-9B96-B26E209B64D9-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111436>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Wed, Feb 25, 2009 at 10:02 AM, Junio C Hamano <gitster@pobox.com> wrote:
> ...
>> Sorry, but I cannot take this as is.
>>
>> These trivial clean-ups are welcome either as part of a preparatory
>> clean-up before starting to work in the area of code you are touching, or
>> as a standalone patch to files that nobody is currently working on.
>>
>> There is a huge overlap between "git diff --name-only master..pu" and the
>> above list, so it is impossible for me to take the patch and I cannot
>> afford the time to sift through gems out of stones.
>
>  It's understandable. Would there be a better time to send this patch?
> After 1.6.2, or in a different form?

I've taken your smaller patches that touched only parts that nobody is
touching between 'master' and 'pu'.  Please take that as a hint ;-)

As a first order approximation, come up with the subset of your patch that
applies cleanly to 'master', and make sure that the same patch applies
cleanly to 'pu'.  Remove patches to paths that have any hunk that does not
apply and go back to 'master' to repeat the exercise.

That will cover a lot of existing breakages in files that nobody else is
working on.

For example, Jay has been hyperactive around anything "remote" for the
past several days.  If you have clean-ups in the paths he touches in his
series (still in flight), you may want to coordinate with him so that he
can include your patches in the early part of his series.  Or you wait
until his series starts to settle down (meaning, merged to 'next').  This
applies to anybody else's topic.
