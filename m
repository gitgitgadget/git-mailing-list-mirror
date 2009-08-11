From: Ori Avtalion <ori@avtalion.name>
Subject: Re: [PATCH] Change mentions of "git programs" to "git commands"
Date: Wed, 12 Aug 2009 02:29:18 +0300
Message-ID: <4A81FECE.5040806@avtalion.name>
References: <4a7c3971.170d660a.3caa.20b3@mx.google.com>	<20090811125813.6117@nanako3.lavabit.com>	<4A815AAC.2030601@avtalion.name> <20090812075946.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 01:29:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mb0mY-0002q1-Um
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 01:29:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755644AbZHKX3W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 19:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755612AbZHKX3W
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 19:29:22 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:47913 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754309AbZHKX3V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 19:29:21 -0400
Received: by bwz19 with SMTP id 19so3472036bwz.37
        for <git@vger.kernel.org>; Tue, 11 Aug 2009 16:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=BtKLoy61tgeuZEzu1jQ0ZjCtUYD92TnN8w2c1D8fg8E=;
        b=SEcy4ufuOdJ6nao2dps2YN+wg5NP8idKXTisDg2rAaU4oMxPOz4vb0bjt4bD5wm8Wu
         xDGK+d2q421yByNuo7IZj0OMXMA4lWTKTtx08zSkL0xgkxRkhjzVgkEFunfTnI+6bNiw
         CA12P9lffeH51KpVsAle+JeBaqmW/CVsVJ17o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=ib3v73ghCLfCL3BHVR3J0AAGY+sTfZpAqf01+3r2ZTiEuYmrto5sdXmqxRFVsy4t5P
         ssMgSTXXiQB2iAV6a56kNR6D0pNIJq72WyOd9Ana8EQYESdfi1d7etj60TGash1oqbrD
         SYdEoVl0JHaBO9b3t3SiYcuc+sh23BiNmldV0=
Received: by 10.102.149.23 with SMTP id w23mr70509mud.38.1250033361052;
        Tue, 11 Aug 2009 16:29:21 -0700 (PDT)
Received: from ?192.168.1.55? (bzq-82-81-59-125.red.bezeqint.net [82.81.59.125])
        by mx.google.com with ESMTPS id u9sm27725559muf.37.2009.08.11.16.29.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 11 Aug 2009 16:29:20 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.1.3pre) Gecko/20090809 Shredder/3.0b4pre
In-Reply-To: <20090812075946.6117@nanako3.lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125622>

On 08/12/2009 01:59 AM, Nanako Shiraishi wrote:
>> -git-mailsplit - Simple UNIX mbox splitter program
>> +git-mailsplit - Simple UNIX mbox splitter
>>
>>   SYNOPSIS
>>   --------
>
> Sorry, but I don't understand why it is necessary.
>

It's another case where a command is called a "program" when, to the 
user, it's simply a command such as "git mailsplit". Having the word 
"command" in a command description is redundant, so I just dropped the word.

And here's another command with a similar description that I missed before:
"git-merge-one-file - The standard helper *program* to use with 
git-merge-index"
