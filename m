From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [ANNOUNCE] tig-0.14
Date: Tue, 10 Feb 2009 16:18:00 -0500
Message-ID: <F48CDFE6-4402-49F5-8716-B8D9C40DD201@silverinsanity.com>
References: <20090205204436.GA6072@diku.dk> <4991814A.6050803@tedpavlic.com> <2c6b72b30902101029s72628a88n16473ee30f853198@mail.gmail.com> <6BA2725C-2127-48BE-871E-7449A507CCD8@silverinsanity.com> <d4bc1a2a0902101129y22224c89y144b223e7d7dd463@mail.gmail.com> <2c6b72b30902101241p67a0e1e9u60c8033c4a03260c@mail.gmail.com> <3902F3BD-6EE5-4896-9E96-C4A1C4B6E9AF@silverinsanity.com> <2c6b72b30902101313r5dcea490s3bc72d404a98997f@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Stefan Karpinski <stefan.karpinski@gmail.com>,
	Ted Pavlic <ted@tedpavlic.com>, git <git@vger.kernel.org>
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Tue Feb 10 22:19:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LX00y-0000s5-Rg
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 22:19:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755272AbZBJVSH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 16:18:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754749AbZBJVSE
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 16:18:04 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:34911 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754562AbZBJVSE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 16:18:04 -0500
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 14E591FFC281; Tue, 10 Feb 2009 21:17:56 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb3 (2006-10-05) on 
	silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=4.0 tests=AWL,BAYES_00,RCVD_IN_PBL,
	RCVD_IN_SORBS_DUL autolearn=no version=3.1.7-deb3
Received: from [192.168.1.115] (cpe-74-74-137-205.rochester.res.rr.com [74.74.137.205])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 70B251FFC273;
	Tue, 10 Feb 2009 21:17:55 +0000 (UTC)
In-Reply-To: <2c6b72b30902101313r5dcea490s3bc72d404a98997f@mail.gmail.com>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109311>


On Feb 10, 2009, at 4:13 PM, Jonas Fonseca wrote:

> On Tue, Feb 10, 2009 at 21:49, Brian Gernhardt <benji@silverinsanity.com 
> > wrote:
>> That fixes half the problem.  It no longer leaves a highlight on  
>> the wrong
>> line, but the newly selected line does not highlight the empty  
>> space at the
>> end of the line.
>
> I believe the empty space is the cursor, but I am not sure. At least
> tig-0.14 should be more consistent regarding the cursor position,
> which is now always placed at the end of the selected line, except
> when the input prompt is in use.

That's not what I'm referring to.  I mean that if there's a line that  
does not take the entire width of the screen, the space from the end  
of the text to the end of the screen is black.
