From: Markus Amsler <markus.amsler@oribi.org>
Subject: Re: [PATCH] git-imap-send: Strip smtp From_ header from imap message.
Date: Wed, 18 Oct 2006 13:54:14 +0200
Message-ID: <453615E6.4090008@oribi.org>
References: <452EBF77.7040301@oribi.org>	<7vlknegnwk.fsf@assigned-by-dhcp.cox.net>	<45367A5F.7060507@codeweavers.com> <7vejt53olg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mike McCormack <mike@codeweavers.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 14:00:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaA5t-0005NG-Nm
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 14:00:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbWJRMAK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 08:00:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbWJRMAK
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 08:00:10 -0400
Received: from fix-cable-customer.128.177.162.195.yetnet.ch ([195.162.177.128]:16599
	"EHLO khufu") by vger.kernel.org with ESMTP id S1751379AbWJRMAI
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Oct 2006 08:00:08 -0400
Received: from [192.168.67.232] (helo=[192.168.67.232])
	by khufu with esmtp (Exim 4.50)
	id 1GaA2s-0004TY-Uk; Wed, 18 Oct 2006 13:57:15 +0200
User-Agent: Thunderbird 1.5.0.7 (X11/20060927)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vejt53olg.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29226>

Junio C Hamano wrote:
> Mike McCormack <mike@codeweavers.com> writes:
> 
>> Junio C Hamano wrote:
>>> Markus Amsler <markus.amsler@oribi.org> writes:
>>>
>>>> Cyrus imap refuses messages with a 'From ' Header.
>>>>
>>>> Signed-off-by: Markus Amsler <markus.amsler@oribi.org>
>>> Do you know if this change does not upset other implementations
>>> of imap servers?
>>>
>>> Mike, are you Ok with this change?
>> Works for me with Courier IMAP.  I'm no expert on mail headers either,
>> so no objections from me.
>>
>> Mike
> 
> Thanks; then will apply.
> 
> By the way, Markus, did you send the patch with imap-send?  It
> had a funny whitespace corruptions.
No, I was too lazy to set up an imap config for one patch. So I used git 
diff an copy pasted it into Thunderbird. Sorry.

Markus
