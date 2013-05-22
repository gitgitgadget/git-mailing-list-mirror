From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] Document push --no-verify
Date: Wed, 22 May 2013 22:23:59 +0200
Message-ID: <87vc6arcf4.fsf@linux-k42r.v.cablecom.net>
References: <bac9440ba0c977f6bd4207ac423f82b716947cc0.1369214470.git.trast@inf.ethz.ch>
	<7vli77j5nm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Aaron Schrab <aaron@schrab.com>, <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 22 22:24:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfFZx-0003lN-I2
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 22:24:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754726Ab3EVUYF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 May 2013 16:24:05 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:33049 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753849Ab3EVUYE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 May 2013 16:24:04 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 22 May
 2013 22:23:58 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (46.126.8.85) by
 cas10.d.ethz.ch (172.31.38.210) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Wed, 22 May 2013 22:24:00 +0200
In-Reply-To: <7vli77j5nm.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 22 May 2013 10:17:17 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225190>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast <trast@inf.ethz.ch> writes:
>
>> ec55559 (push: Add support for pre-push hooks, 2013-01-13) forgot to
>> add a note to git-push(1) about the new --no-verify option.
>
> Does it take --verify option (that may well be the default) so that
> somebody with
>
>          [alias] put = push --no-verify
>
> can say "git put --verify args..."?

Yes.  Doesn't parse-options implicitly do the correct negation for all
boolean options, even those that are declared in their negative form?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
