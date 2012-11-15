From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2012, #03; Tue, 13)
Date: Thu, 15 Nov 2012 18:34:42 -0500
Message-ID: <50A57C12.8080001@gmail.com>
References: <20121113175205.GA26960@sigill.intra.peff.net> <50A2B14C.9040608@web.de> <50A53CF0.7040809@ramsay1.demon.co.uk> <50A54406.5080309@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Nov 16 00:35:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZ8xY-0001zT-1M
	for gcvg-git-2@plane.gmane.org; Fri, 16 Nov 2012 00:35:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918Ab2KOXeq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Nov 2012 18:34:46 -0500
Received: from mail-vb0-f46.google.com ([209.85.212.46]:64471 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750794Ab2KOXep (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2012 18:34:45 -0500
Received: by mail-vb0-f46.google.com with SMTP id ff1so2299019vbb.19
        for <git@vger.kernel.org>; Thu, 15 Nov 2012 15:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=NIteryNqclmCC9ZFuDOHouiB0iNZzLYXnMXHKBpZyps=;
        b=l/MnTAU+ua+0h+8z8tcw/CqlID8K5vbeRFmY/VghXHuBcqdCH4ytYjOtvO3UF0hHpe
         VYgDaPLWhhwtu35zZPv+oeWcWqolAiL6oFIiIF7Wdn66MA8Ux/jl9sEtzAvLK+jpvSEw
         TtuQ96BFjhu21RiH190J6uEPvPVXUd0MJO7yr3Vqb5jsbgbhPFJRG2azfGM2MuTkAQk/
         ZuRU0EUBTj6wMYguTrxMgyw7+sgm9L9i8egrhg8IukvWDwUdqRyoTFWkkT5+VHQrgqwq
         NcxxeJ2zmzuGsGwm4ZtIVFsXPur9sYftjkI0DX5dYjFMV+MymY0nTB8HM0zuuA2OXFGr
         ATmA==
Received: by 10.220.151.138 with SMTP id c10mr3687282vcw.56.1353022484816;
        Thu, 15 Nov 2012 15:34:44 -0800 (PST)
Received: from mark-laptop.lan (pool-173-79-107-139.washdc.fios.verizon.net. [173.79.107.139])
        by mx.google.com with ESMTPS id t12sm14423975vdi.18.2012.11.15.15.34.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 15 Nov 2012 15:34:43 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121029 Thunderbird/16.0.2
In-Reply-To: <50A54406.5080309@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209854>

On 11/15/2012 02:35 PM, Torsten B=C3=B6gershausen wrote:
> On 11/15/2012 08:05 PM, Ramsay Jones wrote:
>>
>> Did the cygwin project not bump an api version number somewhere?
>>
>> ATB,
>> Ramsay Jones
> Ramsay,
> you can run uname -r to see the version number.
>
> I myself haven't fully understood all the consequences,
> somewhere between 1.7.7 and 1.7.17 the include files had been changed=
=2E
>
> If this has consequences for using e.g. winsock2.dll, I want to know=20
> myself ;-)
>
> /Torsten
>
>
uname -r gives the version of the dll, not of any particular package,=20
and all of the various components are versioned independently. The=20
win32api is spread across several packages, and the recent update=20
changed the names, There is no api number advertised. You could check=20
the names of currently installed packages if you assume those names=20
won't change, but any such method is going to be fragile (and very=20
unsupported).

Mark
