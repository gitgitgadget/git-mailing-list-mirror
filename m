From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Re: Use case I don't know how to address
Date: Sun, 06 Sep 2009 13:44:17 +0100
Message-ID: <4AA3AEA1.7030107@chandlerfamily.org.uk>
References: <4AA20CEC.8060408@chandlerfamily.org.uk> <7vk50ccxfj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Mon Sep 07 02:14:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkRsM-0003MW-2f
	for gcvg-git-2@lo.gmane.org; Mon, 07 Sep 2009 02:14:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758317AbZIGANT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Sep 2009 20:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758314AbZIGANT
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Sep 2009 20:13:19 -0400
Received: from smtp-out4.blueyonder.co.uk ([195.188.213.7]:42691 "EHLO
	smtp-out4.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758308AbZIGANS (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Sep 2009 20:13:18 -0400
Received: from [172.23.170.147] (helo=anti-virus03-10)
	by smtp-out4.blueyonder.co.uk with smtp (Exim 4.52)
	id 1MkH6R-00042R-Th
	for git@vger.kernel.org; Sun, 06 Sep 2009 13:44:19 +0100
Received: from [77.103.217.152] (helo=wol.chandlerfamily.org.uk)
	by asmtp-out5.blueyonder.co.uk with esmtp (Exim 4.52)
	id 1MkH6Q-0003CB-C3
	for git@vger.kernel.org; Sun, 06 Sep 2009 13:44:18 +0100
Received: from kanga.local ([192.168.0.30])
	by wol.chandlerfamily.org.uk with esmtp (Exim 4.69)
	(envelope-from <alan@chandlerfamily.org.uk>)
	id 1MkH6P-0006V7-Vl
	for git@vger.kernel.org; Sun, 06 Sep 2009 13:44:18 +0100
User-Agent: Mozilla-Thunderbird 2.0.0.22 (X11/20090701)
In-Reply-To: <7vk50ccxfj.fsf@alter.siamese.dyndns.org>
X-SA-Exim-Connect-IP: 192.168.0.30
X-SA-Exim-Mail-From: alan@chandlerfamily.org.uk
X-SA-Exim-Scanned: No (on wol.chandlerfamily.org.uk); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127877>

Junio C Hamano wrote:
> Alan Chandler <alan@chandlerfamily.org.uk> writes:
> 
>>        2' - 2a - 3' - 4' ----------------- 6' SITE
>>       /         /    /                    /
>> 1 -  2  ------ 3  - 4  ------------6'''- 6a TEST
>>                      \            /
>>                        5  ------ 6  MASTER
>>                         \         \
>>                           5''- 5a- 6'' DEMO
>>
>>
>> What will happen is the changes made in 4->5 will get applied to the
>> (now) Test branch as part of the 6->6'' merge, and I will be left
>> having to add a new commit, 6a, to undo them all again.  Given this is
>> likely to be quite a substantial change I want to try and avoid it if
>> possible.
> 
> I presume 6'''-6a has the revert of 4-5?  If so, the next merge should
> work just fine.


I think you missed the issue - Yes 6'''-6a is the revert, but the 
problem is this could be large and complicated, and I wanted to find an 
automated way rather than manual

Sort of like doing a diff of 4-5 and somehow applying it backwards.


-- 
Alan Chandler
http://www.chandlerfamily.org.uk
