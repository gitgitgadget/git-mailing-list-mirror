From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH 1/8] config.txt: remove pointer to SubmittingPatches
Date: Thu, 23 Apr 2009 09:03:41 -0700
Message-ID: <49F0915D.9030009@gmail.com>
References: <1240479482-31366-1-git-send-email-bebarino@gmail.com> <1240479482-31366-2-git-send-email-bebarino@gmail.com> <49F05978.30009@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Andreas Ericsson <exon@op5.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Apr 23 18:06:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lx1QS-0005YX-Br
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 18:05:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752256AbZDWQDs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 12:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751552AbZDWQDr
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 12:03:47 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:50559 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751392AbZDWQDr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 12:03:47 -0400
Received: by yw-out-2324.google.com with SMTP id 5so368389ywb.1
        for <git@vger.kernel.org>; Thu, 23 Apr 2009 09:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=/629aufQ7CRHQwobI4R/effkAFZ6NIBUwzDPkH1ynEk=;
        b=SQSRpdM5Ewx48eeqV5VufN8lS+eDzvMJ6zGGzv+CX9NuBwfZhY3c59UWXMoGxXU+BL
         HkXKp4wqTuAMTcv2OtPTdQa99YEKWqkVahGrYUYopNqlx6p+tXJnMzQq/5yMNCLDF5Gz
         Z0Z2YCxaa0tFgmHOOzFBH2TbYS8GOP6fiBIcY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=ueoppUveLmWkPqEn8LtTqZNWMhU0ttDPLg59RSm8Az9lUFplEfZXFUOFNibPFZqJ12
         IORZlIoFJb9j661wzVMYvs5tcePqm+fZN9n5U63zU7rIpoEJkjjXpgjLXvUikflu8yxD
         OZupqP5KOw/BJZVJp6Bt9KZOlhl6E9wctUML4=
Received: by 10.142.172.12 with SMTP id u12mr394294wfe.132.1240502625093;
        Thu, 23 Apr 2009 09:03:45 -0700 (PDT)
Received: from ?192.168.1.3? ([76.89.212.195])
        by mx.google.com with ESMTPS id 31sm286161wff.24.2009.04.23.09.03.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 23 Apr 2009 09:03:43 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090321)
In-Reply-To: <49F05978.30009@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael J Gruber wrote:
> Stephen Boyd venit, vidit, dixit 23.04.2009 11:37:
>> SubmittingPatches exists in the git source documentation for developers
>> of git and is not included in the man/html page distributions.
>>
>> Signed-off-by: Stephen Boyd <bebarino@gmail.com>
>> ---
>>  Documentation/config.txt |    1 -
>>  1 files changed, 0 insertions(+), 1 deletions(-)
>>
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index 35056e1..fb7adfa 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -743,7 +743,6 @@ format.signoff::
>>      format-patch by default. *Note:* Adding the Signed-off-by: line to a
>>      patch should be a conscious act and means that you certify you have
>>      the rights to submit this work under the same open source license.
>> -    Please see the 'SubmittingPatches' document for further discussion.
>
> Shouldn't we point to the source then? We're not talking about links
> here, only references in the sense of referring to further reading.

I was thinking that a user isn't going to download the source for git so
they can read the SubmittingPatches document. Although, it's possible
they downloaded the tarball and built from source so they would have the
file.

Now I'm starting to dislike this whole paragraph because git isn't used
exclusively for open source software. Seems like others agree with a
little searching of gmane[1]
I think Andreas Ericsson's version with Jeff King's updates would be good.

Junio, I would say drop this patch.


[1] http://thread.gmane.org/gmane.comp.version-control.git/115299
