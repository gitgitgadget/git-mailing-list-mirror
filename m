From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH/WIP v3 4/4] ref-filter: move code from 'for-each-ref'
Date: Fri, 29 May 2015 02:16:38 +0530
Message-ID: <55677EAE.5060205@gmail.com>
References: <5567527A.6090607@gmail.com>	<1432835025-13291-4-git-send-email-karthik.188@gmail.com> <vpq382go2yz.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, christian.couder@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu May 28 22:46:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yy4hU-0008S6-79
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 22:46:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754563AbbE1Uqo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2015 16:46:44 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:32943 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754352AbbE1Uqn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2015 16:46:43 -0400
Received: by pdbqa5 with SMTP id qa5so49805604pdb.0
        for <git@vger.kernel.org>; Thu, 28 May 2015 13:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=CN6kkCTXOc2hibhdl+siuO0wLCsVNxjRJs1kE5jSZ24=;
        b=RF8lhArKPHrGuskbaEUpW7Bkak2YlH67QvcO0PcatyRghWyKPcvvD08IP8/dvhYG6b
         HSWgmiTFfAX4+o4kOFOmkw5rGTJPw1nyrSJYgTPIeJFD2SHlXqSLjvaXqc0k18w7UcjJ
         wmo4+HBQB8hM8nv4xSJrL/8OLHpthFblrS4yYb/+ua8jH8/kO/obdmFpgRjPQo0/Wk2Q
         Lu8pJe+XMEylde9FMbXv7jpqDJm+WYhQE6rLIPjW9buqoT8QowD5xda19VwA3wf/bOvN
         f1XC7ifS/G9OM10rVgdBAdYIyms2Yz4i3PVqUJEjY3pyqCcLdnkomXwmBchvhGguCrcp
         ppvg==
X-Received: by 10.70.103.200 with SMTP id fy8mr8845312pdb.136.1432846002745;
        Thu, 28 May 2015 13:46:42 -0700 (PDT)
Received: from [192.168.0.100] ([106.51.130.23])
        by mx.google.com with ESMTPSA id h11sm3301103pdj.27.2015.05.28.13.46.40
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 May 2015 13:46:42 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <vpq382go2yz.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270198>

On 05/29/2015 02:05 AM, Matthieu Moy wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Move most of the code from 'for-each-ref' to 'ref-filter' to make
>> it publically available to other commands, this is to unify the code
>
> s/publically/publicly/
>
>> --- /dev/null
>> +++ b/ref-filter.h
>
> Moving file to the .h file should be done in a separate patch. I don't
> want to review the 1050 lines of cut-and-paste other than by doing the
> cut-and-paste myself and see if I get the same result, but this part is
> not as straightforward and needs proper thinking and review.
>
> In short: the big code movement should be *only* a cut-and-paste, alone
> in its own patch.
>

Ok, will separate it into two patches.

 >
> On overall, we're getting close to an acceptable version for these 4
> patches. My advice: prioritize polishing these few patches, so that we
> can do a detailed review and then consider this part "done" (either
> merged in git.git or not, but I'd like to avoid having to review the
> code movement & refactoring again when we move to the next patches).
>

Sure I'll fix changes suggested by you and push to Github probably by 
tonight (IST), will wait for a day or two to see if there are more 
suggestions by others on the mailing list before sending a new patch 
series here.

-- 
Regards,
Karthik
