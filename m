From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 1/2] perf: compare diff algorithms
Date: Tue, 6 Mar 2012 22:00:48 +0100
Message-ID: <87y5rdzbpb.fsf@thomas.inf.ethz.ch>
References: <87pqcp6fyh.fsf@thomas.inf.ethz.ch>
	<f113867bcf2fec3210cd1a997e1398903b3bdd76.1331039505.git.trast@student.ethz.ch>
	<7vhay1se0g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Thomas Rast <trast@student.ethz.ch>, <git@vger.kernel.org>,
	Michal Privoznik <mprivozn@redhat.com>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 06 22:01:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S51VF-0004K7-2I
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 22:01:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031109Ab2CFVAz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 16:00:55 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:33578 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031061Ab2CFVAy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 16:00:54 -0500
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 6 Mar
 2012 22:00:52 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.211.131) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 6 Mar
 2012 22:00:52 +0100
In-Reply-To: <7vhay1se0g.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 6 Mar 2012 11:52:47 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.211.131]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192392>

Junio C Hamano <gitster@pobox.com> writes:

>
> I am getting this (probably unrelated to this patch), by the way:
>
> $ make perf
> make -C t/perf/ all
> make[1]: Entering directory `/srv/project/git/git.git/t/perf'
> rm -rf test-results
> ./run
> ...
> perf 4 - grep --cached, expensive regex: 1 2 3 ok
> # passed all 4 test(s)
> 1..4
> Can't locate Git.pm in @INC (@INC contains: /etc/perl ...) at ./aggregate.perl line 5.
> BEGIN failed--compilation aborted at ./aggregate.perl line 5.

It would seem that you are not installing Git.pm as part of your normal
installation?  aggregate.perl uses it, so you'd have to.  Perhaps a Perl
guru can tell us if it's possible to magically pull Git.pm from the
build tree instead of the installed version...

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
