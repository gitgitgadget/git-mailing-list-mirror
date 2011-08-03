From: Jon Forrest <nobozo@gmail.com>
Subject: Re: [PATCH] For Real - Fixed pluralization in diff reports
Date: Wed, 03 Aug 2011 09:52:57 -0700
Message-ID: <4E397CE9.2070500@gmail.com>
References: <4E362F8E.1050105@gmail.com> <CAGdFq_iwEvD_-hD63KeF45WuRhWrK6JuWWqzDpjHcZ+0gHDaqg@mail.gmail.com> <4E36B8E4.5080900@gmail.com> <m3livdqh9h.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-4; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 03 18:53:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qoegn-0000AQ-JD
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 18:53:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753327Ab1HCQw5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 12:52:57 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:39737 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752532Ab1HCQw4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 12:52:56 -0400
Received: by iyb12 with SMTP id 12so1142813iyb.19
        for <git@vger.kernel.org>; Wed, 03 Aug 2011 09:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=4ENPFJAWo5mMw4vYKQUDY3qckhL44kqksgbGNwfPsTc=;
        b=qRIu839WYDH8xrPnlpA5sMDi3lzg84ErxTh5m8Na6pOG8sJYN6CR3tYOUjgm2ZK5lS
         eS3gGLHmeLxGOPvqusE2bC2ib5rNtzEDqJCJ7MYrxPwZb1J9M6gz90YZBRmdlaeXCjls
         8Crvv5+1q9szWoZbIOIrwnzV6rVltUzvzevZY=
Received: by 10.42.163.71 with SMTP id b7mr4862218icy.167.1312390375730;
        Wed, 03 Aug 2011 09:52:55 -0700 (PDT)
Received: from [192.168.50.71] (206-80-5-2.static.twtelecom.net [206.80.5.2])
        by mx.google.com with ESMTPS id q4sm664309ibb.15.2011.08.03.09.52.54
        (version=SSLv3 cipher=OTHER);
        Wed, 03 Aug 2011 09:52:54 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:5.0) Gecko/20110624 Thunderbird/5.0
In-Reply-To: <m3livdqh9h.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178594>

On 8/3/2011 6:38 AM, Jakub Narebski wrote:
> Jon Forrest<nobozo@gmail.com>  writes:

> Besides, as it was already said, this is an API.

I pretty much only looked at that one file and it
didn't look at quick glance like an API was being
used to internationalize git.

>> If the goal if the i18n effort is also to produce grammatically
>> correct output in all the supported languages then the
>> tests that my patch would break would have to be rewritten
>> anyway.
>
> That's not it.

We can discuss the correct way to implement a change like this
but the fact remains that whatever the implementation, the issue
that Junio raised will remain. That is, what to do about all
the places that presume the old incorrect output.

This problem isn't specific to git. I can easily imagine
other open source projects that face, or will face, this
problem.

Jon
