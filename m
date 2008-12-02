From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Branch name with space
Date: Tue, 2 Dec 2008 10:03:44 -0800
Message-ID: <20081202180344.GW23984@spearce.org>
References: <4935719A.8000705@distributel.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Le <le_wen@distributel.ca>
X-From: git-owner@vger.kernel.org Tue Dec 02 19:06:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7ZcM-000808-9o
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 19:05:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752556AbYLBSDp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 13:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754631AbYLBSDp
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 13:03:45 -0500
Received: from george.spearce.org ([209.20.77.23]:56946 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752332AbYLBSDp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 13:03:45 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 5348838200; Tue,  2 Dec 2008 18:03:44 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4935719A.8000705@distributel.ca>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102166>

Le <le_wen@distributel.ca> wrote:
> I tried to rename a branch to a new name with space in it. It complained :
> git-branch -M 'test 1' or test\ 1
> fatal: Invalid branch name: refs/heads/test 1
>
> Is there a way the get round this problem?

Don't put spaces in branch names.  They aren't permitted.  Use
an underscore ('_') or a hypen ('-').

-- 
Shawn.
