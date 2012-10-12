From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: Re: [PATCH v2 0/2] Re: gitk: can't reload commits with new key binding
Date: Fri, 12 Oct 2012 10:17:21 -0400
Message-ID: <50782671.9010603@gmail.com>
References: <7vwqzacdb7.fsf@alter.siamese.dyndns.org> <1349190285-7788-1-git-send-email-andrew.kw.w@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Andrew Wong <andrew.kw.w@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, szeder@ira.uka.de,
	git list <git@vger.kernel.org>
To: paulus@samba.org
X-From: git-owner@vger.kernel.org Fri Oct 12 16:17:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMg3T-0002X6-LM
	for gcvg-git-2@plane.gmane.org; Fri, 12 Oct 2012 16:17:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934060Ab2JLORZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2012 10:17:25 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:52662 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932762Ab2JLORY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2012 10:17:24 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so4804896iea.19
        for <git@vger.kernel.org>; Fri, 12 Oct 2012 07:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=JdASwwku2UmwM6MQqf8eDnrZ7KDHdUJNS1T7ZQsTR40=;
        b=SEM9TshZMsf62C1k8Fme6hjfxx2iTbwNzZF/oEaGrOzkdzHXz8GqttdmbNLohDtHt3
         LV4SBL8SAuYbUcEm258Mq4TRd+FEsBM/XVKNLaVF9leS4meoGH4hbDHDg/L2kCxiDS98
         yOrTRd2Q7y75/RCq2PiT2SLNJB5ObzR/u5Hq0Gg/iXr05OexTIMNR2kRnQYpVfIxxfFc
         fZZL1gSorMZVZawlCquT/DXKHFgFxONc19wzASrPuW4UdSy574njoAoHXthQNdFylbPI
         l+PhFWM4jQ/VKZH9m5RRCKky8Dk8Iqm6BGr3lHAuRezdgv9tSkOt/xQvFv9HWbSEKpLJ
         lOEA==
Received: by 10.50.161.232 with SMTP id xv8mr2423411igb.22.1350051444066;
        Fri, 12 Oct 2012 07:17:24 -0700 (PDT)
Received: from [192.168.1.112] ([66.207.196.114])
        by mx.google.com with ESMTPS id uz12sm1580520igb.16.2012.10.12.07.17.22
        (version=SSLv3 cipher=OTHER);
        Fri, 12 Oct 2012 07:17:22 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120421 Thunderbird/12.0
In-Reply-To: <1349190285-7788-1-git-send-email-andrew.kw.w@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207546>

Can I get some feedback on these two patches? It'd be great to have them 
merged into gitk. Thanks.


On 10/02/2012 11:04 AM, Andrew Wong wrote:
> Refactored the code for binding modified function keys as Junio suggested.
>
> Andrew Wong (2):
>    gitk: Refactor code for binding modified function keys
>    gitk: Use bindshiftfunctionkey to bind Shift-F5
>
>   gitk | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
>
