From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 04/12] ref_transaction_update(): remove "have_old"
 parameter
Date: Fri, 13 Feb 2015 18:15:33 +0100
Message-ID: <54DE3135.7070902@alum.mit.edu>
References: <1423739543-1025-1-git-send-email-mhagger@alum.mit.edu> <1423739543-1025-5-git-send-email-mhagger@alum.mit.edu> <CAPc5daX80Mk2cRNAijTckHZ-EFJhiF4GHWMxBK4wYJYSwaEe0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu40=?= =?UTF-8?B?YyBEdXk=?= 
	<pclouds@gmail.com>, Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 18:16:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YMJqP-0003CH-IB
	for gcvg-git-2@plane.gmane.org; Fri, 13 Feb 2015 18:15:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753439AbbBMRPw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2015 12:15:52 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:63470 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752469AbbBMRPv (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Feb 2015 12:15:51 -0500
X-AuditID: 1207440d-f79976d000005643-cc-54de3137ed20
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id C8.0F.22083.7313ED45; Fri, 13 Feb 2015 12:15:35 -0500 (EST)
Received: from [192.168.69.130] (p5DDB38B4.dip0.t-ipconnect.de [93.219.56.180])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t1DHFXUE020059
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 13 Feb 2015 12:15:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.4.0
In-Reply-To: <CAPc5daX80Mk2cRNAijTckHZ-EFJhiF4GHWMxBK4wYJYSwaEe0w@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsUixO6iqGtueC/EYPUHNYuuK91MFg29V5gt
	3t5cwmjRPeUto0Vv3ydWi82b21kc2Dx2zrrL7rFgU6nHxUvKHp83yQWwRHHbJCWWlAVnpufp
	2yVwZyxZ18lUMJO34sLlFqYGxm6uLkZODgkBE4kzjdPYIWwxiQv31rN1MXJxCAlcZpT4sGQu
	M4Rznkliy+aZrCBVvALaEutv3gezWQRUJbZeaGUCsdkEdCUW9TSD2aICQRKHTj9mgagXlDg5
	8wmYLSKgJjGx7RALyFBmgZlMEkfXtYGtFhYIlXg+6w47xLYDjBJ7Xv5lA0lwCgRK/Ny7FKyI
	WUBd4s+8S8wQtrxE89bZzBMYBWYhWTILSdksJGULGJlXMcol5pTm6uYmZuYUpybrFicn5uWl
	Fuka6eVmluilppRuYoSEOe8Oxv/rZA4xCnAwKvHwTvC5GyLEmlhWXJl7iFGSg0lJlPeA7r0Q
	Ib6k/JTKjMTijPii0pzU4kOMEhzMSiK8C7WAcrwpiZVVqUX5MClpDhYlcV61Jep+QgLpiSWp
	2ampBalFMFkZDg4lCd4ufaBGwaLU9NSKtMycEoQ0EwcnyHAuKZHi1LyU1KLE0pKMeFC8xhcD
	IxYkxQO0Nwaknbe4IDEXKArReopRUUqcdypIQgAkkVGaBzcWlrxeMYoDfSnMexikigeY+OC6
	XwENZgIaPHHGbZDBJYkIKakGRnO2GVmzNs3TbJpwqPLi2dQzazdoBq4++Fyc58m9jC/TS7jP
	HF279mn2QvNFyRKNXBrmq5y/TjFcKJnHb7PMc31flqiEA4vrn9XRKx4nfEjM4c4W 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263814>

On 02/12/2015 06:32 PM, Junio C Hamano wrote:
> On Thu, Feb 12, 2015 at 3:12 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> Instead, verify the reference's old value if and only if old_sha1 is
>> non-NULL.
>>
>> ...
>> @@ -3664,9 +3664,6 @@ int ref_transaction_update(struct ref_transaction *transaction,
>>         if (transaction->state != REF_TRANSACTION_OPEN)
>>                 die("BUG: update called for transaction that is not open");
>>
>> -       if (have_old && !old_sha1)
>> -               die("BUG: have_old is true but old_sha1 is NULL");
>> -
> 
> In the old world, old_sha1 here used to be one of
>  (1) NULL, (2) null_sha1[], or (3) a real object name.
> What is the rule in the new world?

The new world is explained in the docstring in refs.h, which was updated
in this same commit:

    If old_sha1 is non-NULL, then it the value
    that the reference should have had before the update, or null_sha1
    if it must not have existed beforehand.

The docstring is further revised later in the patch series to

    old_sha1 is the value that the reference must have
    before the update, or null_sha1 if it must not have existed
    beforehand. The old value is checked after the lock is taken to
    prevent races. If the old value doesn't agree with old_sha1, the
    whole transaction fails. If old_sha1 is NULL, then the previous
    value is not checked.

The new rule is extended to ref_transaction_delete() in the subsequent
commit. I like the new semantics because it removes redundancy in the
interpretation of parameters.

Is that explanation adequate?

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
