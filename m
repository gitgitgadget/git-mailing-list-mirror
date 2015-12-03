From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH/RFC 04/10] ref-filter: skip deref specifier in match_atom_name()
Date: Thu, 3 Dec 2015 12:04:23 +0530
Message-ID: <CAOLa=ZR2zQivyEDVwPxHxWvucYeGE9Z+bbe8xUYYfTgMh8ajgA@mail.gmail.com>
References: <1447271075-15364-1-git-send-email-Karthik.188@gmail.com>
 <1447271075-15364-5-git-send-email-Karthik.188@gmail.com> <CAPig+cTNshvpwn1=VSbnDE8AQMkfKmd1wnP0hNLT1iS3cDEb_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Dec 03 07:35:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4NTo-0007Wt-Le
	for gcvg-git-2@plane.gmane.org; Thu, 03 Dec 2015 07:35:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755932AbbLCGez (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Dec 2015 01:34:55 -0500
Received: from mail-vk0-f49.google.com ([209.85.213.49]:35647 "EHLO
	mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755798AbbLCGex (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Dec 2015 01:34:53 -0500
Received: by vkha189 with SMTP id a189so39527179vkh.2
        for <git@vger.kernel.org>; Wed, 02 Dec 2015 22:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=y10yCU3pyS7Gix7n4pvc3cLEBAFxRm9T/U7AId1e2C8=;
        b=EvpBVWnhN+eRRWNDLKBRL0GEBME5KuC/vwtv3ZFJPbCopq4Qd50KNdk2+9R79NVFPu
         AcveFh+pvKmgqRm7xa11+mDr6IsKoQ3nkcSCjfIVkekIcGsBb8vDI//gsGG6Z7s6PFyn
         39Gzg9g5sRXHS0CQkUmG2WC9Q6kCjqQeqowWbapwra4zDy2SKI0j7KQxK2z0Qn1Kqhl+
         rOTTPxOPfVoputvg2Ec8iTG1RMC+6ZhyLJstSHsZwQgQVbGoHKeP/xgI58BWeZpCqgSb
         23CFe1mQOdUopCJGZAdTF1CeqAd26LeqLQFbySi1Yfo6vwPQ5oRqQECMEFflWmssPUB/
         1Kng==
X-Received: by 10.31.155.23 with SMTP id d23mr4136238vke.146.1449124492357;
 Wed, 02 Dec 2015 22:34:52 -0800 (PST)
Received: by 10.103.97.199 with HTTP; Wed, 2 Dec 2015 22:34:23 -0800 (PST)
In-Reply-To: <CAPig+cTNshvpwn1=VSbnDE8AQMkfKmd1wnP0hNLT1iS3cDEb_A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281946>

On Wed, Dec 2, 2015 at 4:41 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Nov 11, 2015 at 2:44 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
>
> A bit of explanation about why this change is desirable would be
> welcome. I'm guessing it's because a future patch is going to make
> calls to match_atom_name() with the '*' deref indicator still attached
> to the name, whereas existing code does not do so.
>

Yes, you're correct!
Will add this in, thanks.

-- 
Regards,
Karthik Nayak
