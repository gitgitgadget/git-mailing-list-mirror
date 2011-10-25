From: Jeff King <peff@peff.net>
Subject: Re: general protection faults with "git grep" version 1.7.7.1
Date: Mon, 24 Oct 2011 22:53:11 -0700
Message-ID: <20111025055310.GB1902@sigill.intra.peff.net>
References: <20111024201153.GA1647@x4.trippels.de>
 <20111024214949.GA5237@amd.home.annexia.org>
 <20111024225836.GA1678@x4.trippels.de>
 <878voaym7k.fsf@norang.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Markus Trippelsdorf <markus@trippelsdorf.de>,
	"Richard W.M. Jones" <rjones@redhat.com>, meyering@redhat.com,
	git@vger.kernel.org
To: Bernt Hansen <bernt@norang.ca>
X-From: git-owner@vger.kernel.org Tue Oct 25 07:53:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIZxH-00006v-6R
	for gcvg-git-2@lo.gmane.org; Tue, 25 Oct 2011 07:53:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751876Ab1JYFxQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Oct 2011 01:53:16 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55795
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751522Ab1JYFxQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2011 01:53:16 -0400
Received: (qmail 12211 invoked by uid 107); 25 Oct 2011 05:59:02 -0000
Received: from 75-147-138-244-SFBA.hfc.comcastbusiness.net (HELO sigill.intra.peff.net) (75.147.138.244)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 25 Oct 2011 01:59:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Oct 2011 22:53:11 -0700
Content-Disposition: inline
In-Reply-To: <878voaym7k.fsf@norang.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184198>

On Mon, Oct 24, 2011 at 08:00:15PM -0400, Bernt Hansen wrote:

> I updated from an old commit 2883969 (Sync with maint, 2011-10-15)
> to origin/master 10b2a48 (Merge branch 'maint', 2011-10-23) today and
> promptly got segfaults on git status in my org-mode repository.
> 
> Going back to the old commit makes it work again.
> 
> Git bisect identifies the following commit as the problem:
> 
> [2548183badb98d62079beea62f9d2e1f47e99902] fix phantom untracked files when core.ignorecase is set

I think this is a separate problem. See this thread and patch:

  http://thread.gmane.org/gmane.comp.version-control.git/184094/focus=184148

-Peff
