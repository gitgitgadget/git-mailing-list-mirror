From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-send-email.txt: Add EXAMPLES section. Write 1st
 level sections in uppercase
Date: Sat, 17 Apr 2010 11:46:24 -0700
Message-ID: <7viq7pzzlr.fsf@alter.siamese.dyndns.org>
References: <1271345823-19685-1-git-send-email-jari.aalto@cante.net>
 <4BC81975.9000907@drmicha.warpmail.net> <8739yvsjqv.fsf@jondo.cante.net>
 <4BC8605F.5070306@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sat Apr 17 20:46:40 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3D2N-00008K-Bo
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 20:46:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753446Ab0DQSqe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 14:46:34 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63625 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946Ab0DQSqd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 14:46:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DC71FABE24;
	Sat, 17 Apr 2010 14:46:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=M3yi0kzUG62IMvcO6G46sh4eSUY=; b=wp1SU4
	qN89yBiBXj3HuN6xBkW0W9Akb2gbuQcq5/O18YQujNBJLrK0aNtpAFUzN/nkuyB2
	vjndLDFg92A4j+FTru8NeJ+MpMkCrgZ2rEU0mXWf/hb134hcuD+Q1Ed6/1CZ7YLv
	L9Q3GBg/O4hw9UwYX2HSoGTz28UWZ7PVOesDA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ySb8MtF8lBuH4WBq9G0j0FYCUXTbhfYY
	d0eXdL9NuowDrloVcfePLmO5rcpb2OF5lmyxqcloPhkcpgcFysmCM5Twg7FiVEKx
	yDOkfXV870EIbDFJ6pIcXPgBqhXZJZNQrQL2l6NXfuUJdW7fS1j1cuOoHbZZHPqA
	/WWzv9DvQOg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AC4B0ABE22;
	Sat, 17 Apr 2010 14:46:29 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E20C8ABE1F; Sat, 17 Apr
 2010 14:46:25 -0400 (EDT)
In-Reply-To: <4BC8605F.5070306@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Fri\, 16 Apr 2010 15\:04\:31 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 89108096-4A51-11DF-A06F-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145170>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> I don't use any options besides --dry-run and --cc, which is the point
> of the config options ;) In config I have to, smtpserver (pointing to an
> msmtp-script), bcc, suppresscc, aliasesfile, aliastype, but that depends
> on the project, of course (git.git here).
>
> I just think that using all these options on the command line is very
> atypical.

Having to give too many options from the command line all the time is a
sure sign that the defaults for unconfigured case are bad (which may well
be true but is is hard to change without a good plan) and that it is not
clearly explained how to configure the defaults for the repository.

I do not think it is productive to give an overwhelming list that you
would rarely use (i.e. until you figure out a good set of defaults for the
project).

> "Without any options, send-email will send patches (using
> /usr/sbin/sendmail or /usr/lib/sendmail or localhost) using any from, cc
> and subject lines contained in the patch files; you have to specify at
> least --to, or else you will be prompted for it.
>
> All defaults pertaining to composing and sending of the patch mails and
> to automating this process can be changed with config options, see the
> corresponding sections below."

Yes, I think we should proceed in this direction.

> I liked your format-patch example with merge-base, I just liked it
> better in format-patch's man page ;)

Likewise.
