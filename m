From: Kevin Daudt <me@ikke.info>
Subject: Re: [PATCH v2 17/19] pull --rebase: exit early when the working
 directory is dirty
Date: Wed, 3 Jun 2015 12:27:16 +0200
Message-ID: <20150603102716.GA29730@vps892.directvps.nl>
References: <1433314143-4478-1-git-send-email-pyokagan@gmail.com>
 <1433314143-4478-18-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 12:27:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z05tL-0000Z1-MR
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 12:27:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753163AbbFCK1U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 06:27:20 -0400
Received: from ikke.info ([178.21.113.177]:49497 "EHLO vps892.directvps.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753069AbbFCK1S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 06:27:18 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1001)
	id 002DC1DCF6D; Wed,  3 Jun 2015 12:27:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1433314143-4478-18-git-send-email-pyokagan@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270677>

On Wed, Jun 03, 2015 at 02:49:01PM +0800, Paul Tan wrote:
> Re-implement the behavior introduced by f9189cf (pull --rebase: exit
> early when the working directory is dirty, 2008-05-21).

When the option rebase.autoStash is set, it should not be necessary to
die in this case. See also this[1] patch I'm working on.

[1]: http://article.gmane.org/gmane.comp.version-control.git/270612
