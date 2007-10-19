From: Michael Witten <mfwitten@MIT.EDU>
Subject: Re: Proposed git mv behavioral change
Date: Thu, 18 Oct 2007 23:40:47 -0400
Message-ID: <93BF5798-F1C3-48EE-8233-A0F111BF8138@MIT.EDU>
References: <c594999b2337.2337c594999b@nyroc.rr.com> <20071019015419.GV14735@spearce.org> <A2C1BF08-4CC8-4F98-9CA8-B81B2FBFE9E4@mit.edu> <20071019031959.GE14735@spearce.org> <20071019032407.GA10622@coredump.intra.peff.net> <7E3647F4-E61C-4FBE-9AA7-81CDBE324308@MIT.EDU> <20071019033500.GB10697@coredump.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 19 05:41:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiijS-0001hi-Mr
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 05:41:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965625AbXJSDkz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 23:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965558AbXJSDkz
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 23:40:55 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:40459 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965605AbXJSDkz (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Oct 2007 23:40:55 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id l9J3envg009661;
	Thu, 18 Oct 2007 23:40:49 -0400 (EDT)
Received: from [18.239.2.43] (WITTEN.MIT.EDU [18.239.2.43])
	(authenticated bits=0)
        (User authenticated as mfwitten@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id l9J3emL8007282
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 18 Oct 2007 23:40:49 -0400 (EDT)
In-Reply-To: <20071019033500.GB10697@coredump.intra.peff.net>
X-Mailer: Apple Mail (2.752.2)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61636>


On 18 Oct 2007, at 11:35:00 PM, Jeff King wrote:

> Right, I mean regular "mv", not "git-mv". The only thing that doesn't
> accomplish is moving the "from" entry in the index to the "to" entry
> (but I'm not sure that's such a good idea).  Perhaps I've lost  
> sight of
> your original goal. Can you state more succintly what you are  
> trying to
> accomplish?

I think you're right.

Anyway, succinctly:

> What you want to happen is the following:
> 	
> 	git show HEAD:A.txt > path/B.txt
> 	git add path/B.txt
> 	mv A.txt B.txt
> 	git rm A.txt

Better:

>  	mv A.txt path/B.txt
> 	Point the index entry for A.txt to path/B.txt

I hope that's right.
