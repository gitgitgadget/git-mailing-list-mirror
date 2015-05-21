From: Luke Diamand <luke@diamand.org>
Subject: Re: git p4 clone - exclude file types
Date: Thu, 21 May 2015 22:49:56 +0100
Message-ID: <555E5304.5030502@diamand.org>
References: <CAFcBi88K-HEn4JCVkONq3h4O9XS1FFX0OXch2d-VJ2bLEsPM0g@mail.gmail.com>	<555A52BD.1030802@diamand.org>	<CAFcBi89XwW48Goaap=OCVQ_CJrNa_hj5+DWtOHGOsrm6jMs-mw@mail.gmail.com>	<555C2E5D.70502@diamand.org> <CAFcBi8-SShvWLS7sRy3L=vF=OmQqmroK5NpcuA9N=0J2x4DEXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Users <git@vger.kernel.org>
To: FusionX86 <fusionx86@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 21 23:50:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvYMV-0003F4-Hv
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 23:50:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756789AbbEUVug (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 17:50:36 -0400
Received: from mail-wi0-f182.google.com ([209.85.212.182]:35375 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756008AbbEUVua (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 17:50:30 -0400
Received: by wicmx19 with SMTP id mx19so29038781wic.0
        for <git@vger.kernel.org>; Thu, 21 May 2015 14:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=qJLLJQsR3AE3d+nh6S1dmSPMtzrDUeBsoW5Xrsknv7Q=;
        b=BDDO9ov24B9QUWmYA4swYojxIVA7V0WfSoOKsAv4FIZf0KIca0lwvWhpcqH8UqR0O2
         n5nVyDVuiCOKCcS3EnPOj/GxE2wE7XvAbeNXY1pg6xABkU1DJM0YdnZyOjs+giVpVEi9
         e1ah8tNBXhCBD/pvPuW/G0MODBz9lKKEFIUMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=qJLLJQsR3AE3d+nh6S1dmSPMtzrDUeBsoW5Xrsknv7Q=;
        b=OLq5+VGjCwH6LFnAaB0dOvp9lf+89GSyfq6lM33G3N3kLnqm5qIwsvysVWjNDVXnFj
         sae9vF30JQllmLHeSUqWwWDwDxxcqI29LRZxpc7Mtlb08fEglZ3lF8Aba8kpuZfL3j6l
         krs3S4lbRKWKJRKXXiCS79QLVnoj2BLFsOe4ZDVTBGl+NBb+r7QO4J0nX5fUYTsJC9TP
         ZSwN8sGa66Xffp3YbqM8R5hX0xEaPVWqFcLidtnNBlrrI3s1OkuIL7EQJLAOwTp8LjWV
         /jskSBMwgPu/GxglC1oBH0cKFxGRtW5fbyd1/fe09Aj9uoNl3AGkRLhtCceAdz8qhAYI
         eAZg==
X-Gm-Message-State: ALoCoQkvDZlDP+SqNB27B15qkjaiwEsv1NlGZ1qqRgL21XTRnUdxasLMuVHUX0Akn9/X9t160no+
X-Received: by 10.194.81.234 with SMTP id d10mr9194523wjy.84.1432245029163;
        Thu, 21 May 2015 14:50:29 -0700 (PDT)
Received: from [192.168.245.128] (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id o5sm4835199wia.0.2015.05.21.14.50.27
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 May 2015 14:50:28 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <CAFcBi8-SShvWLS7sRy3L=vF=OmQqmroK5NpcuA9N=0J2x4DEXA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269667>

On 21/05/15 21:49, FusionX86 wrote:
> I thought about that, but no. The box I'm running git-p4 on has the
> following specs:
>
> CentOS 6.6 64bit
> 1 CPU
> 8GB RAM
> 8GB Swap

Can you post the output, with "-v" added?

$ git-p4 clone //depot/some/dir -v

Also, what is your p4d server version?

$ p4 info

A quick test just cloning a repo with 4 files of 256MB each seems fine, 
FWIW.

>
> It is also on the same physical network as the Perforce server. I
> remember seeing someone else complain about this, but I can't find the
> article/blog now.
>
>
> On Wed, May 20, 2015 at 12:49 AM, Luke Diamand <luke@diamand.org> wrote:
>> On 19/05/15 08:38, FusionX86 wrote:
>>>
>>> Thanks Luke, looks like this does work for excluding files when using
>>> git p4. Great!
>>>
>>> Unrelated question...
>>>
>>> While using git p4 I have noticed that most of the time the clone/sync
>>> operations hang and I have to keep retrying. The Perforce depot I'm
>>> currently working with is larger than I'd like and has a lot of binary
>>> files which might be the cause. The point it gets to in the clone/sync
>>> is always random and doesn't ever stop on the same files or file
>>> types. Sometimes it'll die soon after starting, but other times it
>>> almost completes and then dies. If I keep retrying, it will eventually
>>> complete. I haven't been able to narrow down the cause, but I do
>>> notice that the git-fast-import stops right as the clone/sync dies.
>>> I'm wondering if git is overwhelmed and terminates. Have you ever seen
>>> this? Any suggestions?
>>
>>
>> Running out of memory?
>>
>> Is this on a 32bit or 64bit system? How much virtual memory do you have?
>>
>> Luke
>>
