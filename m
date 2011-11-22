From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: Re: [PATCH 2/3] Compile fix for MSVC: fix poll-related macro redefines
Date: Tue, 22 Nov 2011 08:30:00 +0100
Message-ID: <4ECB4F78.40309@lyx.org>
References: <1321634670-4968-1-git-send-email-vfr@lyx.org> <1321634670-4968-2-git-send-email-vfr@lyx.org> <4EC6978D.3020604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, kusmabite@gmail.com,
	msysgit@googlegroups.com, j.sixt@viscovery.net,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 22 08:30:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSko3-0003wQ-BD
	for gcvg-git-2@lo.gmane.org; Tue, 22 Nov 2011 08:30:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754844Ab1KVHaI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Nov 2011 02:30:08 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:60038 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753682Ab1KVHaH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2011 02:30:07 -0500
Received: by wwe5 with SMTP id 5so11998878wwe.1
        for <git@vger.kernel.org>; Mon, 21 Nov 2011 23:30:05 -0800 (PST)
Received: by 10.227.207.146 with SMTP id fy18mr7405993wbb.18.1321947005357;
        Mon, 21 Nov 2011 23:30:05 -0800 (PST)
Received: from [192.168.40.217] (221-44.206-83.static-ip.oleane.fr. [83.206.44.221])
        by mx.google.com with ESMTPS id z39sm8286659wbm.12.2011.11.21.23.30.02
        (version=SSLv3 cipher=OTHER);
        Mon, 21 Nov 2011 23:30:04 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <4EC6978D.3020604@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185777>

Op 18-11-2011 18:36, Sebastian Schuberth schreef:
> On 18.11.2011 17:44, Vincent van Ravesteijn wrote:
>
>> diff --git a/git-compat-util.h b/git-compat-util.h
>> index 5ef8ff7..76cbfe6 100644
>> --- a/git-compat-util.h
>> +++ b/git-compat-util.h
>> @@ -85,6 +85,7 @@
>>  #define _SGI_SOURCE 1
>>
>>  #ifdef WIN32 /* Both MinGW and MSVC */
>> +#  define _WIN32_WINNT 0x0501
>>  #define WIN32_LEAN_AND_MEAN  /* stops windows.h including winsock.h */
>>  #include<winsock2.h>
>>  #include<windows.h>
>
> It seems the indentation is wrong (does not match the surrounding 
> code) here.
>

Yes, you're right. I will reroll the patch series when there is somewhat 
more feedback on the series.

Vincent
