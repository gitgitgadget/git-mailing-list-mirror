From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [PATCH] cg-completion: improve options and command listing
Date: Sun, 18 Dec 2005 15:34:39 +0100
Message-ID: <20051218143439.GA7064@diku.dk>
References: <20051211190931.GF2960@diku.dk> <EF827EE8-7B7A-4D19-A08D-8C67D6B74195@hawaga.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Sun Dec 18 15:35:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Enzcr-0007GZ-PZ
	for gcvg-git@gmane.org; Sun, 18 Dec 2005 15:35:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932706AbVLROel (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Dec 2005 09:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932707AbVLROel
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Dec 2005 09:34:41 -0500
Received: from nhugin.diku.dk ([130.225.96.140]:57071 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S932706AbVLROek (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Dec 2005 09:34:40 -0500
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 844B66E0036; Sun, 18 Dec 2005 15:34:33 +0100 (CET)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 47DFC6DFF77; Sun, 18 Dec 2005 15:34:33 +0100 (CET)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 53E7961658; Sun, 18 Dec 2005 15:34:39 +0100 (CET)
To: Ben Clifford <benc@hawaga.org.uk>
Content-Disposition: inline
In-Reply-To: <EF827EE8-7B7A-4D19-A08D-8C67D6B74195@hawaga.org.uk>
User-Agent: Mutt/1.5.6i
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13794>

Ben Clifford <benc@hawaga.org.uk> wrote Sun, Dec 18, 2005:
> 
> On 12 Dec 2005, at 04:39, Jonas Fonseca wrote:
> 
> >Complete help options and improve filtering for command name  
> >completion.
> >
> >Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
> >
> 
> Hi. I've applied this patch to the dev branch cg-compl in my  
> gitcompletion repo.
> 
> I'm interested by what you mean by 'all sorts of garbage' - it seems  
> ok on my machine.

~/src/cogito/cogito > __cg_cmdlist | head
        cg-add             Add files to the GIT repository.
        cg-clean           Clean unknown files from the working tree.
        cg-clone           Clone a remote GIT repository.
        cg-commit          Commit into a GIT repository.
        cg-diff            Make a diff between two GIT trees.
        cg-export          Exports a particular revision from a GIT repository.
        cg-fetch           Fetch changes from a remote branch to the local GIT repository.
        cg-help            Show help for Cogito commands.
        cg-init            Initialize a GIT repository.
        cg-log             Make a log of changes in a GIT branch.

Else I was thinking of maybe adding --list parameter to cg-help to have
it list all known commands.

-- 
Jonas Fonseca
