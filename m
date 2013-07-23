From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/2] post-receive-email: deprecate script in favor of git-multimail
Date: Mon, 22 Jul 2013 21:20:12 -0700
Message-ID: <7vtxjl9abn.fsf@alter.siamese.dyndns.org>
References: <1373789343-3189-1-git-send-email-mhagger@alum.mit.edu>
	<1373789343-3189-3-git-send-email-mhagger@alum.mit.edu>
	<20130715060245.GD2962@elie.Belkin> <vpqoba4gr9h.fsf@anie.imag.fr>
	<7vip0cdju9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Chris Hiestand <chrishiestand@gmail.com>,
	Marc Branchaud <mbranchaud@xiplink.com>,
	Michiel Holtkamp <git@elfstone.nl>,
	Stefan =?utf-8?Q?N=C3=A4we?= <stefan.naewe@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	John Keeping <john@keeping.me.uk>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jul 23 06:20:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1U5G-0008Lp-RV
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jul 2013 06:20:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753489Ab3GWEUQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jul 2013 00:20:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54574 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752512Ab3GWEUP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jul 2013 00:20:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 94DDB2BC1D;
	Tue, 23 Jul 2013 04:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ejmd9hr19tthRBcwN/GU+1bysmE=; b=to9PoI
	GupHJRx6l+Z19GhV9DKGSVDATpdK841KTI1HOpSKQ39c+RR3JGYvN3OSn30qvu02
	0g6N9dgxdVNTtFhFCAVwqpdgNly8qpox5TDFxA3jYh96x1QNDwSU475alaMj+cap
	/gYHP/fsRUMDFGiSXeMV9Ty8eyhnvWOKFgxHo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B/OBC7hE2wfcg7U0OW1V2Jcxv6q3FDR/
	lo5hKFYUXYrRIO+pjLRZ3OoFtlbhq74It3UhdlpJ5w0P1W/xiNL6wMMl3Y5SQR41
	S4NwbiGvBnNTRFKTNkPWCmxxZH50sbxEo9DhUTKKeYZAdItYb6YjV1i/p5zLYDby
	pNRPJcU6nZk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A3C32BC1C;
	Tue, 23 Jul 2013 04:20:14 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CD4FE2BC18;
	Tue, 23 Jul 2013 04:20:13 +0000 (UTC)
In-Reply-To: <7vip0cdju9.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 15 Jul 2013 06:38:22 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2BEAD29A-F34F-11E2-BB07-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231019>

Junio C Hamano <gitster@pobox.com> writes:

>> I think the notice still deserve the "***NOTICE***" or whatever makes it
>> visible enough to distinguish it from the traditional licence &
>> non-warranty header, but I don't think we should kill the old script too
>> early.
>
> True.  I personally felt that Jonathan's (1) read the most natural
> (i.e. showing no strong preference, just let the users decide).

We need a decider to push this forward, so let's squash this in to
tone it down and then merge the result to 'next' (and then 'master'
by -rc1).

 contrib/hooks/post-receive-email | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index 23d7783..1531150 100755
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -4,8 +4,8 @@
 #
 # An example hook script to mail out commit update information.
 #
-# ***NOTICE***: This script is no longer under active development.  It
-# has been superseded by git-multimail, which is more capable and
+# NOTE: This script is no longer under active development.  There
+# is another script, git-multimail, which is more capable and
 # configurable and is largely backwards-compatible with this script;
 # please see "contrib/hooks/multimail/".  For instructions on how to
 # migrate from post-receive-email to git-multimail, please see
