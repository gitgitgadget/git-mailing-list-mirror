From: Pranit Bauva <pranit.bauva@zoho.com>
Subject: Re: [PATCH] SubmittingPatches : WIP tag in patches
Date: Fri, 26 Feb 2016 14:19:21 +0000
Message-ID: <56D05EE9.8020400@zoho.com>
References: <56D05BA2.1090502@zoho.com>
 <CAPig+cT9Aqm0+AEGz0F-CTihMJtMw45fq4h6zxKs_7uxHak0bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 09:11:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZDUZ-0000tj-4q
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 09:11:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932487AbcBZILJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 03:11:09 -0500
Received: from sender153-mail.zoho.com ([74.201.84.153]:22707 "EHLO
	sender153-mail.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932334AbcBZILH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 03:11:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=subject:to:references:cc:from:message-id:date:mime-version:in-reply-to:content-type; 
  b=pO5+m1U8IoGmLxgEntIBZRUVstetik/WhWiGV8kORQxctO02p4C17qABUGS4kxvYTD97hem7DSMj
    N1sM5rFcSq53bvnAvjrydd3vuCIXLy4sokzACssjd8gwkk6aZjcK  
Received: from 127.0.0.1 (tor.parad0x.org [87.98.250.222]) by mx.zohomail.com
	with SMTPS id 145647426305912.137823264044187; Fri, 26 Feb 2016 00:11:03 -0800 (PST)
In-Reply-To: <CAPig+cT9Aqm0+AEGz0F-CTihMJtMw45fq4h6zxKs_7uxHak0bg@mail.gmail.com>
X-Zoho-Virus-Status: 1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287548>

Eric Sunshine:
> On Fri, Feb 26, 2016 at 9:05 AM, Pranit Bauva <pranit.bauva@zoho.com> wrote:
>> ---
> 
> Missing sign-off.
> 

I have to inoculate the habit of signing off every time.
>> diff --git a/Documentation/SubmittingPatches
>> @@ -168,7 +168,9 @@ the closing bracket to mark the nature of the patch
>> is also
>>  encouraged.  E.g. [PATCH/RFC] is often used when the patch is
>>  not ready to be applied but it is for discussion, [PATCH v2],
>>  [PATCH v3] etc. are often seen when you are sending an update to
>> -what you have previously sent.
>> +what you have previously sent. [PATCH/WIP] is often used when some
> 
> Perhaps: /is often/can be/
> 
>> +work is yet left to be done on the patch but you want to get the
>> +review on the completed part of the patch.
> 
> Maybe: s/review/feedback/
> 
>>  "git format-patch" command follows the best current practice to
>>  format the body of an e-mail message.  At the beginning of the
>> --
>> 2.1.4

I have done the required changes, now I should send another email with
tag [PATCH v2] right?
