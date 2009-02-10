From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [ANNOUNCE] tig-0.14
Date: Tue, 10 Feb 2009 15:49:54 -0500
Message-ID: <3902F3BD-6EE5-4896-9E96-C4A1C4B6E9AF@silverinsanity.com>
References: <20090205204436.GA6072@diku.dk> <4991814A.6050803@tedpavlic.com> <2c6b72b30902101029s72628a88n16473ee30f853198@mail.gmail.com> <6BA2725C-2127-48BE-871E-7449A507CCD8@silverinsanity.com> <d4bc1a2a0902101129y22224c89y144b223e7d7dd463@mail.gmail.com> <2c6b72b30902101241p67a0e1e9u60c8033c4a03260c@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Stefan Karpinski <stefan.karpinski@gmail.com>,
	Ted Pavlic <ted@tedpavlic.com>, git <git@vger.kernel.org>
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Tue Feb 10 21:51:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWzZm-0006F0-FH
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 21:51:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755277AbZBJUt7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 15:49:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754729AbZBJUt6
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 15:49:58 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:33680 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754072AbZBJUt6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 15:49:58 -0500
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 8994A1FFC281; Tue, 10 Feb 2009 20:49:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb3 (2006-10-05) on 
	silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=4.0 tests=AWL,BAYES_00,RCVD_IN_PBL,
	RCVD_IN_SORBS_DUL autolearn=no version=3.1.7-deb3
Received: from [192.168.1.115] (cpe-74-74-137-205.rochester.res.rr.com [74.74.137.205])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id A55111FFC273;
	Tue, 10 Feb 2009 20:49:49 +0000 (UTC)
In-Reply-To: <2c6b72b30902101241p67a0e1e9u60c8033c4a03260c@mail.gmail.com>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109307>


On Feb 10, 2009, at 3:41 PM, Jonas Fonseca wrote:

> On Tue, Feb 10, 2009 at 20:29, Stefan Karpinski
> <stefan.karpinski@gmail.com> wrote:
>> On Tue, Feb 10, 2009 at 11:07 AM, Brian Gernhardt
>> <benji@silverinsanity.com> wrote:
>>>
>>> OS 10.5.6's Terminal.app, with TERM=xterm-color
>>> I have no .tigrc
>>
>> Ditto. Same bug. Completely vanilla tig setup. OS X Leopard,
>> tig-0.14-9-gd06137e, TERM=xterm-color.
>
> Looks like there might be a pattern and I might have an excuse to go
> knock on the door of one of my "Mac" friends. ;) However, first I
> would kindly ask if one of you have time to test the attached patch.

That fixes half the problem.  It no longer leaves a highlight on the  
wrong line, but the newly selected line does not highlight the empty  
space at the end of the line.
