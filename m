From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Re: Sparse checkout not working as expected (colons in
 filenames on Windows)
Date: Wed, 25 Mar 2015 09:17:43 +0100
Organization: gmx
Message-ID: <576a56072f8f30818b7af016e0ead628@www.dscho.org>
References: <BE2660C974C9415E997F20A49ABC766E@PhilipOakley>
 <CACsJy8BOuhohQzaGzD+4cthqOaL4sz1ADRD-ekhFhKt4wMcg7A@mail.gmail.com>
 <90D5D4B5F2ED41A6AB07E291004AA615@PhilipOakley>
 <CACsJy8AACwDPSEWdGiLLK3PTY=hLm0XOvN4_y4PbCFYrMzrnHg@mail.gmail.com>
 <61604ca6e1c2c114f5b536be420ba73a@www.dscho.org>
 <CACsJy8CZPufnyjdx0Z+SuUNhQ58gvKQprY98V7EJnodHgeyK5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Philip Oakley <philipoakley@iee.org>, Git List <git@vger.kernel.org>,
 Yue Lin Ho <yuelinho777@gmail.com>, msysGit <msysgit@googlegroups.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: msysgit+bncBCZPH74Q5YNRBMG6ZGUAKGQEJ2Q3XZQ@googlegroups.com Wed Mar 25 09:17:55 2015
Return-path: <msysgit+bncBCZPH74Q5YNRBMG6ZGUAKGQEJ2Q3XZQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f183.google.com ([209.85.212.183])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBMG6ZGUAKGQEJ2Q3XZQ@googlegroups.com>)
	id 1YagVd-0007vc-IM
	for gcvm-msysgit@m.gmane.org; Wed, 25 Mar 2015 09:17:53 +0100
Received: by widfb4 with SMTP id fb4sf8386179wid.1
        for <gcvm-msysgit@m.gmane.org>; Wed, 25 Mar 2015 01:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:content-type:date:from:to:cc:subject:organization
         :in-reply-to:references:message-id:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=9EglrwqhKvBV8uPA3QlN+e3D7cRrJvJ4ipiFf9Axbos=;
        b=PIwC5U3baMs8XbQn8o8Lu0QzelmXT6J3OEIR2ceERTv3u3nA/+c+gLmD/KFjxq5j0t
         bBRdpg5QbE6UczIzbScD90JzQOln3fQGR8Td62X7xY5ilBG5ZRPPLNLAnP8BB3IJZlmw
         mP8ToiRDk+rNOZTr1fRXBfzp45C1c62VvFp+NcEDtvLVz/0EXFXPFrJliNg9IAmzN1zr
         T6BS+8seDcIbxlbuoE90qv+kdmxRQT+n/AwEvncDsg8zijvZn0T2NAuDXLqY8tEaRYgZ
         R3PbfHBVycGsCga/YpqiZcB63/+qk6qQkpNVsr7kFoLK5KX01eCRZGQbC/qrGPXH4snC
         B4mA==
X-Received: by 10.152.37.226 with SMTP id b2mr110376lak.40.1427271473081;
        Wed, 25 Mar 2015 01:17:53 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.170.164 with SMTP id an4ls67867lac.19.gmail; Wed, 25 Mar
 2015 01:17:51 -0700 (PDT)
X-Received: by 10.112.73.33 with SMTP id i1mr1755226lbv.0.1427271471759;
        Wed, 25 Mar 2015 01:17:51 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.17.21])
        by gmr-mx.google.com with ESMTPS id i8si142916wif.1.2015.03.25.01.17.51
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Mar 2015 01:17:51 -0700 (PDT)
Received-SPF: pass (google.com: domain of johannes.schindelin@gmx.de designates 212.227.17.21 as permitted sender) client-ip=212.227.17.21;
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0Mcxtm-1YrfA228kE-00IH5P; Wed, 25 Mar 2015 09:17:44
 +0100
In-Reply-To: <CACsJy8CZPufnyjdx0Z+SuUNhQ58gvKQprY98V7EJnodHgeyK5A@mail.gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:7lU4ENjUEnm6RuyVfJdNeXDb0FyUPoBIuerLGqDLdvJVYlaNTx2
 IIC/VqZPnj2sZPNfhzOQcuJITP0oTWCtIRXUk+hatjYBhPvtVbHQo1x6Dq94xz312IJ9xBx
 NOxM1ycQ/mBz7K+AAQiQlqlbwpbl4S8WarV8cz2hOHj3RQVGMx4Mo+VKyNVKyBCiAjNcv33
 RAIVT1Qv4S6C2xcAeT6lQ==
X-UI-Out-Filterresults: notjunk:1;
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of johannes.schindelin@gmx.de designates 212.227.17.21 as
 permitted sender) smtp.mail=johannes.schindelin@gmx.de
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266273>

Hi Duy,

On 2015-03-25 07:44, Duy Nguyen wrote:
> On Wed, Mar 25, 2015 at 1:39 PM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
>>
>> On 2015-03-25 01:46, Duy Nguyen wrote:
>>> On Wed, Mar 25, 2015 at 6:50 AM, Philip Oakley <philipoakley@iee.org> wrote:
>>>
>>>> That said, the final error (which I'd missed in the earlier post) is:
>>>> fatal: make_cache_entry failed for path 'ifcfg-eth0:0'
>>>>
>>>> This is on the Windows (pre-compiled msysgit at v1.9.5) Git bash, so could
>>>> be a catch path in that code for make_cache_entry (I've not checked the code
>>>> yet). So at the moment it doesn't look like sparse checkout can be used to
>>>> avoid colons in windows on-disk files based on the current code.
>>>
>>> Both of your commands below fail by the same function, verify_path()
>>> because of this msysgit commit 2e2a2d1 (NTFS: Prevent problematic
>>> paths from being checked out - 2014-12-10). I guess that check is a
>>> bit too strong, it should apply when new index entries are created
>>> from worktree (not from a tree)..
>>
>> Oh, right, that check needs some relaxing. But certainly in a different way: you *definitely* want to prevent attacks from the outside, and those originate from the *tree*.
>>
>> What we need to do instead is to relax the check to apply only if we are really going to write out that file, not when it is skipped.
> 
> Yeah. In fact if you do this, not checking out  files that can't be or
> not safe to be checked out, then the ifcfg-eth0:0 problem that Phillip
> wanted to avoid using sparse checkout is also gone.

I had a quick look at the `verify_path()` function and have to say: it is more complicated than this. At the point when this function is called, we are only concerned with the index. So we have no idea whether we are going to write this to disk or not.

I guess there is a much easier solution to this: set `core.protectntfs` to `false` in this specific repository, before checking out any files.

Ciao,
Johannes

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
