From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH 2/2] Fix t3404 assumption that `wc -l` does not use whitespace.
Date: Sun, 27 Apr 2008 11:32:24 -0400
Message-ID: <B287EA35-6C5D-4A5A-BEF1-C55A70D913ED@silverinsanity.com>
References: <20080427151610.GB57955@Hermes.local> <alpine.DEB.1.00.0804271620440.16320@eeepc-johanness>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Apr 27 17:33:16 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jq8sM-0005d7-6D
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 17:33:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755140AbYD0Pc3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 11:32:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754989AbYD0Pc3
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 11:32:29 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:39496 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754891AbYD0Pc1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 11:32:27 -0400
Received: from [192.168.1.7] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id AF2391FFD6C4;
	Sun, 27 Apr 2008 15:32:22 +0000 (UTC)
In-Reply-To: <alpine.DEB.1.00.0804271620440.16320@eeepc-johanness>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80452>


On Apr 27, 2008, at 11:22 AM, Johannes Schindelin wrote:

> On Sun, 27 Apr 2008, Brian Gernhardt wrote:
>
>> Should this construct go into CodingStyle?  I seem to have to write
>> patches like this every month or so.
>
> Yes, probably.  I am very sorry, I really should have reviewed those
> patches better (I know that ":" in expr is better than "match",  
> "tac" is
> something to be avoided, and "wc -l" can output whitespace).  It did  
> not
> help that I hated the fact that that series changed the original  
> design
> without even understanding it.

Eh, not everyone's perfect.  I would have used `rev` instead of `tac`  
and still been wrong for Solaris.  But it seems that the `wc -l`  
whitespace issue seems to hit nearly everyone at some point, so I  
thought it would be a good candidate for CodingStyle.

Personally, I'd love to have the time to review all the patches to  
catch these issues while still on the list instead of waiting until  
they hit next and I tried to compile it.  But I don't always notice,  
have time, or care myself.

~~ Brian
