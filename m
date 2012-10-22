From: <dag@cray.com>
Subject: Re: Subtree in Git
Date: Mon, 22 Oct 2012 09:47:19 -0500
Message-ID: <nng1ugqfts8.fsf@transit.us.cray.com>
References: <CAE1pOi2uT=wipyrOYCwy9QuXnXFV27F1gN3Ej-RaSr-fegQCfA@mail.gmail.com>
	<nngk410vrja.fsf@transit.us.cray.com> <4F9FA029.7040201@initfour.nl>
	<87fwbgbs0h.fsf@smith.obbligato.org>
	<7v8vh78dag.fsf@alter.siamese.dyndns.org>
	<4FA82799.1020400@initfour.nl> <nngzk9jvemb.fsf@transit.us.cray.com>
	<nngaa0z3p8b.fsf@transit.us.cray.com>
	<87bokpxqoq.fsf@smith.obbligato.org> <4FD89383.70003@initfour.nl>
	<nng4npe6zsj.fsf@transit.us.cray.com> <50830374.9090308@initfour.nl>
	<7vbofwgwso.fsf@alter.siamese.dyndns.org>
	<5084102A.2010006@initfour.nl>
	<7vfw57fvtl.fsf@alter.siamese.dyndns.org>
	<508459B3.6030403@initfour.nl>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, <greened@obbligato.org>,
	"Hilco Wijbenga" <hilco.wijbenga@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Herman van Rink <rink@initfour.nl>
X-From: git-owner@vger.kernel.org Mon Oct 22 16:49:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQJJf-0003Pq-Vp
	for gcvg-git-2@plane.gmane.org; Mon, 22 Oct 2012 16:49:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755154Ab2JVOtI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2012 10:49:08 -0400
Received: from exprod6og114.obsmtp.com ([64.18.1.33]:37821 "EHLO
	exprod6og114.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754842Ab2JVOtG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2012 10:49:06 -0400
Received: from CFWEX01.americas.cray.com ([136.162.34.11]) (using TLSv1) by exprod6ob114.postini.com ([64.18.5.12]) with SMTP
	ID DSNKUIVc16lVWyCvjnIjnOV4y3YgAF+rVLZW@postini.com; Mon, 22 Oct 2012 07:49:06 PDT
Received: from transit.us.cray.com (172.31.17.53) by CFWEX01.americas.cray.com
 (172.30.88.25) with Microsoft SMTP Server (TLS) id 14.2.318.1; Mon, 22 Oct
 2012 09:47:20 -0500
In-Reply-To: <508459B3.6030403@initfour.nl> (Herman van Rink's message of
	"Sun, 21 Oct 2012 22:23:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208194>

Herman van Rink <rink@initfour.nl> writes:

> The problem is that I don't have the time to split all these out. Dag
> has indicated that he does not have the time either.

I would have the time to review and integrate separate patches.  I do
not have time to unwrap the ball of wax and ensure the quality of each
feature and bug fix.  That is the responsibility of the submitter.  You
can't expect reviewers to do your work for you.  I'm not being harsh, it
is simply the reality of how things work in every project I've been
involved with.

> This single ball of wax was already an alternative to the 'messy' merge
> history it had accumulated. The result of merging from dozens of github
> forks with numerous levels of parallel/contra-productive whitspace fixes.

Yes, we don't really want that history.  You have a single patch now.  A
series of git rebase -i + git add -i should make it easy to separate it
into patches for each feature and bug fix, as I suggested previously.

It really, really shouldn't be that hard unless the code is atrocious.

                            -David
