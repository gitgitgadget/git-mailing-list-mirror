From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH (GITK) v3 6/6] gitk: Explicitly position popup windows.
Date: Fri, 07 Nov 2008 17:37:20 +0100
Message-ID: <49146EC0.4050006@viscovery.net>
References: <1225652389-22082-1-git-send-email-angavrilov@gmail.com>	 <1225652389-22082-2-git-send-email-angavrilov@gmail.com>	 <1225652389-22082-3-git-send-email-angavrilov@gmail.com>	 <1225652389-22082-4-git-send-email-angavrilov@gmail.com>	 <1225652389-22082-5-git-send-email-angavrilov@gmail.com>	 <1225652389-22082-6-git-send-email-angavrilov@gmail.com>	 <1225652389-22082-7-git-send-email-angavrilov@gmail.com>	 <18708.11537.229423.296701@cargo.ozlabs.ibm.com> <81b0412b0811070639q47244bc4t10791781fb0ec43b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>,
	Alexander Gavrilov <angavrilov@gmail.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 07 17:38:46 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyUM4-0000v5-I9
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 17:38:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbYKGQhZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 11:37:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbYKGQhZ
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 11:37:25 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:21851 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054AbYKGQhY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 11:37:24 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KyUKn-0004Tv-DC; Fri, 07 Nov 2008 17:37:21 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 2723969F; Fri,  7 Nov 2008 17:37:21 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <81b0412b0811070639q47244bc4t10791781fb0ec43b@mail.gmail.com>
X-Spam-Score: 1.2 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_95=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100317>

Alex Riesen schrieb:
> 2008/11/7 Paul Mackerras <paulus@samba.org>:
>> Is there any reason to call tk::PlaceWindow under Linux or MacOS?
>> If not I'd rather add an if statement so we only call it on Windows.
>>
> 
> Yes, please. I rather like the smart placement in compiz.

Just out of curiosity because I don't use compiz: Did you mean
   "Yes, please call tk::PlaceWindow on Linux"
or
   "Yes, please add the if statement"
? ;)

-- Hannes
