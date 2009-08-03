From: Jan Engelhardt <jengelh@medozas.de>
Subject: Re: Have git-merge-base support multiple IDs
Date: Mon, 3 Aug 2009 15:39:55 +0200 (CEST)
Message-ID: <alpine.LSU.2.00.0908031539070.2603@fbirervta.pbzchgretzou.qr>
References: <alpine.LSU.2.00.0907311745100.4901@fbirervta.pbzchgretzou.qr> <4A731A39.3090506@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Aug 03 15:41:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXxml-0008UO-Dw
	for gcvg-git-2@gmane.org; Mon, 03 Aug 2009 15:41:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754996AbZHCNj5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2009 09:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754893AbZHCNj4
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Aug 2009 09:39:56 -0400
Received: from sovereign.computergmbh.de ([85.214.69.204]:34373 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754887AbZHCNj4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2009 09:39:56 -0400
Received: by sovereign.computergmbh.de (Postfix, from userid 25121)
	id 540EF21CD2; Mon,  3 Aug 2009 15:39:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by sovereign.computergmbh.de (Postfix) with ESMTP id 4F3B442064BD;
	Mon,  3 Aug 2009 15:39:55 +0200 (CEST)
In-Reply-To: <4A731A39.3090506@drmicha.warpmail.net>
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124693>


On Friday 2009-07-31 18:22, Michael J Gruber wrote:
>Jan Engelhardt venit, vidit, dixit 31.07.2009 17:51:
>> To determine the rebase point (i.e. first commit in a series),
>> one can (ab)use git-merge-base:
>> 
>>   p=$(git merge-base ab80794f faae2553)
>>   git re -i ${p}^
>> 
>> The twist is that merge-base in git 1.6.3.3 happens to ignore any 
>> further arguments following two IDs. In short:
>> 
>>   git merge-base A B C...
>> 
>> Only yields the merge-base of A and B, and ignores C...
>
>Uhm, are you sure about this?
>The first argument is special. merge-base computes the merge base between two commits:
>- the first argument
>- a (hypothetical) merge between all other arguments.
>It may look a if C was ignored, though.

Hm indeed. Is there a better way to find the common ancestor of commits?
