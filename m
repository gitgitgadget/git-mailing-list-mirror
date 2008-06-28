From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: An alternate model for preparing partial commits
Date: Sat, 28 Jun 2008 11:30:28 +0200
Message-ID: <20080628093028.GA26745@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Sinclair <radarsat1@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: David Jeske <jeske@willowmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 28 11:32:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCWmq-00073J-Un
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 11:32:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754600AbYF1Jab (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jun 2008 05:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754589AbYF1Jab
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jun 2008 05:30:31 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:32781 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754587AbYF1Jaa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jun 2008 05:30:30 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id F1CE95465; Sat, 28 Jun 2008 11:30:28 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86710>

David Jeske wrote:
>- I could supercede 2-commits with 1, effectively making the bad-commit
>disappear in the linear history. Users who already have the history, however,
>would be unaffected, because the start/end endpoints are the same.

Superseding does not work in git trees and is a disruptive operation to
*all* commits following the point being superseded.
Also, superseding preserves the startpoint, but *always* alters the
endpoint.

I suggest you take a look at how a git-repository is stored and learn
about how the SHA1-hashes interact with the stored repository.
-- 
Sincerely,
           Stephen R. van den Berg.

Heisenberg might have been here.
