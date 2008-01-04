From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] git stash: one bug and one feature request
Date: Fri, 04 Jan 2008 12:00:25 -0600
Message-ID: <477E7439.9090209@nrlssc.navy.mil>
References: <e5bfff550801040814n82f34b2g17c485a207093440@mail.gmail.com>	 <Pine.LNX.4.64.0801041030420.31161@torch.nrlssc.navy.mil>	 <477E6D26.9020809@obry.net> <e5bfff550801040944p7f8e722asfa726b34a4a712fa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Pascal Obry <pascal@obry.net>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 04 19:03:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAqtL-00028X-64
	for gcvg-git-2@gmane.org; Fri, 04 Jan 2008 19:03:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751943AbYADSDG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 13:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752704AbYADSDF
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 13:03:05 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:54154 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751943AbYADSDE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 13:03:04 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m04I0QBq020941;
	Fri, 4 Jan 2008 12:00:26 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 4 Jan 2008 12:00:26 -0600
User-Agent: Thunderbird 2.0.0.6 (X11/20070728)
In-Reply-To: <e5bfff550801040944p7f8e722asfa726b34a4a712fa@mail.gmail.com>
X-OriginalArrivalTime: 04 Jan 2008 18:00:26.0182 (UTC) FILETIME=[AF1E5E60:01C84EFB]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15638001
X-TM-AS-Result: : Yes--7.509600-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : 
	150567-700075-139010-703454-704421-704425-707451-704240-703788-148039
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69588>

Marco Costalba wrote:
> Ok, drop is better then clear, but, if we need to add a new command I
> vote for 'delete' or 'rm' to be consistent with git naming.

If the stash list is thought of as a stack, then drop makes sense.

I imagine using it like

   git stash apply
   git stash drop
   git stash apply stash@{3}
   git stash drop stash@{3}

'git stash delete' and 'git stash rm' when used without arguments
both sound like 'git stash clear' to me.

-brandon
