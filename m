From: Eric Gerlach <egerlach@feds.uwaterloo.ca>
Subject: Re: Is "show-ref -h" a good test for an empty repository?
Date: Sun, 07 Sep 2008 10:21:16 -0400
Message-ID: <48C3E35C.2050903@feds.uwaterloo.ca>
References: <48C1D2AE.3010001@feds.uwaterloo.ca> <20080906012941.GA2009@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Sep 07 16:24:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcLBR-000105-Q2
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 16:24:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbYIGOVW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 10:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbYIGOVW
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 10:21:22 -0400
Received: from mail.feds.uwaterloo.ca ([129.97.194.182]:3059 "EHLO
	mail.feds.uwaterloo.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919AbYIGOVV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 10:21:21 -0400
Received: from [192.168.0.13] (76-10-152-64.dsl.teksavvy.com [76.10.152.64])
	by mail.feds.uwaterloo.ca (Postfix) with ESMTP id F2E7855543;
	Sun,  7 Sep 2008 10:21:20 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.16 (X11/20080724)
In-Reply-To: <20080906012941.GA2009@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95144>

Jeff King wrote:
> On Fri, Sep 05, 2008 at 08:45:34PM -0400, Eric Gerlach wrote:
> 
>> I'm trying to test to see if "git diff --cached" will fail because there  
>> are no existing commits.  I've come up with running "git show-ref -h -q"  
>> and testing its return value.  My hypothesis is: If and only if  
>> git-show-ref succeeds then git-diff will succeed.
>>
>> Are my logic and assumptions sound?  I'm a bit out of my git comfort zone 
>> here, so I'd like to get some validation from some people who know  
>> better.
> 
> Maybe "git rev-parse --verify HEAD"?

That seems like it would work too... any reason one would be better than 
the other?

Cheers,

Eric Gerlach
