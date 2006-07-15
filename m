From: Alp Toker <alp@atoker.com>
Subject: Re: [PATCH] urls.txt: Use substitution to escape square brackets
Date: Sat, 15 Jul 2006 01:38:06 +0100
Message-ID: <44B838EE.5020609@atoker.com>
References: <11528726881431-git-send-email-alp@atoker.com>	<20060714215039.GA21994@diku.dk> <7v3bd3ois4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Sat Jul 15 02:39:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G1YBI-0007zK-5X
	for gcvg-git@gmane.org; Sat, 15 Jul 2006 02:38:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945946AbWGOAig (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Jul 2006 20:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945955AbWGOAif
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Jul 2006 20:38:35 -0400
Received: from host-84-9-44-142.bulldogdsl.com ([84.9.44.142]:21769 "EHLO
	ndesk.org") by vger.kernel.org with ESMTP id S1945952AbWGOAiI (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Jul 2006 20:38:08 -0400
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by ndesk.org (Postfix) with ESMTP id 43F01176C96;
	Sat, 15 Jul 2006 01:38:07 +0100 (BST)
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v3bd3ois4.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23919>

Junio C Hamano wrote:
> Alp is right -- the comments in [attributes] section after the
> definition do appear in the output, even with asciidoc 7.1.2, so
> here is a replacement proposal from me.
> 
> The one by Alp is an easy work-around, but I do not want to
> worry about potential, unintended, breakages that might be
> caused by changing delimited blocks to literal paragraphs (and
> it changes the resulting rendering from the original).
> 
> -- >8 --
> From: Jonas Fonseca <fonseca@diku.dk>
> 
> This changes "[user@]" to use {startsb} and {endsb} to insert [ and ],
> similar to how {caret} is used in git-rev-parse.txt.
> 
> [jc: Removed a well-intentioned comment that broke the final
>  formatting from the original patch.  While we are at it,
>  updated the paragraph that claims to be equivalent to the
>  section that was updated earlier without making matching
>  changes.]
> 
> Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
> Signed-off-by: Junio C Hamano <junkio@cox.net>

Signed-off-by: Alp Toker <alp@atoker.com>
