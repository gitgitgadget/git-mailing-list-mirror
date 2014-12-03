From: Petr Bena <benapetr@gmail.com>
Subject: Re: git stash broken on MS Windows (automatically modify the files again)
Date: Wed, 3 Dec 2014 18:03:44 +0100
Message-ID: <CA+4EQ5e6464+MP7TqWMT8ceO6ZgZEE6xJPxJBfpAhoj4B-03Uw@mail.gmail.com>
References: <CA+4EQ5d70JWiawt5zb9s6Vc3cDMApPmhdB2w+WLyfmWCcTQF4g@mail.gmail.com>
	<CA+4EQ5cfC2N+e6g7wnxDZnnPj3BKTyuMj=TxX90fB7o+_EiOBQ@mail.gmail.com>
	<CA+4EQ5fbDPFuzuz_OAX1Y=zCdL76j3ah0u0BVUW2pPqjaf4kBQ@mail.gmail.com>
	<CAHb+SPAw+aeR4RsB6COhq4RMxuXJ64scY-Ez5tZPk3ziEAGm=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Aneurin Price <aneurin.price@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 18:03:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwDLB-0007gc-R9
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 18:03:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbaLCRDq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 12:03:46 -0500
Received: from mail-ie0-f176.google.com ([209.85.223.176]:41784 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991AbaLCRDp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 12:03:45 -0500
Received: by mail-ie0-f176.google.com with SMTP id tr6so14072437ieb.21
        for <git@vger.kernel.org>; Wed, 03 Dec 2014 09:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=oCLVMomPOlAd674zOKWAaSma9xqVd59zwr4nR8adjaQ=;
        b=FftRsrMVUkLvVh3ysEC/dfDNP3avvmhoUcabv6nJTy9EMu9Th/oTuP33VrVbndjaig
         WAPFCYEGV8jE7eliCb3tFswcm5t6SBsbhEKofJX2viiPS8Maz3b8L5ix9lvysCJcoxMv
         w+C97WMrEkUDTW2NSXQr7zu8X/VeDOT6jncSYDf81xhwscDbpcJuLKLwboR/qYOl5Lw1
         K3BS/N1k57j3549Stn3ZzIy64qoKSyn+G+skR0Z3Esbc0tBMfsl/heCmHIE2jaPwByar
         O1h7lnQ+SfjMPbpLRW7xgHxr1/qlXMcRIPi+qLQ2w1O3Yit4RU86agQZ0xhz8hrlK+91
         Glrw==
X-Received: by 10.107.128.87 with SMTP id b84mr5631303iod.42.1417626224538;
 Wed, 03 Dec 2014 09:03:44 -0800 (PST)
Received: by 10.107.151.141 with HTTP; Wed, 3 Dec 2014 09:03:44 -0800 (PST)
In-Reply-To: <CAHb+SPAw+aeR4RsB6COhq4RMxuXJ64scY-Ez5tZPk3ziEAGm=Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260662>

Yay

Why doesn't windows git perform some kind of check here, and doesn't
tell you a message like: this repository contains multiple files with
same name, which I can't checkout on this OS Or something like that?

On Wed, Dec 3, 2014 at 5:50 PM, Aneurin Price <aneurin.price@gmail.com> wrote:
> On 3 December 2014 at 14:48, Petr Bena <benapetr@gmail.com> wrote:
>> Only solution so far was to clone on linux, remove the folder which
>> contains these files and push them, then I had to delete the whole
>> repository on windows and clone it again.
>>
>> If I checkout any revision which contains these files repository get
>> broken in a way that only solution is deleting it from disk and
>> cloning again. Is this a bug?
>>
>
> <snip>
>
>>> fatal: Will not add file alias 'BSS/export_home_oracle/scripts_IDAEU001/Audit/au
>>> dit_off.sql' ('BSS/export_home_oracle/scripts_IDAEU001/audit/audit_off.sql' alre
>>> ady exists in index)
>>>
>
> On your Linux machine (and in the repository), do you actually have
> both 'BSS/export_home_oracle/scripts_IDAEU001/Audit' and
> 'BSS/export_home_oracle/scripts_IDAEU001/audit' directories?
