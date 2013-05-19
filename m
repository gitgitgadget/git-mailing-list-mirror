From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v5 01/15] Add new git-related helper to contrib
Date: Sun, 19 May 2013 10:48:57 -0500
Message-ID: <CAMP44s34uDwZiFiy7cno_3M+_QB2zweGsuwvpYQ6p4O_Ct3CZA@mail.gmail.com>
References: <1368877615-9563-1-git-send-email-felipe.contreras@gmail.com>
	<1368877615-9563-2-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0ke-Ns0JCt6LAzWqympWZ=2x3rRHOjnzB9QN7gc2=ckgw@mail.gmail.com>
	<CAMP44s1xguzX=iavUJxYXBEPOpGvJtJ_7FDHNCWMrF6qxOsuOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 19 17:49:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ue5r5-0003ek-AH
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 17:49:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228Ab3ESPs7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 11:48:59 -0400
Received: from mail-lb0-f171.google.com ([209.85.217.171]:62915 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751098Ab3ESPs6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 May 2013 11:48:58 -0400
Received: by mail-lb0-f171.google.com with SMTP id v20so5750834lbc.2
        for <git@vger.kernel.org>; Sun, 19 May 2013 08:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=BKNai3f6GE+HSP3YFTGkyVoQOMVtcmb7s1vA+KHPVIk=;
        b=tQQUB2lDR8Fw4gTFurg1eOWH1Eae2+P8tXHzS6ZkGZSbFTj8JDWKe7SIhd18ybjMQP
         YB4ruKkMArZbOn4kfznQgNHcOIxfuWb1So/aHJGGwsrUtik5UO2P0l0bKgcbRSWhrqml
         6wOP8SaaVJ0PPOCxfeGbYy3DvaWEtrO1moigNBjbXOnQd3vQ/0BFDmIsUkM/X2jgTtv3
         cy/RIXP2AHwyjV7zI+82KeHDZfv8brFLAmk4ydGaLMCt5ezd7qvx1C11lIAoUBu30Xyo
         0mKTQ8kk2WENvM9teuGzE5dqMlUt+eFGJ8ZKzkY/kp7NCOGfHbPzkkSNK9oOudFRHamv
         x/Xw==
X-Received: by 10.152.19.39 with SMTP id b7mr5302797lae.38.1368978537090; Sun,
 19 May 2013 08:48:57 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Sun, 19 May 2013 08:48:57 -0700 (PDT)
In-Reply-To: <CAMP44s1xguzX=iavUJxYXBEPOpGvJtJ_7FDHNCWMrF6qxOsuOQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224895>

On Sun, May 19, 2013 at 10:05 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Sun, May 19, 2013 at 9:40 AM, Ramkumar Ramachandra
> <artagnon@gmail.com> wrote:

>>> +               '-L', '%u,+%u' % [start, len],
>>> +               '--since', $since, from + '^',
>>> +               '--', source]) do |p|
>>> +      p.each do |line|
>>> +        if line =~ /^(\h{40})/
>>> +          id = $1
>>
>> Use $0 and remove the parens: you're matching the whole line.
>
> No, I'm not matching the whole line, but you are right; there's no
> need for groups.

Actually $&.

-- 
Felipe Contreras
