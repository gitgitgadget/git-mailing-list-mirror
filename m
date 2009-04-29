From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] gitweb: escape searchtext and parameters for replay
Date: Wed, 29 Apr 2009 22:07:07 +0200
Message-ID: <49F8B36B.6040505@drmicha.warpmail.net>
References: <337ECD47-D343-40F2-9E41-9E7D8531C5DF@aepfle.de> <0626233F-50D5-4F7E-9009-506FEA77571D@aepfle.de> <200904291514.11331.jnareb@gmail.com> <200904292136.36987.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Olaf Hering <olaf@aepfle.de>, git@vger.kernel.org,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 22:07:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzG3q-0000dS-6A
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 22:07:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753691AbZD2UHL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 16:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752408AbZD2UHK
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 16:07:10 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:44126 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751929AbZD2UHI (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Apr 2009 16:07:08 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 97D403361C0;
	Wed, 29 Apr 2009 16:07:08 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 29 Apr 2009 16:07:08 -0400
X-Sasl-enc: 1eJfn+mgJ07rZfExmbu6QE8Jtm4r9E/qPebvSHq+/hGa 1241035628
Received: from localhost.localdomain (p5DCC1814.dip0.t-ipconnect.de [93.204.24.20])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 759232D185;
	Wed, 29 Apr 2009 16:07:07 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b5pre) Gecko/20090427 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <200904292136.36987.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117935>

Jakub Narebski venit, vidit, dixit 29.04.2009 21:36:
> On Wed, 29 Apr 2009, Jakub Narebski wrote:
>> On Wed, 29 Apr 2009, Olaf Hering wrote:
>>> Am 29.04.2009 um 14:28 schrieb Jakub Narebski: 
>>>> On Wed, 29 April 2009, Michael J Gruber wrote:
>>>>>>
>>>>>> It should be s=torvalds%40linux instead of s=torvalds\@linux
>>>>
>>>> If you by hand edit URL changing '\@' to simply '@', does changed
>>>> gitweb URL works correctly?
>>>
>>> I tried akpm@osdl.org, and @ and . was escaped with a backslash.
>>> Removing both, and using the plain mail address worked.
>>
>> This problem was fixed in 7e431ef (gitweb: Separate search regexp from 
>> search text), but this fix is present in git 1.5.2 and later,
> 
> I have just checked that current gitweb (1.6.2.rc1.20.g8c5b)
> does not have this bug...

Yes, I should have tested before suggesting a patch blindly. Sorry!

> 
>> and kernel.org gitweb is a fork (adding caching mechanism) of
>> 1.4.5-rc0 (according to info in git.kernel.org HTML source), and
>> it does not have this fix.
>>
>>   http://git.kernel.org/?p=git/warthog9/gitweb.git;a=summary
>>
>> I have CC-ed J.H. on this.
> 
> ... so J.H., or Lea Wiemann, or whoever manages gitweb on kernel.org
> should backport this fix to kernel.org's fork of gitweb sources.
> 
