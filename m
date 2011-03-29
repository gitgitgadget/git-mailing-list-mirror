From: Maxin john <maxin@maxinbjohn.info>
Subject: Re: [PATCH] Remove "bashism" from contrib/thunderbird-patch-inline/appp.sh
Date: Tue, 29 Mar 2011 09:54:37 +0300
Message-ID: <AANLkTikaZA=7EFMVf1hwEoQJd6hChha0cCL7ZRMEZXyS@mail.gmail.com>
References: <AANLkTin-USDnTxeKT_KOZW5kgC0vFXYbMNP9ct6fzbUC@mail.gmail.com>
	<4D9103D3.5010403@zoho.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?=C1ngel_Gonz=E1lez?= <ingenit@zoho.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 08:54:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4SpI-0003O2-Tf
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 08:54:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752206Ab1C2Gyj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Mar 2011 02:54:39 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:54764 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750878Ab1C2Gyi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Mar 2011 02:54:38 -0400
Received: by yia27 with SMTP id 27so1478513yia.19
        for <git@vger.kernel.org>; Mon, 28 Mar 2011 23:54:38 -0700 (PDT)
Received: by 10.151.113.14 with SMTP id q14mr4808761ybm.112.1301381677991;
 Mon, 28 Mar 2011 23:54:37 -0700 (PDT)
Received: by 10.150.139.2 with HTTP; Mon, 28 Mar 2011 23:54:37 -0700 (PDT)
X-Originating-IP: [91.154.177.92]
In-Reply-To: <4D9103D3.5010403@zoho.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170233>

Hi,

Thank you very much for the suggestions. However, I have tested this
script in Ubuntu which uses dash as /bin/sh

Eg: the following script runs successfully in Ubuntu 10.10

#!/bin/dash

PATCH=3D$(zenity --file-selection)

if [ "$?" !=3D "0" ] ; then
 echo "zenity failed"
else
 echo "success"
fi

I haven't confirmed this in other shell implementations. Please let me
know your comments on this.

Best Regards,
Maxin B. John

2011/3/29 =C1ngel Gonz=E1lez <ingenit@zoho.com>:
> Maxin john wrote:
>> Remove "bashism" and minor corrections for
>> contrib/thunderbird-patch-inline/appp.sh
>>
>> Signed-off-by: Maxin B. John <maxin@maxinbjohn.info>
>
> This is wrong.
>
> You are replacing bash with sh:
>> -#!/bin/bash
>> +#!/bin/sh
>
> but the script still uses bash-specific syntax (aka. bashishms):
>> +
>> =A0PATCH=3D$(zenity --file-selection)
>>
>> =A0if [ "$?" !=3D "0" ] ; then
>
> So with your change the script won't be able to run on systems which
> don't have bash as /bin/sh
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
