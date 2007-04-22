From: David Lang <david.lang@digitalinsight.com>
Subject: Re: [PATCH 4/4] Add 'filter' attribute and external filter 
 driverdefinition.
Date: Sun, 22 Apr 2007 13:27:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0704221327190.6340@qynat.qvtvafvgr.pbz>
References: <11771520591529-git-send-email-junkio@cox.net><"11771520591703-g
 i  t-send-email-junkio"@cox.net><7v4pn8rk8t.fsf@assigned-by-dhcp.cox.net><Pine
 .LNX.4.63.0704220202550.5946@qynat.qvtvafvgr.pbz>
 <alpine.LFD.0.98.0704221409390.28339@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sun Apr 22 23:02:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfjCb-0002o1-6M
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 23:02:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031014AbXDVVCN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 17:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031015AbXDVVCN
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 17:02:13 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:34005 "HELO
	warden.diginsite.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1031014AbXDVVCM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2007 17:02:12 -0400
Received: from wlvims02.diginsite.com by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Sun, 22 Apr 2007 14:02:11 -0700
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Sun, 22 Apr 2007 14:01:52 -0700
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <alpine.LFD.0.98.0704221409390.28339@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45275>

On Sun, 22 Apr 2007, Nicolas Pitre wrote:

> On Sun, 22 Apr 2007, David Lang wrote:
>
>> On Sat, 21 Apr 2007, Junio C Hamano wrote:
>>
>>>> 3. why specify seperate clean/smudge programs instead of just one
>>>> script with a read/write parameter?
>>>
>>> I think the most common two ways have clean as a cleaner and
>>> smudge as a no-op (similar to crlf=input conversion), or clean
>>> and smudge are inverse operations (similar to crlf=true
>>> conversion.  I do not see a sane case where clean and smudge are
>>> the same, unless you are thinking about the toy demonstration
>>> test piece I added to t0021 which uses rot13 as both clean and
>>> smudge filters.
>>
>> actually, I'm thinking of much more complicated filters, where it's easier to
>> have one program do both functions then it is to have two seperate programs
>> (like tar -c /tar -x)
>
> Just specify the same program in both entries with the appropriate
> parameter and be happy.
>
> It is much easier to have two entries with the same program than having
> only one entry when you actually have two separate programs.

agreed, this is why I said that this was a fairly minor thing.

David Lang
