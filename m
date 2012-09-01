From: Marco Stornelli <marco.stornelli@gmail.com>
Subject: Re: [PATCH v4] Thunderbird: fix appp.sh format problems
Date: Sat, 01 Sep 2012 21:18:35 +0200
Message-ID: <50425F8B.5020406@gmail.com>
References: <5040C59A.6090303@gmail.com> <50412E2D.7070503@kdbg.org> <5041BC94.7000304@gmail.com> <504214AA.9080706@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Sep 01 21:26:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7tKU-00060f-FD
	for gcvg-git-2@plane.gmane.org; Sat, 01 Sep 2012 21:26:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755440Ab2IATZQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Sep 2012 15:25:16 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:40927 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754554Ab2IATZP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Sep 2012 15:25:15 -0400
Received: by weyx8 with SMTP id x8so2253924wey.19
        for <git@vger.kernel.org>; Sat, 01 Sep 2012 12:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=SuLTGXesId81nADntirbO7NwrHHOih/Cr4cKJL1jEv0=;
        b=hhQZ3/uE7TDsOnFtivrm3QpM2/6nVdOhYs66vaLUMORneDGKKuegBup4B5Ixt3g0k9
         9hcgJAB3/VxwpsnDKh2K7yWGy+dLZjgc5xqLCDRj6cKG61Qmd/HjHnudM1Kc/KNISh2s
         1dqfWum/shk+tt/UEdMFkjgRECk+QTO4YILp36xo5RvN3Ex5sNjJkFxaQl7zDY8G0EwZ
         I38xnUl4Tcl2iI4iqqT2hlQQY4zbx8a0OeI1vB9bB+7QTQaSLmdpdSibRnZG4wqLUctW
         Xgpha5XggIRjVFatkiMbowVJd0kr2B1YyykWjrZUnBWI4bq6HXR9RTsqjMRE7Tm6HzIO
         ekAw==
Received: by 10.216.242.196 with SMTP id i46mr5954814wer.125.1346527513600;
        Sat, 01 Sep 2012 12:25:13 -0700 (PDT)
Received: from [82.49.194.162] (host162-194-dynamic.49-82-r.retail.telecomitalia.it. [82.49.194.162])
        by mx.google.com with ESMTPS id k20sm8782810wiv.11.2012.09.01.12.25.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 01 Sep 2012 12:25:12 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:13.0) Gecko/20120601 Thunderbird/13.0
In-Reply-To: <504214AA.9080706@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204648>

Il 01/09/2012 15:59, Johannes Sixt ha scritto:
> Am 01.09.2012 09:43, schrieb Marco Stornelli:
>> Il 31/08/2012 23:35, Johannes Sixt ha scritto:
>>> Am 31.08.2012 16:09, schrieb Marco Stornelli:
>>>> +CCS=`perl -e 'local $/=undef; open FILE, $ENV{'PATCHTMP'};
>>>> $text=<FILE>;
>>>> +close FILE; $addr = $1 if $text =~ /Cc: (.*?(,\n .*?)*)\n/s; $addr
>>>> =~ s/\n//g;
>>>> +print $addr;'`
>>>
>>> The quoting is broken in this line (sq within sq does not work).
>>
>> I don't understand what you mean, I'm using this script and it works
>> perfectly.
>
> Look how you write:
>
>    perl -e '... $ENV{'PATCHTMP'} ...'
>
> That is, perl actually sees this script:
>
>    ... $ENV{PATCHTMP} ...
>
> (no quotes around PATCHTMP). That my be perfectly valid perl, but is not
> what you intended.
>
> -- Hannes
>
>

I don't understand what you mean when you say "is not what you intended" 
because perl and this script does *exactly* what I want and (with the 
test I've done) it works. Have you got a test case where it doesn't work 
at all? However, since I'm not a perl guru, if someone says that double 
quotes are needed, ok the result is however the same.

Git guys, let me know if a version 6 of the patch is needed, no problem 
to submit another version.

Regards,

Marco
