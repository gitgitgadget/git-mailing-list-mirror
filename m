From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: ks/precompute-completion (was Re: What's cooking in git.git (Oct
 	2009, #04; Wed, 21))
Date: Thu, 22 Oct 2009 19:05:38 -0400
Message-ID: <4AE0E542.8010501@gmail.com>
References: <7veiovly35.fsf@alter.siamese.dyndns.org>	 <4AE0190E.8020803@gmail.com>	 <fabb9a1e0910221011r957246dx3162cd675ff16800@mail.gmail.com>	 <4AE0DAB3.1030103@gmail.com>	 <fabb9a1e0910221555k287b45ebwb15ac97851b845f9@mail.gmail.com> <fabb9a1e0910221556s694a344ag8e5ae07c35351ee4@mail.gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Kirill Smelkov <kirr@mns.spb.ru>,
	Stephen Boyd <bebarino@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 23 01:05:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N16j8-0007SF-Hq
	for gcvg-git-2@lo.gmane.org; Fri, 23 Oct 2009 01:05:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbZJVXFl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2009 19:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbZJVXFk
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 19:05:40 -0400
Received: from mail-yx0-f187.google.com ([209.85.210.187]:41763 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964AbZJVXFk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2009 19:05:40 -0400
Received: by yxe17 with SMTP id 17so7460795yxe.33
        for <git@vger.kernel.org>; Thu, 22 Oct 2009 16:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=fnImvCh8ZduWkRBTTH9kSlrFJoRm2D9N7PAjjNlU6aA=;
        b=ALbEddhBTKiLH31SODone7VMBVx27xZ/2SGWAWByrvzUuIDZ3hAbg38i+c2C7S3dN5
         HBHL5QEDRdCe4qtZopek40MI08Y2gyvrplv6OnYvHpqLvIlJeqSOEdPgM5z/FCDKZ5UL
         HUgTlDFEfTnlUxAzhr87dwlbFyw+cl16J4k7w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=p1hthxI89dFmtKNUAyZd7LhUlI8sDql9gkKnRKVAH7E1NuOT+r2D7JHqUzH7REjatu
         UI0kVs/VBUiQbBVVlU6kHD69MQImh9DC7iKIhMwVOGasSNaWDiECDiQSe5ki5FVd4TcO
         9CvHOZZNZ/L3z5KX+cGmMxTkqWBcbmCwqPlqA=
Received: by 10.150.129.13 with SMTP id b13mr16759747ybd.314.1256252741746;
        Thu, 22 Oct 2009 16:05:41 -0700 (PDT)
Received: from ?10.0.0.6? (c-71-199-240-201.hsd1.fl.comcast.net [71.199.240.201])
        by mx.google.com with ESMTPS id 14sm233042gxk.14.2009.10.22.16.05.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 22 Oct 2009 16:05:41 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <fabb9a1e0910221556s694a344ag8e5ae07c35351ee4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131075>

Sverre Rabbelier wrote:
> How am i forcing completion on those that did not ask for it? Nothing 
> changes  compared to the old situation....
> 
>> On Oct 22, 2009 5:20 PM, "A Large Angry SCM" <gitzilla@gmail.com 
>> <mailto:gitzilla@gmail.com>> wrote:
>>
>> Sverre Rabbelier wrote: > > Heya, > > On Thu, Oct 22, 2009 at 03:34, 
>> Stephen Boyd <bebarino@gmail.co...
>>
>> Please do not for completion on those that did not ask for it.
> 

Your original email included 'make && make install'; it's the "make 
install" part I'm concerned about.
