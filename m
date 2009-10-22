From: Bill Lear <rael@zopyra.com>
Subject: Re: Any way to "flatten" a series of changes in git
Date: Thu, 22 Oct 2009 15:30:53 -0500
Message-ID: <19168.49405.775024.649626@lisa.zopyra.com>
References: <26ae428a0910221303n493fb7s701269d694110685@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Howard Miller <howard@e-learndesign.co.uk>
X-From: git-owner@vger.kernel.org Thu Oct 22 22:31:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N14JN-00070S-4v
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 22:31:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755582AbZJVUay (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2009 16:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754734AbZJVUay
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 16:30:54 -0400
Received: from 75-27-130-60.lightspeed.austtx.sbcglobal.net ([75.27.130.60]:33037
	"EHLO zopyra.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754632AbZJVUay (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2009 16:30:54 -0400
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id n9MKUtd11130;
	Thu, 22 Oct 2009 14:30:55 -0600
In-Reply-To: <26ae428a0910221303n493fb7s701269d694110685@mail.gmail.com>
X-Mailer: VM 8.0.11 under Emacs 21.1.1 (i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131052>

On Thursday, October 22, 2009 at 21:03:44 (+0100) Howard Miller writes:
>Hello,
>
>I have a branch with a whole series of commits. I want to export this
>work to be customer (to their svn repo if that has any bearing on it).
>All the stuff in the history is irrelevant to my customer ("committing
>now, going to bed" etc.) so I'd like to create a new branch that only
>has one commit.. the end point with a new message. Is this possible?

git rebase is your friend.


Bill
