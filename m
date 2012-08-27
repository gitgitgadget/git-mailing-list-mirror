From: <dag@cray.com>
Subject: Re: libgit2 status
Date: Mon, 27 Aug 2012 11:13:12 -0500
Message-ID: <nnglih0jotj.fsf@transit.us.cray.com>
References: <87a9xkqtfg.fsf@waller.obbligato.org> <5038A148.4020003@op5.se>
	<7vharpv77n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Andreas Ericsson <ae@op5.se>, <greened@obbligato.org>,
	<git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 27 18:20:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T623b-0002M7-H8
	for gcvg-git-2@plane.gmane.org; Mon, 27 Aug 2012 18:20:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751877Ab2H0QUt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Aug 2012 12:20:49 -0400
Received: from exprod6og104.obsmtp.com ([64.18.1.187]:39818 "EHLO
	exprod6og104.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751334Ab2H0QUs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2012 12:20:48 -0400
X-Greylist: delayed 340 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Aug 2012 12:20:48 EDT
Received: from CFWEX01.americas.cray.com ([136.162.34.11]) (using TLSv1) by exprod6ob104.postini.com ([64.18.5.12]) with SMTP
	ID DSNKUDueX4aDcCNqcfBmlmBDWjKoeCBccF48@postini.com; Mon, 27 Aug 2012 09:20:48 PDT
Received: from transit.us.cray.com (172.31.17.53) by CFWEX01.americas.cray.com
 (172.30.88.25) with Microsoft SMTP Server (TLS) id 14.2.318.1; Mon, 27 Aug
 2012 11:13:14 -0500
In-Reply-To: <7vharpv77n.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 26 Aug 2012 11:28:12 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204353>

Junio C Hamano <gitster@pobox.com> writes:

> And the last one should really be a "longer term" item.  It is more
> important for its codebase to get mature and robust, and that can
> only happen by various projects and products (e.g. GitHub for Mac)
> using it to improve it.  I do not think "subtree" (or anything in
> contrib/ for that matter) is part of "the core stuff of git", and do
> not see a problem; such a move may help both subtree and libgit2.
>
> Over a much longer timeperiod, I wouldn't be surprised if some "core
> stuff" gets reimplemented on top of libgit2 and distributed as part
> of the git-core.

I am hoping to move git-subtree into core once it performs a little
better and I've fixed a couple of bugs.  Will basing it on libgit2 delay
that process significantly?  Six months delay is no problem.  2 years
would be problematic.

I would be happy to be a guinea pig for libgit2 in order to improve it,
but I don't want to significantly impact git-subtree's move to core.
I'll have to figure out the right balance there given feedback.

                         -Dave
