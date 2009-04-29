From: "J.H." <warthog19@eaglescrag.net>
Subject: Re: [PATCH] gitweb: escape searchtext and parameters for replay
Date: Wed, 29 Apr 2009 16:11:48 -0700
Message-ID: <49F8DEB4.40909@eaglescrag.net>
References: <337ECD47-D343-40F2-9E41-9E7D8531C5DF@aepfle.de> <0626233F-50D5-4F7E-9009-506FEA77571D@aepfle.de> <200904291514.11331.jnareb@gmail.com> <200904292136.36987.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Olaf Hering <olaf@aepfle.de>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 01:20:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzJ4i-0000tS-GL
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 01:20:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753930AbZD2XUP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 19:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752922AbZD2XUO
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 19:20:14 -0400
Received: from shards.monkeyblade.net ([198.137.202.13]:43852 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752647AbZD2XUN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 19:20:13 -0400
X-Greylist: delayed 447 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Apr 2009 19:20:13 EDT
Received: from [172.19.0.11] (c-67-164-31-53.hsd1.ca.comcast.net [67.164.31.53])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.1/8.14.1) with ESMTP id n3TNBolV010991
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 29 Apr 2009 16:11:50 -0700
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <200904292136.36987.jnareb@gmail.com>
X-Virus-Scanned: ClamAV 0.88.7/9305/Wed Apr 29 06:43:01 2009 on shards.monkeyblade.net
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.1.1 (shards.monkeyblade.net [198.137.202.13]); Wed, 29 Apr 2009 16:11:51 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117976>

Jakub Narebski wrote:
> On Wed, 29 Apr 2009, Jakub Narebski wrote:
>> On Wed, 29 Apr 2009, Olaf Hering wrote:
>>> Am 29.04.2009 um 14:28 schrieb Jakub Narebski: 
>>>> On Wed, 29 April 2009, Michael J Gruber wrote:
>>>>>> It should be s=torvalds%40linux instead of s=torvalds\@linux
>>>> If you by hand edit URL changing '\@' to simply '@', does changed
>>>> gitweb URL works correctly?
>>> I tried akpm@osdl.org, and @ and . was escaped with a backslash.
>>> Removing both, and using the plain mail address worked.
>> This problem was fixed in 7e431ef (gitweb: Separate search regexp from 
>> search text), but this fix is present in git 1.5.2 and later,
> 
> I have just checked that current gitweb (1.6.2.rc1.20.g8c5b)
> does not have this bug...
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

Patches, as always, are welcome - I've got a few queued up already, but 
if I have to do it I won't be getting back around to it for a bit (there 
are other things on my priority list right now).

- John "Warthog9" Hawley
