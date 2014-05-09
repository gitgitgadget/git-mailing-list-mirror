From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH v1 1/2] Remove 'git archimport'
Date: Fri, 9 May 2014 08:59:37 +0000
Message-ID: <20140509085937.GA29347@dcvr.yhbt.net>
References: <1399599203-13991-1-git-send-email-felipe.contreras@gmail.com>
 <1399599203-13991-2-git-send-email-felipe.contreras@gmail.com>
 <20140509055024.GB30674@dcvr.yhbt.net>
 <536c7f9089b77_182dd0d31084@nysa.notmuch>
 <20140509081507.GA26494@dcvr.yhbt.net>
 <536c939781d8b_2bf0e952f08@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Martin Langhoff <martin@laptop.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 10:59:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wigee-0006Bb-7I
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 10:59:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753527AbaEII7j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 04:59:39 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:37576 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752187AbaEII7h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 04:59:37 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5127120945;
	Fri,  9 May 2014 08:59:37 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <536c939781d8b_2bf0e952f08@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248537>

Felipe Contreras <felipe.contreras@gmail.com> wrote:
> As a minimal token that anybody might possibly be using it, I would like
> to see it work at least once. Since you said you have arch repos, can
> you confirm that it does something?

Those repos are in offline/offsite storage and I do not have time to
retrieve them.  I've forgotten how to use tla to get a public repo,
even.

> Eric Wong wrote:
> > No, I am not convinced existing foreign SCM tools should move
> > out-of-tree.  Perhaps something like the following would be helpful:
> 
> Tell that to Junio.
> 
> If tools like git-remote-hg with tests and active maintanance and many
> users cannot be in the core, why should 'git archimport' be?

Perhaps it's easier to deal with a benign, unmaintained tool than
to deal with you as a maintainer?

> Would you at least be OK with a demotion to contrib/?

I don't see the point of moving it around, even.
