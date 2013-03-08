From: Jeff King <peff@peff.net>
Subject: [PATCHv2] setup and GIT_IMPLICIT_WORK_TREE
Date: Fri, 8 Mar 2013 04:28:25 -0500
Message-ID: <20130308092824.GA9127@sigill.intra.peff.net>
References: <20130308084343.GB10963@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>,
	Mark Lodato <lodatom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 08 10:28:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDtbj-00051O-B5
	for gcvg-git-2@plane.gmane.org; Fri, 08 Mar 2013 10:28:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933971Ab3CHJ23 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Mar 2013 04:28:29 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40775 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933331Ab3CHJ22 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Mar 2013 04:28:28 -0500
Received: (qmail 15029 invoked by uid 107); 8 Mar 2013 09:30:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 08 Mar 2013 04:30:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Mar 2013 04:28:25 -0500
Content-Disposition: inline
In-Reply-To: <20130308084343.GB10963@sigill.intra.peff.net>
 <20130308084225.GA10963@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217650>

Here's a re-roll of the GIT_IMPLICIT_WORK_TREE patch which should
address the comments in the last round. I've added an explanatory
comment near the variable definition, and added it to local_repo_env.

While doing that, I noticed some cleanup opportunities around
local_repo_env, which resulted in the first two patches.

  [1/3]: cache.h: drop LOCAL_REPO_ENV_SIZE
  [2/3]: environment: add GIT_PREFIX to local_repo_env
  [3/3]: setup: suppress implicit "." work-tree for bare repos

-Peff
