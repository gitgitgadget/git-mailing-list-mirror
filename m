From: =?UTF-8?B?U8OpYmFzdGllbiBHdWltbWFyYQ==?= 
	<sebastien.guimmara@gmail.com>
Subject: Re: [PATCH v11 2/5] command-list.txt: add the common groups block
Date: Mon, 25 May 2015 19:31:48 +0200
Message-ID: <55635C84.7080108@gmail.com>
References: <1432229962-21405-1-git-send-email-sebastien.guimmara@gmail.com>	<1432229962-21405-3-git-send-email-sebastien.guimmara@gmail.com> <CAPig+cRciCgBZyuT4fz0JZLY9SRmODaXq=gvsimVQ7sdt+AzcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon May 25 19:31:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwwEI-0007ak-5g
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 19:31:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbbEYRbw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 May 2015 13:31:52 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:35168 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750853AbbEYRbv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2015 13:31:51 -0400
Received: by wicmx19 with SMTP id mx19so53863474wic.0
        for <git@vger.kernel.org>; Mon, 25 May 2015 10:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=LOw3HO1fzlO9nRM/KuoXBgh7F9b0dm0cPfTfPB9/c1U=;
        b=J4YsS9auvt3sv5Zc/hWT7eC3phopCxUcT66Fhz7YH/m7QtCBgptNl52IrEMmbauRah
         GhHbJKlXzNG4ESMjrxJC5uc+tiGmkuSzqB9D/dkAEZReXW/vUA9I+b2pinVVIE66PjWu
         sCc0MzrVxAF09qCeRaezXO9n1ZmWjCf+wU5+m+1Oo9YSX6OMGFvV0jrIfq3jH555ZMR8
         O0eMmoqBpm3U5/DxfJ30tw6E6MEWbkooQmT1VQe3QHVtKVfQwQ39wmDH03+ePmRkp2ir
         1I+heh5vCelBMPW31xo0qeL9XHaAsoYpFYfEBCvz2rreCFSbpsuVdbQzUnbFaw0Mrevk
         bg0A==
X-Received: by 10.195.11.168 with SMTP id ej8mr25078913wjd.150.1432575110398;
        Mon, 25 May 2015 10:31:50 -0700 (PDT)
Received: from [192.168.0.10] (bd231-1-88-176-208-17.fbx.proxad.net. [88.176.208.17])
        by mx.google.com with ESMTPSA id g14sm17714562wjs.47.2015.05.25.10.31.49
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 May 2015 10:31:49 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <CAPig+cRciCgBZyuT4fz0JZLY9SRmODaXq=gvsimVQ7sdt+AzcA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269848>



On 05/21/2015 08:01 PM, Eric Sunshine wrote:
> On Thu, May 21, 2015 at 1:39 PM, S=C3=A9bastien Guimmara
> <sebastien.guimmara@gmail.com> wrote:
>> The ultimate goal is for "git help" to display common commands in
>> groups rather than alphabetically. As a first step, define the
>> groups in a new block, and then assign a group to each
>> common command.
>>
>> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
>> Helped-by: Junio C Hamano <gitster@pobox.com>
>> Helped-by:  Emma Jane Hogbin Westby <emma.westby@gmail.com>
>> Signed-off-by: S=C3=A9bastien Guimmara <sebastien.guimmara@gmail.com=
>
>> ---
>> diff --git a/command-list.txt b/command-list.txt
>> index 181a9c2..32ddab3 100644
>> --- a/command-list.txt
>> +++ b/command-list.txt
>> @@ -1,3 +1,14 @@
>> +# common commands are grouped by themes
>> +# these groups are output by 'git help' in the order declared here.
>> +# map each common command in the command list to one of these group=
s.
>> +### common groups (do not change this line)
>> +init         start a working area (see also: git help tutorial)
>> +worktree     work on the current change (see also: git help everyda=
y)
>> +info         examine the history and state (see also: git help revi=
sions)
>> +history      grow, mark and tweak your common history
>> +remote       collaborate (see also: git help workflows)
>> +
>> +# List of known git commands.
>
> This is odd. The above line was removed in 1/5 but then re-appears
> here in 2/5. I think the intent is that it should remain removed.
>
>>   ### command list (do not change this line)
>>   # command name                          category [deprecated] [com=
mon]
>>   git-add                                 mainporcelain common

My mistake. This will be corrected in the next version. Thank you for t=
aking time
to review this series.

S=C3=A9bastien
