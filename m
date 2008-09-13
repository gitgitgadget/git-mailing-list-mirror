From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [ANN] mtn2git v0.1
Date: Sat, 13 Sep 2008 14:02:08 +0200
Message-ID: <200809131402.11413.jnareb@gmail.com>
References: <94a0d4530809121559w5f644174j461ec61cb2327fd8@mail.gmail.com> <m3d4j8nzy9.fsf@localhost.localdomain> <94a0d4530809130352v5775be53sc14b354b8c1dae15@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, monotone-devel@nongnu.org, devel@pidgin.im,
	openembedded-devel@openembedded.org
To: "Felipe Contreras" <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 13 14:03:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeTqp-0001tv-Hi
	for gcvg-git-2@gmane.org; Sat, 13 Sep 2008 14:03:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751698AbYIMMCf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Sep 2008 08:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751864AbYIMMCf
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Sep 2008 08:02:35 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:55285 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751516AbYIMMCe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Sep 2008 08:02:34 -0400
Received: by ey-out-2122.google.com with SMTP id 6so549479eyi.37
        for <git@vger.kernel.org>; Sat, 13 Sep 2008 05:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=vZsG4/ztNN1rUd05sqxFluiUB9KQgMwdc6Ziv40OiTw=;
        b=hdBr5390iEbZxUHdfbiMQbFl1aKmA1n9JDeYSHwkNkEPFhCKRp6E1+hLjKb47P17s3
         miQSsunaivGtAaorAIrTLT5x5OgBT2kaIoWu0PbCwmogYPlw3JNoETxNV8hRnWLy2TL1
         X3t3+aHPF54YHUMEslMJ0i4q6urqBQMU/vXgU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=VVGP5yurJo2Q74s6D3U0TnaZyMAcTTWhn61qW4uLEkaLzJqyMSUEsWHe9zN8q2Cfna
         e4asOKjnJZIMS680DCh8F2FHYukMToNt9bt/K8QoyVJtl+m1ymZfECvbpz2ewZ8mvssE
         q2S6iwpWBzjpZmHJp7vhz+y8zXz8Dsjbp4cpQ=
Received: by 10.86.98.10 with SMTP id v10mr4076173fgb.39.1221307352427;
        Sat, 13 Sep 2008 05:02:32 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.227.225])
        by mx.google.com with ESMTPS id 3sm12081002fge.3.2008.09.13.05.02.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 13 Sep 2008 05:02:31 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <94a0d4530809130352v5775be53sc14b354b8c1dae15@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95799>

On Sat, 13 Sep 2008, Felipe Contreras wrote:
> On Sat, Sep 13, 2008 at 12:45 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>> "Felipe Contreras" <felipe.contreras@gmail.com> writes:
>>
>>> This is the result of various experiments I've been doing while trying
>>> to import mtn repositories into git. I've looked into other mtn2git
>>> scripts but none fitted my needs.
>>
>> mtn or mnt?
> 
> monotone = mtn

Thanks.

My confusion resulted from the fact that 'monotone' has 'n' both
before and after 't'.
 
>>> After some RFCs on git and monotone mailing lists it seems now that
>>> the script is going in the right direction.
>>
>> When you feel this script to be ready, could you add it to the
>> "Interaction with other Revision Control Systems" section on
>>  http://git.or.cz/gitwiki/InterfacesFrontendsAndTools
>> As far as I can see there ain't any Monotone to Git converter on this
>> list.
> 
> Ok, done. I think it's ready if you can bare the slowness of the
> 'checkout' method. The only missing feature is tags, but should be
> easy to implement.

Thank you.

BTW. did you have any problems with (from what I understand) slightly
different concept of branches between Monotone and Git?

-- 
Jakub Narebski
Poland
