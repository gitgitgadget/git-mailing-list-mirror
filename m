From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH] mailmap: resurrect lower-casing of email addresses
Date: Fri, 03 Apr 2009 21:51:42 -0400
Message-ID: <49D6BD2E.2030208@gmail.com>
References: <cover.1238458535u.git.johannes.schindelin@gmx.de> <f182fb1700e8dea15459fd02ced2a6e5797bec99.1238458535u.git.johannes.schindelin@gmx.de> <49D53ABF.80706@gmail.com> <alpine.DEB.1.00.0904030039290.10279@pacific.mpi-cbg.de> <7v63hmekyv.fsf@gitster.siamese.dyndns.org> <49D542FA.3070304@gmail.com> <alpine.DEB.1.00.0904030107320.10279@pacific.mpi-cbg.de> <49D54799.9010607@gmail.com> <alpine.DEB.1.00.0904030447480.10279@pacific.mpi-cbg.de>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Apr 04 03:53:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lpv4T-0004Nx-Bw
	for gcvg-git-2@gmane.org; Sat, 04 Apr 2009 03:53:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764306AbZDDBvu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2009 21:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763636AbZDDBvt
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Apr 2009 21:51:49 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:27981 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754349AbZDDBvs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2009 21:51:48 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1260215ywb.1
        for <git@vger.kernel.org>; Fri, 03 Apr 2009 18:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=Pqt7tWXxpvD5dokfm87c8qkT1UIX9tenNDpZqi4KaRs=;
        b=L+hCEDtBxgqESmZJPVx6kzY3nRkgmzN7ePCoMxI0k9DLf5ATW5C09t4O/WKPmFkdKF
         0k+vAiTa7H1o2OwRy4xQ2h1cTu/MfeIkhxQPwgWHbmUpODjQRW9e0j6v3UWVJSBQS3FB
         yORNs1WZ7tXsvZEoYC8vG4ltyWDD7FX07l03Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=ClM8HqYZAcSKj9Ac1AU7aJA/rE7kue8vAXjHJsClxaEViguTmWzD4ADewL7wIoFOLZ
         +RuGD0sEuO5m1lU8YWXwFGMe3Xex37kD8OJbirumuMkRbUkFuHgu7lbYXTun7eOzy94J
         IXcfhLtanr3dixXzLCzSbqnEOro5MuX4GD+ok=
Received: by 10.90.66.14 with SMTP id o14mr1114253aga.43.1238809905502;
        Fri, 03 Apr 2009 18:51:45 -0700 (PDT)
Received: from ?10.0.0.6? (c-66-177-19-100.hsd1.fl.comcast.net [66.177.19.100])
        by mx.google.com with ESMTPS id 38sm3583850aga.29.2009.04.03.18.51.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 03 Apr 2009 18:51:45 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <alpine.DEB.1.00.0904030447480.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115569>

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

This is not worth a flame-war, and Peff has already created a response 
superior to my own, so I'll leave to Junio to find the best(TM) path.
