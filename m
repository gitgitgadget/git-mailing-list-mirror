From: Rogan Dawes <lists@dawes.za.net>
Subject: Re: git and linux kernel source
Date: Mon, 13 Aug 2007 17:32:42 +0200
Message-ID: <46C0799A.3090707@dawes.za.net>
References: <1186701106.3073.71.camel@localhost> <20070809231718.GH12875@fieldses.org> <20070813152714.GF3122@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Joe Perches <joe@perches.com>, git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Mon Aug 13 17:33:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKbv8-0002rf-DU
	for gcvg-git@gmane.org; Mon, 13 Aug 2007 17:33:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S942091AbXHMPdU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Aug 2007 11:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933211AbXHMPdT
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Aug 2007 11:33:19 -0400
Received: from sd-green-bigip-145.dreamhost.com ([208.97.132.145]:50999 "EHLO
	spunkymail-a12.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S945188AbXHMPdO (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Aug 2007 11:33:14 -0400
Received: from [192.168.201.102] (dsl-146-25-95.telkomadsl.co.za [165.146.25.95])
	by spunkymail-a12.g.dreamhost.com (Postfix) with ESMTP id 43B577FB3;
	Mon, 13 Aug 2007 08:33:07 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20070813152714.GF3122@fieldses.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55767>

J. Bruce Fields wrote:
> On Thu, Aug 09, 2007 at 07:17:18PM -0400, bfields wrote:
>> On Thu, Aug 09, 2007 at 04:11:46PM -0700, Joe Perches wrote:
>>> A few linux kernel source and git questions:
>>>
>>> What's the best procedure to handle a tree-wide source tranformation?
>>> For instance:
>>>
>>>   git branch foo2bar
>>>   egrep -r -w --include=*.[ch] -l "foo" * | \
>>> 	xargs perl -pi -e 's/\bfoo\b/bar/msg'
>>>   git commit -a -m "use bar not foo"
>>
>>> Is there a way to separate the resultant single patch into multiple
>>> patches by subdirectory?  Perhaps some git-rev-parse option?
>> Something like
>>
>> 	for each sub/dir:
>> 		git add sub/dir
>> 		git commit -m "use bar not foo in sub/dir"
>>
>> should do it.  (Of course, in the particular case above the patches you
>> ended up with probably wouldn't compile individually.)
> 
> OK, now I feel like I have to ask--you're not seriously considering
> doing anything like that, are you?
> 
> --b.

Have you seen LKML recently? Maybe that will answer your question. (A 
500+ patch mail bomb . . .)

Rogan
