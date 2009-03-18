From: "David J. Mellor" <dmellor@whistlingcat.com>
Subject: Re: [PATCH 1/4] Documentation: minor grammatical fixes in git-archive.txt.
Date: Tue, 17 Mar 2009 19:54:16 -0700
Message-ID: <49C06258.40809@whistlingcat.com>
References: <1237270577-17261-1-git-send-email-dmellor@whistlingcat.com> <49BF6AD9.4020207@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Mar 18 03:55:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ljlwa-0004Wn-Sp
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 03:55:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754844AbZCRCyT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 22:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754762AbZCRCyT
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 22:54:19 -0400
Received: from quartz.whistlingcat.com ([67.223.228.111]:35797 "EHLO
	quartz.whistlingcat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753011AbZCRCyS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 22:54:18 -0400
Received: from whistlingcat.com (whistlingcat.com [99.12.234.57])
	by quartz.whistlingcat.com (Postfix) with ESMTP id 1241C488006;
	Tue, 17 Mar 2009 19:54:17 -0700 (PDT)
Received: from sandstone.whistlingcat.com (sandstone.whistlingcat.com [192.168.0.2])
	by whistlingcat.com (Postfix) with ESMTP id D19C438E74F3;
	Tue, 17 Mar 2009 19:54:16 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <49BF6AD9.4020207@drmicha.warpmail.net>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113568>

On 03/17/2009 02:18 AM, Michael J Gruber wrote:
> One minor reoccurring issue is the following type of construct:
> 
> ###
> The good/bad input is logged, and:
> 
> ------------
> $ git bisect log
> ------------
> 
> shows what you have done so far.
> ###
> 
> The first line is not a complete sentence.

I agree. I will send a revised patch (patch 2 in this sequence) that 
corrects this.

> Neither is the last one,
> which you have to read together with the code inset (that's fine), which
> on the other belongs to the sentence started in line 1.
> 
> All of the above constitutes 1 sentence and should not be chopped in
> parts by the colon.
> 
> I know this construct is somewhat common, but I don't think it is
> correct. In any case it disrupts the reading flow. [In fact, that
> disruption is the very reason why it is sometimes used in the middle of
> a written sentence: as a substitute for the rhetoric element "pause".]

I agree that it is probably not strictly correct, but this construct 
appears frequently in the git documentation. My main concern with this 
patch was to make the presentation of example command lines internally 
consistent, if not strictly grammatically correct, i.e. some examples 
were introduced following a colon, while others were not.

> In the example above your patch introduces it, in other places it has
> been used before. So this might my an opportunity to get rid of it
> consistently ;)

Go for it!

> Michael
> 

David.
