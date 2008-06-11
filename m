From: Armen Baghumian <armen@OpenSourceClub.org>
Subject: Re: Project's repository infrastructure (sunbtree and submodules)
Date: Wed, 11 Jun 2008 12:34:57 +0430
Message-ID: <20080611123457.442d1029@debian>
References: <20080609194203.06698e01@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 11 10:06:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6LLE-0005rH-73
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 10:06:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753774AbYFKIFG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 04:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753748AbYFKIFF
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 04:05:05 -0400
Received: from static.88-198-8-89.clients.your-server.de ([88.198.8.89]:47166
	"EHLO julius.technotux.org" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753541AbYFKIFC (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Jun 2008 04:05:02 -0400
Received: from localhost (localhost [127.0.0.1])
	by julius.technotux.org (Postfix) with ESMTP id 386D5504EB
	for <git@vger.kernel.org>; Wed, 11 Jun 2008 10:05:40 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at julius.technotux.org
Received: from julius.technotux.org ([127.0.0.1])
	by localhost (julius.technotux.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IQR62gMLBzGL for <git@vger.kernel.org>;
	Wed, 11 Jun 2008 10:05:38 +0200 (CEST)
Received: from debian (unknown [91.184.88.117])
	by julius.technotux.org (Postfix) with ESMTP id 04355504BF
	for <git@vger.kernel.org>; Wed, 11 Jun 2008 10:05:37 +0200 (CEST)
In-Reply-To: <20080609194203.06698e01@debian>
X-Mailer: Claws Mail 3.4.0 (GTK+ 2.12.9; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84599>

Hi,

Am I asking totally wrong question or asking it in wrong place?
would you please point me to correct place or documentation.

--Armen

On Mon, 9 Jun 2008 19:42:03 +0430
Armen Baghumian <armen@OpenSourceClub.org> wrote:

> Hi,
> 
> I have several projects which each project contains several modules.
> modules are shared between projects.
> 
> For example let say there is three modules A, B, and C, and two
> project called P1 and P2. P1 uses A and B modules and P2 uses B and C.
> 
> I want to have centralized place to clone/pull/push in P1 and P2 and
> it would be nice to push changes in modules(A,B,C) from projects
> (P1,P2) so when changes in B pushed from P1 it could be pulled from P2
> (think B as a shared module between P1 and P2). 
> 
> As far as modules are not big enough I don't want to push changes
> directly in to those repositories.
> 
> To solve the problem I just create three separated repositories for
> each modules (A,B,C) and create two other repositories for each
> project and use git-submodule to add modules in each repository.
> 
> pushing changes to modules(A,B,C) are really error prone and annoying
> so I searched for a better way to solve that problem.
> 
> Seems subtree merge[1] is other choice but I'm not sure.
> 
> 1) What is best way to solve such situation?
> 2) If subtree is best choice how to push changes to modules(A,B,C)
> from projects?
> 
> --Armen
> 
> [1]
> http://www.kernel.org/pub/software/scm/git/docs/howto/using-merge-subtree.html
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
