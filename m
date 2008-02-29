From: Paul Franz <thefranz@comcast.net>
Subject: Re: [PATCH 22/40] Windows: Implement asynchronous functions as threads.
Date: Fri, 29 Feb 2008 06:45:29 -0500
Message-ID: <47C7F059.8070307@comcast.net>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at> <1204138503-6126-23-git-send-email-johannes.sixt@telecom.at> <alpine.LSU.1.00.0802281525510.22527@racer.site> <47C6F40A.4010703@comcast.net> <alpine.LSU.1.00.0802290122110.22527@racer.site> <47C76407.3090804@comcast.net> <alpine.LSU.1.00.0802290150440.22527@racer.site> <47C77720.2080405@comcast.net> <7v7igodwth.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 29 12:46:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JV3h5-0002Fr-1l
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 12:46:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752538AbYB2Lpu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 06:45:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750963AbYB2Lpu
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 06:45:50 -0500
Received: from qmta08.westchester.pa.mail.comcast.net ([76.96.62.80]:45034
	"EHLO QMTA08.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750823AbYB2Lpt (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Feb 2008 06:45:49 -0500
Received: from OMTA13.westchester.pa.mail.comcast.net ([76.96.62.52])
	by QMTA08.westchester.pa.mail.comcast.net with comcast
	id vPDr1Y00317dt5G5801u00; Fri, 29 Feb 2008 11:45:20 +0000
Received: from paul-franz-laptop.local ([148.87.66.58])
	by OMTA13.westchester.pa.mail.comcast.net with comcast
	id vPlW1Y0011FR7Jk3Z00000; Fri, 29 Feb 2008 11:45:46 +0000
X-Authority-Analysis: v=1.0 c=1 a=jYeb2YJqOk4A:10 a=VwQbUJbxAAAA:8
 a=oxv6u1hbRThV4WqfxjMA:9 a=PxLi1XZGBdPcUlbN15UA:7
 a=g7XgKrIzQ_F7V5a4umAo1oMCbZUA:4 a=si9q_4b84H0A:10 a=c5zHXd76wwQA:10
User-Agent: Thunderbird 2.0.0.12 (Macintosh/20080213)
In-Reply-To: <7v7igodwth.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75524>



Junio C Hamano wrote:
> Paul Franz <thefranz@comcast.net> writes:
>
>   
>> Johannes Schindelin wrote:
>>     
>>> Hi,
>>>
>>> [top-posting?]
>>>       
>> Is there something wrong with it?
>>     
>
> Yes.  Please do not do it.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>   
Thanks. Noted for future reference.

-- 

-------------------------------------------

There are seven sins in the world.
     Wealth without work.
     Pleasure without conscience.
     Knowledge without character.
     Commerce without morality.
     Science without humanity.
     Worship without sacrifice.
     Politics without principle.

   -- Mohandas Gandhi

-------------------------------------------

