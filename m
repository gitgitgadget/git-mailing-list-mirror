From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH] mailmap: resurrect lower-casing of email addresses
Date: Fri, 03 Apr 2009 21:32:56 -0400
Message-ID: <49D6B8C8.8090304@gmail.com>
References: <cover.1238458535u.git.johannes.schindelin@gmx.de> <f182fb1700e8dea15459fd02ced2a6e5797bec99.1238458535u.git.johannes.schindelin@gmx.de> <49D53ABF.80706@gmail.com> <alpine.DEB.1.00.0904030039290.10279@pacific.mpi-cbg.de> <7v63hmekyv.fsf@gitster.siamese.dyndns.org> <49D542FA.3070304@gmail.com> <alpine.DEB.1.00.0904030107320.10279@pacific.mpi-cbg.de> <49D54799.9010607@gmail.com> <alpine.DEB.1.00.0904030447480.10279@pacific.mpi-cbg.de>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Apr 04 03:34:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lpumc-0001dG-Pk
	for gcvg-git-2@gmane.org; Sat, 04 Apr 2009 03:34:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763283AbZDDBdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2009 21:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761291AbZDDBdK
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Apr 2009 21:33:10 -0400
Received: from an-out-0708.google.com ([209.85.132.241]:55827 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937270AbZDDBdJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2009 21:33:09 -0400
Received: by an-out-0708.google.com with SMTP id d14so1060023and.1
        for <git@vger.kernel.org>; Fri, 03 Apr 2009 18:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=Nskwp4e8Lcd0SQC2BibC4vJGXJoZIR5Qt1zG7PqFaEY=;
        b=r4c/PQpzgoo26kYvKMEoLodzzV7mKYhm8f9PwdM2cfP8oFN6B7Q4AQ6wrqx1qshBxf
         cYbBOlHJ1yUPXDebpjgo2UjAQL4eqKumCjk8obO+glLmuOGUBIKmyzEQwqwk8XbWDuzO
         IZQG1Ia+i9Ea9nN0TxC3U1VYG9IBR4DZb8f7k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=ume67+9VxP7H3JisMg5SbbP3zCik2jfUVbO9F7rFCYLmTxKviFIhEI1cQ0xB64RECc
         cHd3TBo2FwTIOwR2HC1mPjTn2g8SY/7vTzvBbB0nUhMittTYlXo5NQdVeWu4gkujSSmT
         24PKlSPjroFmA5MTPqo06dCNRri04l+BHlsNE=
Received: by 10.100.119.17 with SMTP id r17mr2850194anc.143.1238808786719;
        Fri, 03 Apr 2009 18:33:06 -0700 (PDT)
Received: from ?10.0.0.6? (c-66-177-19-100.hsd1.fl.comcast.net [66.177.19.100])
        by mx.google.com with ESMTPS id c9sm295053ana.5.2009.04.03.18.33.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 03 Apr 2009 18:33:06 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <alpine.DEB.1.00.0904030447480.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115567>

Johannes Schindelin wrote:
> Hi,
> 
> On Thu, 2 Apr 2009, A Large Angry SCM wrote:
> 
>> Johannes Schindelin wrote:
>>
>>> On Thu, 2 Apr 2009, A Large Angry SCM wrote:
>>>
>>>> Junio C Hamano wrote:
>>>>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>>>>
>>>>>>> What part of the email address is this going to lowercase? 
>>>>>>> Only the domain name is case agnostic.
>>>>> That is my understanding of RFC, too.  Let's see where this mail 
>>>>> goes to find out how much more lenient the real world is ;-).
>>>>>
>>>> Many email providers/servers are lenient when it comes to case in 
>>>> the local part of an email address (after all, they control the 
>>>> interpretation) but not every provider/server is and the RFC is VERY 
>>>> clear on this issue.
>>> And in one of my projects it is _very_ clear that this strict 
>>> interpretation of the RFC, which does not matter in reality, 
>>> _actively_ _hurts_.
>> Care to provide actual justification for that statement.
> 
> Well, I _did_!  I have at least _one_ repository where the case 
> insensitive email addresses worked, and got fscked over, by having Git 
> change behavior behind my back!
> 
>>> In the alternative, can I ask you to adjust my .mailmap in your free 
>>> time?
>> _Your_ .mailmap file is your issue.
>>
>> So which standards do you choose to follow and which do you choose to 
>> ignore?
> 
> You chose a rather inappropriate moment to start one of those damned 
> flamewars -- I am in the middle of some rather important day-job meeting, 
> plus two projects in the deadline-is-looming GSoC frenzy.
> 
> In case it was not clear yet: if I have to chose between following a 
> standard and reality that just took over, I will _always_ choose the 
> latter.
> 
> If you take this mail to start a flamewar for real (i.e. not answer to my 
> concerns, but point out that standard X says bla, and that everybody else 
> should just obey, oh, and fix their ways as of 20 years), please do remove 
> me from the Cc: list.
> 
> Ciao,
> Dscho
> )
> 

Sorry, this is not a flame war (and as Peff already sent a response that 
superior to my own) so I'll let Junio decide.

However, to keep the peace (and as a thank you for all the hard work to 
date, I'll say that I'm scheduled to be be Germany and Munich the first 
10 days in October and I'll buy the first $100 dollars in drinks at any 
meet that participate in (as a thank you to all the hard work for git 
that has been performed) that may happen that I participate in).
