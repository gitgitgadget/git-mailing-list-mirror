From: Adam Heath <doogie@brainfood.com>
Subject: Re: large(25G) repository in git
Date: Tue, 24 Mar 2009 19:57:46 -0500
Message-ID: <49C9818A.9040507@brainfood.com>
References: <49C7FAB3.7080301@brainfood.com> <20090324210427.GC30959@zoy.org> <49C95453.9080503@brainfood.com> <alpine.LFD.2.00.0903242025110.26337@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Sam Hocevar <sam@zoy.org>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Mar 25 02:00:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmHUG-0003ba-Aa
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 02:00:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752487AbZCYA5y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 20:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752368AbZCYA5x
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 20:57:53 -0400
Received: from newmail.brainfood.com ([70.103.162.5]:40597 "EHLO
	newmail.brainfood.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752340AbZCYA5x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 20:57:53 -0400
Received: from localhost (localhost [127.0.0.1])
	by newmail.brainfood.com (Postfix) with ESMTP id 5F7C8F885E;
	Tue, 24 Mar 2009 19:57:51 -0500 (CDT)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: 0.101
X-Spam-Level: 
X-Spam-Status: No, score=0.101 tagged_above=-10 required=6.6
	tests=[BAYES_50=0.001, RDNS_DYNAMIC=0.1]
Received: from newmail.brainfood.com ([127.0.0.1])
	by localhost (newmail.brainfood.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D6b4mGGTDbzi; Tue, 24 Mar 2009 19:57:46 -0500 (CDT)
Received: from [192.168.2.49] (70-103-162-249.brainfood.com [70.103.162.249])
	by newmail.brainfood.com (Postfix) with ESMTP id BBF7FF8847;
	Tue, 24 Mar 2009 19:57:46 -0500 (CDT)
User-Agent: Mozilla-Thunderbird 2.0.0.17 (X11/20081018)
In-Reply-To: <alpine.LFD.2.00.0903242025110.26337@xanadu.home>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114532>

Nicolas Pitre wrote:
> On Tue, 24 Mar 2009, Adam Heath wrote:
> 
>> Sam Hocevar wrote:
>>>    In your particular case, I would suggest setting pack.packSizeLimit
>>> to something lower. This would reduce the time spent generating a new
>>> pack file if the problem were to happen again.
>> Yeah, saw that one, but *after* I had this problem.  The default, if
>> not set, is unlimited, which in this case, is definately *not* what we
>> want.
> 
> In your particular case, if the problem is actually what I think it is, 
> the pack.packSizeLimit wouldn't have made any difference.  This setting 
> affects local repacking only and has no effect what so ever on the push 
> operation.

Ooh.  Care to enlighten those of us not blessed with git internal
knowledge?

On another note, anyone have a goat I can buy, for the sacrifice?
