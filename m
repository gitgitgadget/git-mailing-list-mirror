From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v4 10/11] Documentation/replace: list long option names
Date: Thu, 5 Sep 2013 15:03:19 +0200
Message-ID: <CAP8UFD1u=mh68WBcfd_O-bSRb0LsaPJdPhqFd47xx=zESxFU7g@mail.gmail.com>
References: <20130903070551.29838.43576.chriscool@tuxfamily.org>
	<20130903071026.29838.46822.chriscool@tuxfamily.org>
	<xmqqvc2gl3i5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>, Philip Oakley <philipoakley@iee.org>,
	Thomas Rast <trast@inf.ethz.ch>, Johannes Sixt <j6t@kdbg.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 05 15:03:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHZDW-0007cX-J7
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 15:03:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751968Ab3IENDV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 09:03:21 -0400
Received: from mail-ve0-f182.google.com ([209.85.128.182]:46968 "EHLO
	mail-ve0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751838Ab3IENDU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 09:03:20 -0400
Received: by mail-ve0-f182.google.com with SMTP id oy12so480283veb.13
        for <git@vger.kernel.org>; Thu, 05 Sep 2013 06:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=fkjDOic8xffmiHxLcBRr5Q9uLDcUvnDSSGZkxFaq5lk=;
        b=MsXsNRtGhtrDWxZkKeiRiIM3wfvWpABWbrzr/CnpkeR2bE3bnAIZtUCH5N06ZDK7gu
         hIHo4RbDc4qtOgxPVbDfHnVCK3z48nDw35t/9VVK+j0wybKuiSJg9vYPmC+7Kq3VUu4+
         jMxcoaZaconJhAa3Pn9ekQ6OHFKKK2R34DUbJ84UAN/kYjDTYwjBqVLgqhbnoqlonL7l
         Xny1t2P8Yr2hFTm1gmeIpOVR2wYBoFQkyps1LFjgFXvnJBP8fefBnkF1PwXoRxaDKDem
         Zte6YH2XGCMOEpLhHLXrzl88Jn+tsaDcObpO0sK5wykxsslLnjTNJrrT2hNJ2070z4nB
         adpQ==
X-Received: by 10.59.8.232 with SMTP id dn8mr7753431ved.8.1378386199364; Thu,
 05 Sep 2013 06:03:19 -0700 (PDT)
Received: by 10.58.240.102 with HTTP; Thu, 5 Sep 2013 06:03:19 -0700 (PDT)
In-Reply-To: <xmqqvc2gl3i5.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233957>

On Wed, Sep 4, 2013 at 10:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <chriscool@tuxfamily.org> writes:
>
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
>>  Documentation/git-replace.txt | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/Documentation/git-replace.txt b/Documentation/git-replace.txt
>> index a2bd2ee..414000e 100644
>> --- a/Documentation/git-replace.txt
>> +++ b/Documentation/git-replace.txt
>> @@ -54,13 +54,16 @@ achieve the same effect as the `--no-replace-objects` option.
>>  OPTIONS
>>  -------
>>  -f::
>> +--force::
>>       If an existing replace ref for the same object exists, it will
>>       be overwritten (instead of failing).
>>
>>  -d::
>> +--delete::
>>       Delete existing replace refs for the given objects.
>>
>>  -l <pattern>::
>> +--list <pattern>::
>>       List replace refs for objects that match the given pattern (or
>>       all if no pattern is given).
>>       Typing "git replace" without arguments, also lists all replace
>
> This should be in the same commit as what adds them.

Ok, I will squash 10/11 into 9/11.

Thanks,
Christian.
