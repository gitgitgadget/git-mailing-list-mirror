From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v6] Add new git-related helper to contrib
Date: Wed, 22 May 2013 18:19:19 -0500
Message-ID: <CAMP44s38=kQrCLOEuSmCqDYzCDic5SXaZN3rKY+4t3LXke11=g@mail.gmail.com>
References: <1368978823-18247-1-git-send-email-felipe.contreras@gmail.com>
	<7vr4gyizti.fsf@alter.siamese.dyndns.org>
	<CAMP44s0pXLmjVUwsVWiN2G5QReh80spXjvy_6GuUGRz1RmUbLQ@mail.gmail.com>
	<7vd2siiqsr.fsf@alter.siamese.dyndns.org>
	<CAMP44s2ETSxebGxXJV_BYEqTC5gJMVdQLbnTUomrie2rHhdmDg@mail.gmail.com>
	<7v8v36iq3e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 23 01:19:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfIJZ-0005yQ-HL
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 01:19:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754882Ab3EVXTV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 May 2013 19:19:21 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:43258 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754506Ab3EVXTV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 May 2013 19:19:21 -0400
Received: by mail-lb0-f175.google.com with SMTP id v10so2688329lbd.20
        for <git@vger.kernel.org>; Wed, 22 May 2013 16:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=DG7046opKAhw+zEZAUSIouIMazKtPXCD/WbhmxtLlQY=;
        b=z93iyzcEoELiewGZY1paZxUEduKJDjtMXDlAz7sHMJ3O3NsSGO0neJ+SWzh6HIOs7t
         Aue4rPL26roadmBiaGbq+vsMAijqU4ZVLcJGwvU2Yvqg0s9K9EEKQcDKpDHiIcUaI8fD
         atbStqBot7XZsGmOQDabr3X7uwroDV+4ll57DBQcGUlTWGMem1qPmZ3HEYntVqCWfo7o
         RxvMRxKSA29m/Zv8Yzmwk75uHlzUcDpeqeHzuI+fc8h+J4hHi5dN6jiuYCT8aDj0aiwa
         8S814edhcy8OPYVXA6yKgmPE6a6MW2xDVc4EVcqYSizdm7uKnqUejtrEwsRqO45pda+i
         YKQA==
X-Received: by 10.112.142.8 with SMTP id rs8mr4410679lbb.8.1369264759808; Wed,
 22 May 2013 16:19:19 -0700 (PDT)
Received: by 10.114.174.170 with HTTP; Wed, 22 May 2013 16:19:19 -0700 (PDT)
In-Reply-To: <7v8v36iq3e.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225204>

On Wed, May 22, 2013 at 5:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Wed, May 22, 2013 at 5:38 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> ...
>>> As I already said in the above, the answer is no, when you are
>>> trying to find who moved the code from the original place.
>>
>> But I'm not trying to find who moved the code, I'm trying to find
>> related commits; hence the name 'git related'.
>>
>> The person who moved the code will be on the list regardless,
>
> That is exactly the point I have been trying to raise.  Does the
> person appear in the list when you run blame with -CCC?  You ask for
> the body of the function, and the -C mode of blame sees through the
> block-of-line movement across file boundaries, and goes straight to
> the last commit that touched the body of the function in its original
> file, no?

I'm not familiar how the different -C options work, but I'm testing
right now and I see the commit that moved a file with both -C and
-CCC, but strangely enough, not if it's the previous commit (with
both).

-- 
Felipe Contreras
