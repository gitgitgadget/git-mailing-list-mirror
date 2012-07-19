From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [PATCH 2/7] autoconf: GIT_CONF_APPEND_LINE -> GIT_CONF_SUBST
Date: Thu, 19 Jul 2012 09:32:53 +0200
Message-ID: <5007B825.3040609@gmail.com>
References: <cover.1342649928.git.stefano.lattarini@gmail.com> <5c4e73c3bed1a7c9135a6229d8d66aa2c61e319a.1342649928.git.stefano.lattarini@gmail.com> <7v7gu0wqtk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 19 09:33:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrlEN-0004Aa-Ax
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jul 2012 09:33:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751572Ab2GSHc7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jul 2012 03:32:59 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:58858 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750866Ab2GSHc6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2012 03:32:58 -0400
Received: by bkwj10 with SMTP id j10so2127956bkw.19
        for <git@vger.kernel.org>; Thu, 19 Jul 2012 00:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=L3m5Km2k0cyDSdvbCgKGMYZIuttuF0ZW0H/tmofJEU8=;
        b=LgPVd38vuiCpyHvIUx6rm/4sSmf/VU+54ht+EoHKXjbIbsKYcI1wOtbnCnwZua/3U4
         NUcvmfZeVlfUcqELfWryiA3Nv83C65oMHkwKN37kjjRAIUbfacZpX0tiaqZDVZ+WTQsV
         oM9ggCGANtBd2ia9H6fUtDd5NuAgLJCH5uXfA7y3ddZsYP7xZaulWT5Wag3deZcAyw+z
         3SpmjaVnA20LCwtYKTqO19cIiuaPSxSBPrhly+hIoJeUbr2Kvwn4P3r2LhORy6SSxQ82
         Jd0VCOKCqkUscfqV+K7i2997icF90ItOwATX1kTXQG/UIF+0I5m+rcRz2PV455Uai455
         5+Hg==
Received: by 10.204.152.206 with SMTP id h14mr255547bkw.36.1342683176932;
        Thu, 19 Jul 2012 00:32:56 -0700 (PDT)
Received: from [192.168.178.21] (host105-96-dynamic.4-87-r.retail.telecomitalia.it. [87.4.96.105])
        by mx.google.com with ESMTPS id t23sm406775bks.4.2012.07.19.00.32.54
        (version=SSLv3 cipher=OTHER);
        Thu, 19 Jul 2012 00:32:55 -0700 (PDT)
In-Reply-To: <7v7gu0wqtk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201716>

On 07/19/2012 02:13 AM, Junio C Hamano wrote:
> Stefano Lattarini <stefano.lattarini@gmail.com> writes:
> 
>> The new name fits better with the macro signature, and underlines the
>> similarities with the autoconf-provided macro AC_SUBST (which will be
>> made even more pronounced in planned future commits).
>>
>> Once again, no semantic change is intended, and indeed no change to the
>> generated configure script is expected.
>>
>> Signed-off-by: Stefano Lattarini <stefano.lattarini@gmail.com>
>> ---
>>  configure.ac | 24 ++++++++++++------------
>>  1 file changed, 12 insertions(+), 12 deletions(-)
>>
>> diff --git a/configure.ac b/configure.ac
>> index 14c7960..789926f 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -3,10 +3,10 @@
>>  
>>  ## Definitions of private macros.
>>  
>> -# GIT_CONF_APPEND_LINE(LINE)
>> +# GIT_CONF_SUBST(LINE)
> 
> I see that [PATCH 1/7] needs to be updated so that it describes the
> new two-argument form of GIT_CONF_APPEND_LINE(VAR, VAL), and this
> patch needs to be updated for GIT_CONF_SUBST() with the same.
>
Oops, you're right.  I will fix that in the re-roll.

>>  # --------------------------
>>  # Append LINE to file ${config_append}
> 
> Also the description definitely wants to be updated; it is no longer
> LINEness that matters.
> 
> Other than that, 1 & 2 looked very nice and sensible.
>
Thanks!

Regards,
  Stefano
