From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [RFC/PATCH] clone: introduce clone.submoduleGitDir to relocate
 $GITDIR
Date: Mon, 15 Apr 2013 14:50:19 -0400
Message-ID: <516C4BEB.7030507@xiplink.com>
References: <1365881007-25731-1-git-send-email-artagnon@gmail.com> <7vy5ck4m6b.fsf@alter.siamese.dyndns.org> <CALkWK0mvtRhFc0_4883ATNaYpb+kDwpV9VxeAoqJy5HxNQ6vgg@mail.gmail.com> <516C21CF.5080705@xiplink.com> <7vvc7nu1hu.fsf@alter.siamese.dyndns.org> <CALkWK0n0y6OPJvYjNeEbUx_CC58vHRRLCsmJtws+RKyv3wRTwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 15 20:50:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URoUA-0001mj-DJ
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 20:50:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934956Ab3DOSud (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 14:50:33 -0400
Received: from smtp138.ord.emailsrvr.com ([173.203.6.138]:59458 "EHLO
	smtp138.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934944Ab3DOSuU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 14:50:20 -0400
X-Greylist: delayed 407 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Apr 2013 14:50:20 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp18.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id C0096300B8;
	Mon, 15 Apr 2013 14:50:19 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp18.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 67088300BC;
	Mon, 15 Apr 2013 14:50:19 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <CALkWK0n0y6OPJvYjNeEbUx_CC58vHRRLCsmJtws+RKyv3wRTwQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221286>

On 13-04-15 02:00 PM, Ramkumar Ramachandra wrote:
> Junio C Hamano wrote:
>> 
>> I do not think the addition Ram is envisioning in the patch will
>> prevent you from teaching "add" to do that.  An implemention of such
>> an addition indeed would most likely use the same --separate-git-dir
>> mechanism anyway.
> 
> Well, I'm against the change in principle because add operates on
> worktree paths, not URLs.  I don't want to change that arbitrarily.

I don't understand that statement.

If "git add" is all about specifying what lives under paths in the worktree,
what's wrong with letting "git add" go beyond specifying just files?

Syntax aside for the moment, I think a command like
	git add git-repo-reference foo
is perfectly natural:  It specifies what is inside worktree path foo.

		M.
