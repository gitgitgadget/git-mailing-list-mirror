From: Torstein Hegge <hegge@resisty.net>
Subject: Re: [PATCH v6 0/4] commit: Add commit.verbose configuration
Date: Fri, 27 Feb 2015 10:13:36 +0100
Message-ID: <20150227091333.GA32617@pvv.ntnu.no>
References: <cover.1403033723.git.caleb@calebthompson.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jeremiah Mahler <jmmahler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Caleb Thompson <caleb@calebthompson.io>
X-From: git-owner@vger.kernel.org Fri Feb 27 10:31:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YRHGg-0001gV-LM
	for gcvg-git-2@plane.gmane.org; Fri, 27 Feb 2015 10:31:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752076AbbB0JbY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2015 04:31:24 -0500
Received: from microbel.pvv.ntnu.no ([129.241.210.179]:38336 "EHLO
	microbel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837AbbB0JbX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2015 04:31:23 -0500
X-Greylist: delayed 1060 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Feb 2015 04:31:22 EST
Received: from torstehe by microbel.pvv.ntnu.no with local (Exim 4.80)
	(envelope-from <torstehe@pvv.ntnu.no>)
	id 1YRGzI-00052G-1j; Fri, 27 Feb 2015 10:13:37 +0100
Content-Disposition: inline
In-Reply-To: <cover.1403033723.git.caleb@calebthompson.io>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264490>

On Tue, Jun 17, 2014 at 14:38:56 -0500, Caleb Thompson wrote:
> This patch allows people to set commit.verbose to implicitly send
> --verbose to git-commit.
> 
> It introduces several cleanup patches to t/t7505-commit-verbose.sh to
> bring it closer to the current state of the tests as they have been
> explained to me, then adds the verbose config and --no-verbose flag.
> 
> Since the last version of this patch
> (http://thread.gmane.org/gmane.comp.version-control.git/251486), there
> have been a couple of commit message clarifications and the body of the
> check-for-no-diff script in the last patch was changed to simply negate
> check-for-diff.

Hi Caleb,

Do you intend to work further on this topic? I have been using a similar
(but less polished) patch, and would like to see this included in Git.

If you don't have time to work on it, I can incorporate the comments on
this version and submit a v7.


Torstein
