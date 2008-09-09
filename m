From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Tue, 9 Sep 2008 15:48:31 +0200
Message-ID: <20080909134831.GB25476@cuci.nl>
References: <20080909132212.GA25476@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 09 15:49:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kd3bC-00059X-Oh
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 15:49:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753467AbYIINsc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 09:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753068AbYIINsc
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 09:48:32 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:35613 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752653AbYIINsc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 09:48:32 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 0A72E5465; Tue,  9 Sep 2008 15:48:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080909132212.GA25476@cuci.nl>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95385>

Stephen R. van den Berg wrote:
>Anything I missed?

I think I forgot two:
- git rebase will fixup any origin pointers which point back into the
  strain being rebased.

- git filter-branch will rewrite origin pointers which point to commits
  that receive a new hash.
-- 
Sincerely,
           Stephen R. van den Berg.

"Be spontaneous!"
