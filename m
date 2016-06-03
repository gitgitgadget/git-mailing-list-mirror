From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Triangular Workflow UI improvement: Documentation
Date: Fri, 03 Jun 2016 08:46:05 -0700
Message-ID: <xmqqd1nyqnr6.fsf@gitster.mtv.corp.google.com>
References: <9A874F00-ABD8-43D5-A32E-6A39ED333E6D@grenoble-inp.org>
	<1464697717-5751-1-git-send-email-jordan.de-gea@grenoble-inp.org>
	<9FB65CA220F84B6B882B75435DDA3D65@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Jordan DE GEA" <jordan.de-gea@grenoble-inp.org>,
	<git@vger.kernel.org>, <erwan.mathoniere@grenoble-inp.org>,
	<samuel.groot@grenoble-inp.org>, <tom.russello@grenoble-inp.org>,
	<Matthieu.Moy@grenoble-inp.fr>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Fri Jun 03 17:46:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8rIh-0002GV-4G
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 17:46:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932490AbcFCPqP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 11:46:15 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65245 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932470AbcFCPqO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 11:46:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3A8D21F61B;
	Fri,  3 Jun 2016 11:46:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=fsdIMD2wBl9Flv46xZVvHSS8MxE=; b=iGyMDfdj8JltXx6yz++e
	ozlQ6oivwW8pI5kGrvhla3g6TCYKmzVMzrjRhb9PCJJ8Pv4u+/6TY9+1wdpQ1vrJ
	Njm0w7U+5R4IrxBO3M1KnjhzEYti74m2xIcQPS3Dztxm0IoVziT4UCKymoZo3CXO
	N7cWgp8XIE0kbJT9AsQwyTI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=bg1qCnPktRSePgsv6cS+DMgG9dFQBYveIKjIZqf0RnKZHi
	htE/mMvf7CHeBSfqF3JxrziZ1q12nyPJU1/MvjUhvpB/xeeobJkcImJYkAbA6S+l
	+rmtO6O3kjLlrDT0gyAJd8QYFPcFwnG0rawhIL28SHlVaxxrl8RpipvQiOdiE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2F9051F61A;
	Fri,  3 Jun 2016 11:46:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AC73E1F619;
	Fri,  3 Jun 2016 11:46:07 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 499D06E6-29A2-11E6-A79B-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296340>

"Philip Oakley" <philipoakley@iee.org> writes:

> That said, trying to find a good name for that 'third place' is not easy. 
> It's neither upstream, nor downstream (for Junio - the maintainer special 
> case - git.git would be his downstream). The me/git repo is like a 
> ferryman's landing across the other side of the river flow, a safe harbour 
> if you will.

You raise a good point here.

To me, the git.git public repository that everybody pulls from is
just like me/git for everybody else.  It is a place where you
publish your work.  I think the @{push} notation during its design
phase was once called @{publish} instead.

A "downstream" that is the opposite of "upstream" is not something
you would configure and control.  They are those who call you
"upstream".  You know and actively configure who your "upstream" is
and pull from there.  You do not have direct control who are the
people who are pulling from you.

So in that sense, "downstream" exists as a concept that is just as
valid as "upstream", but unlike "upstream", "downstream" does not
manifest itself as something you explicitly tell Git about, either
from the command line, in the remotes definition, or in the
configuration files.
