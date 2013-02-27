From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH] diff: prevent pprint_rename from underrunning input
Date: Wed, 27 Feb 2013 14:27:15 +0100
Message-ID: <CALWbr2zq9WzQiry0U+G0mpQOqd838r8+GYJ91601MBMp=D94xA@mail.gmail.com>
References: <1361638125-11245-1-git-send-email-apelisse@gmail.com>
	<d74fcfa693e5feb7249023feda8d3ad1f22ab16d.1361911196.git.trast@student.ethz.ch>
	<7vsj4ilphz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Rast <trast@student.ethz.ch>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 27 14:27:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UAh2s-00083I-69
	for gcvg-git-2@plane.gmane.org; Wed, 27 Feb 2013 14:27:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759943Ab3B0N1R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2013 08:27:17 -0500
Received: from mail-qe0-f43.google.com ([209.85.128.43]:46892 "EHLO
	mail-qe0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756626Ab3B0N1Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2013 08:27:16 -0500
Received: by mail-qe0-f43.google.com with SMTP id 1so264590qee.30
        for <git@vger.kernel.org>; Wed, 27 Feb 2013 05:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=RlJhfOYb5QDTU1D4L3O3tfkmK6Wq9Vqtd5QrtI/THdY=;
        b=Bq8hiEA8dy30WM2TCXWoKlWFf2VkeDywflwWosWzWEdB+VVsCXfgU3kGXek1lOsumZ
         eX1GP6slcy3exqQgGduLKK8Nd1nPjcYm4BT/LuFXgX6Z/wBfZo+VepbQBDLMdUZyXQxE
         9e8COJA9K+4xnj/TQrIImJ0ptrONT6gxjxNsJaN/0MPUqivtHeHMtHvhHlUWd/ufkjZA
         ET4odsROCtPJS04aTWmUijvuGjJFrWw4vg6Eqm2ATysaPcX9nifJWZFyuqpKtVuLAfjT
         0iGBSv5FNnEKAlXZjL5Ahggb97K2JNA6ynoZ+7nPvwgksFuHzUW7jCT4syxZPPF48egN
         YqyA==
X-Received: by 10.229.198.92 with SMTP id en28mr681498qcb.139.1361971635412;
 Wed, 27 Feb 2013 05:27:15 -0800 (PST)
Received: by 10.49.70.163 with HTTP; Wed, 27 Feb 2013 05:27:15 -0800 (PST)
In-Reply-To: <7vsj4ilphz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217203>

>> The logic described in d020e27 (diff: Fix rename pretty-print when
>> suffix and prefix overlap, 2013-02-23) is wrong: The proof in the
>> comment is valid only if both strings are the same length.  *One* of
>> old/new can reach a-1 (b-1, resp.) if 'a' is a suffix of 'b' (or vice
>> versa).

Indeed, sorry about that. I guess I was too focused on my specific
issue and didn't broaden my thoughts.

> Thanks.  I was also having hard time convincing myself why that -1
> does not under-run yesterday.
>
> Will queue.

Thanks
