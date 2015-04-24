From: Kevin Daudt <me@ikke.info>
Subject: Re: About git log
Date: Fri, 24 Apr 2015 12:57:24 +0200
Message-ID: <20150424105724.GA11455@vps892.directvps.nl>
References: <1428330097.5157.5.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: niu2x <niu2x@aol.com>
X-From: git-owner@vger.kernel.org Fri Apr 24 12:57:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YlbIZ-0002XC-Lt
	for gcvg-git-2@plane.gmane.org; Fri, 24 Apr 2015 12:57:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754224AbbDXK51 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2015 06:57:27 -0400
Received: from ikke.info ([178.21.113.177]:34212 "EHLO vps892.directvps.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752510AbbDXK50 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2015 06:57:26 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1001)
	id C794B440082; Fri, 24 Apr 2015 12:57:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1428330097.5157.5.camel@localhost>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267728>

On Mon, Apr 06, 2015 at 10:21:37PM +0800, niu2x wrote:
> I'm a beginner.
> Please tell me the log of git commit is exist forever or 90 days

As long as a commit is (indirectly) referenced by a branch or tag, it will
be kept forever. Only if you rewrite history causing commits to be
unreferenced (for example, by using git reset --hard), the commits will be
eventually removed.

The 90 days you might have heard of, refers to the time the reflog keeps
reference to commits so that you can find them back in case you
accidentally caused the commit to be unreferenced.

Entries in the reflog will expire after 90 days, after which no reference
to the commits remain, and the garbage collector will remove those commits.
