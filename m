From: david@lang.hm
Subject: Re: Google Summer of Code 2009: GIT
Date: Thu, 12 Mar 2009 11:25:11 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0903121110400.16753@asgard.lang.hm>
References: <49B74373.3090609@gmail.com>  <alpine.DEB.1.00.0903111255470.10279@pacific.mpi-cbg.de>  <ab9fa62a0903110511u63e7d46dr3bb783ee891ca4ae@mail.gmail.com>  <alpine.DEB.1.00.0903111353340.10498@intel-tinevez-2-302>  <ab9fa62a0903110655y4a47ccfkde0984ecb46b3307@mail.gmail.com>
  <alpine.DEB.1.00.0903111458340.10498@intel-tinevez-2-302> <ab9fa62a0903110713k2a21cefbj1e7cd3c126aca8f9@mail.gmail.com> <alpine.LNX.1.00.0903111159530.19665@iabervon.org> <alpine.DEB.1.00.0903111742360.10498@intel-tinevez-2-302> <49B90683.1060501@drmicha.warpmail.net>
 <alpine.DEB.1.00.0903121407070.6335@intel-tinevez-2-302> <49B90AE4.9030904@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	saurabh gupta <saurabhgupta1403@gmail.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Mar 12 19:27:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhpcT-0002Uz-QH
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 19:27:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755277AbZCLSZ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 14:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755195AbZCLSZ1
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 14:25:27 -0400
Received: from mail.lang.hm ([64.81.33.126]:38883 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754769AbZCLSZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 14:25:26 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id n2CIPBf5017065;
	Thu, 12 Mar 2009 10:25:12 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <49B90AE4.9030904@drmicha.warpmail.net>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113101>

On Thu, 12 Mar 2009, Michael J Gruber wrote:

> Johannes Schindelin venit, vidit, dixit 12.03.2009 14:07:
>> Hi,
>>
>> On Thu, 12 Mar 2009, Michael J Gruber wrote:
>>
>>> Johannes Schindelin venit, vidit, dixit 11.03.2009 17:44:
>>>
>>>> On Wed, 11 Mar 2009, Daniel Barkalow wrote:
>>>>
>>>>> One thing that I think would be good whenever possible is to have the
>>>>> merge program generate a file in the same format which is easily
>>>>> recognizable as having conflict markers. For example, I think it
>>>>> should be possible to show conflicts in the text of office documents
>>>>> by having styles for each side of the merge, and show each side's
>>>>> content in the appropriate style. Then the user opens the document
>>>>> with their choice of office software, finds the things in the
>>>>> conflict styles, and decides what the result should be.
>>>> That's a very good idea!  (Except for LaTeX, maybe...)
>>> latexdiff (in perl) may give you a head start (or ache, I dunno).
>> No.  latexdiff is about diffing.  It does nothing to help me resolve a
>> conflict.
>
> Sure. If you want to merge you have to diff first (and display it). That
> would be the "head start". Then you have to think about the merge.
> That's where the "head ache" kicks in...

the idea is that the merge driver should do the diff and merge the simple 
things, only needing to display it if there is a conflict that it cannot 
resolve.

David Lang
