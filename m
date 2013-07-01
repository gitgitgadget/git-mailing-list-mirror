From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] contrib/hooks/post-receive-email: get description from repo.git/config
Date: Mon, 01 Jul 2013 14:58:47 -0700
Message-ID: <7v1u7iapzw.fsf@alter.siamese.dyndns.org>
References: <15tsj20cizd.fsf@tux.uio.no>
	<7vtxmgruhc.fsf@alter.siamese.dyndns.org>
	<vpq1u9kunba.fsf@grenoble-inp.fr>
	<7vwqrbmh4d.fsf@alter.siamese.dyndns.org>
	<5188B165.3050709@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Trond Hasle Amundsen <t.h.amundsen@usit.uio.no>,
	git@vger.kernel.org, Marc Branchaud <mbranchaud@xiplink.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Chris Hiestand <chiestand@salk.edu>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Jul 02 00:12:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtmLC-0005bA-UR
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 00:12:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755742Ab3GAWMz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jul 2013 18:12:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51764 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755720Ab3GAWMy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jul 2013 18:12:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E2C7E2D385;
	Mon,  1 Jul 2013 22:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=WkynyEglIjPNt5TcBIjH70fX5QM=; b=HvYBsyOapvf+6ScLmhTM
	KTsNrh3AQq3mfQDcF1HY3TdKu2m+/q3L78i+JE25w5dg83Arht/E1LhG4BZ+/wuz
	VGOjlAvvOon4chskYNlNQjcDIcVY9bwuQpG6FSrBtzvZW7tKfUEyXbfmVQiT2NHP
	9ohfRHxyWpzhiVguVcV5h1s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=ocCcx8RX8xxkoqclZKLkgVYrFDe6ri1kC5aMasgxYOvcqk
	UVMUR34Wg2Lvp7p/MpIjCTCt94mZjyYDHEkn5zk7SD/wSqCIAk0NdQEfuKreciYr
	moMYZ3nKqwLOlCAjCfNI2APrNz29eeI+P4v6lNLk1LeYWg8r/oVUszIa5V7bQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D8F972D384;
	Mon,  1 Jul 2013 22:12:53 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 45D692D381;
	Mon,  1 Jul 2013 22:12:53 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5FFFF322-E29B-11E2-9793-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229337>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> My understanding is that we are waiting on two things:
>
> 1. Consensus from the community.  I would characterize the feedback on
> the mailing list as limited in quantity but strongly positive [1-4] and
> I think that most/all of the wishes for post-receive-email features that
> were originally omitted from git-multimail have been implemented in the
> current version.  Some of the mailing list feedback was about earlier
> versions.  Do you want people to give feedback specifically about the
> current version?
>
> 2. For me to figure out what part of the git-multimail history I think
> should be included in the Git project, do any necessary repository
> rewriting, and submit a pull request to you.  The fact that I haven't
> gotten to this is due to the fact that I've been busy getting git-imerge
> [5] ready to present at GitMerge.

Ping, now GitMerge is over?

No need to hurry, but just to make sure this didn't disappear from
everybody's radar.

Thanks.
