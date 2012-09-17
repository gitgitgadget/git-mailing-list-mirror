From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCHv2 01/12] git p4 test: remove bash-ism of combined export/assignment
Date: Mon, 17 Sep 2012 09:13:47 +0100
Message-ID: <5056DBBB.2070909@diamand.org>
References: <1347221773-12773-1-git-send-email-pw@padd.com> <1347221773-12773-2-git-send-email-pw@padd.com> <5054F22D.2020909@diamand.org> <7vfw6izenb.fsf@alter.siamese.dyndns.org> <50559E08.5020500@diamand.org> <7vk3vtxnf2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Pete Wyckoff <pw@padd.com>, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 10:15:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDWUC-0005Um-G1
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 10:15:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754672Ab2IQIPK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 04:15:10 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:65385 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754663Ab2IQIPE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 04:15:04 -0400
Received: by eekc1 with SMTP id c1so3277647eek.19
        for <git@vger.kernel.org>; Mon, 17 Sep 2012 01:15:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=qPU+XnpIw7p7MrEbTRQamsyX0ktUn08R2rjZkvkbLJY=;
        b=KNqXtZBhrvmhbPJ199JO98znpbx5bLViC/dBPHAYkrvJrXLeSvORpckcHEHM5EtybI
         OWx5hdS+is14OmrxSEcBTnrdI/rkv3XKtt9OtmYVOjoUlafi5tYro/WGHrZqsLKOi777
         yrLQxqEIfdYCuX8Z6FJjvLxvAbdu+HSrSH9tdPwbELEx7+vzgZ81Gv3fQRQLD0ORBSfa
         ejAtc9cLAv+d/ki+ySU7rCUfYwK94vPqLT6yvdxdh5ZvWcmpWmRqfOzA9FTkbDnpVI6G
         Naq1hMLpASWRlwRKuG0ISSMHH6zQBAgKTLrmr+KkWlRP2ts1x2ffJMtJLh+GuIt0jgEr
         3whQ==
Received: by 10.14.205.6 with SMTP id i6mr12425060eeo.13.1347869702153;
        Mon, 17 Sep 2012 01:15:02 -0700 (PDT)
Received: from [86.6.26.120] (cpc21-cmbg14-2-0-cust119.5-4.cable.virginmedia.com. [86.6.26.120])
        by mx.google.com with ESMTPS id v3sm25379551eep.10.2012.09.17.01.15.01
        (version=SSLv3 cipher=OTHER);
        Mon, 17 Sep 2012 01:15:01 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.4) Gecko/20120510 Icedove/10.0.4
In-Reply-To: <7vk3vtxnf2.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQlmo4rsACTOyLWpOme7n94OSeG4w4iodhvqhXx6ZeysvkA4skmdZ//NRQnNiGm3YIgmXUif
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205663>

On 17/09/12 05:50, Junio C Hamano wrote:
> Luke Diamand<luke@diamand.org>  writes:
>
>> On 16/09/12 07:05, Junio C Hamano wrote:
>>> Luke Diamand<luke@diamand.org>   writes:
>>>
>>>> Looks good to me, ack.
>>>
>>> Thanks; is this an ack for the entire series, or are you expecting
>>> further back-and-forth with Pete before the whole thing is ready?
>>
>> An ack for the whole series. I'm just going through the rest of the
>> patches now but I don't expect to find any issues.
>
> As long as the parties involved in the part of the system can agree
> that "this series is basically sound", I'd be happy to merge it
> down. Minor issues can be fixed up as follow-up patches.

Basically sound as far as I'm concerned.

>
> Thanks.  Will merge it to 'next'.
>
