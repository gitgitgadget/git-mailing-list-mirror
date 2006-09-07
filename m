From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: A look at some alternative PACK file encodings
Date: Thu, 07 Sep 2006 10:22:54 -0700
Message-ID: <4500556E.7070803@gmail.com>
References: <20060907090756.30111.qmail@science.horizon.com> <9e4733910609070557jd8cfc57nd4f7a8973b69f6ed@mail.gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "linux@horizon.com" <linux@horizon.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 07 19:23:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLNao-0006iQ-CP
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 19:23:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422637AbWIGRXE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 13:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422640AbWIGRXE
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 13:23:04 -0400
Received: from nz-out-0102.google.com ([64.233.162.206]:15036 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1422637AbWIGRXC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Sep 2006 13:23:02 -0400
Received: by nz-out-0102.google.com with SMTP id n1so154720nzf
        for <git@vger.kernel.org>; Thu, 07 Sep 2006 10:23:01 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=DfGNHFlvl0OB2WqhJnc5iSCVhdPkJf+cK6UDbBewwIB5XoJSemJDyJKADb187zX6eDzn9uEz906f6tZyGT8CNy1S7ugAdCkfHVzSnVV8yFHA0IVuR94Z8j5E0VxhkYbHqP6ol40Ys7joYoc8U62wJcSAKAAXjQdZ89BD5vnVX7s=
Received: by 10.65.116.7 with SMTP id t7mr987868qbm;
        Thu, 07 Sep 2006 10:23:01 -0700 (PDT)
Received: from ?10.0.0.6? ( [24.55.157.69])
        by mx.gmail.com with ESMTP id d5sm920844qbd.2006.09.07.10.23.00;
        Thu, 07 Sep 2006 10:23:01 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.5 (X11/20060725)
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910609070557jd8cfc57nd4f7a8973b69f6ed@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26645>

Jon Smirl wrote:
> On 7 Sep 2006 05:07:56 -0400, linux@horizon.com <linux@horizon.com> wrote:
>> > Support for 'thin' packs would pretty much require mixing IDs and
>> > (relative) offsets in the same pack file.
>>
>> An alternative would be to create a small "placeholder" object that
>> just gives an ID, then refer to it by offset.
>>
>> That would avoid the need for an id/offset bit with every offset,
>> and possibly save more space if the same object was referenced
>> multiple times.
>>
>> And it just seems simpler.
> 
> There are 2 million objects in the Mozilla pack. This table would take:
> 2M *  (20b (sha)  + 10b(object index/overhead) = 60MB
> This 60MB is pretty much incompressible and increases download time.
> 
> Much better if storage of the sha1s can be totally eliminated and
> replaced by something smaller. Alternatively this map could be
> stripped for transmission and rebuilt locally.
> 

You've lost me. What are you attempting to do again?
