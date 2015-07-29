From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [RFC/PATCH 10/11] branch.c: use 'ref-filter' APIs
Date: Wed, 29 Jul 2015 09:18:02 +0530
Message-ID: <CAOLa=ZQee46Z+hh3E13QngGv-BJePHkUQ1bHf7JChqOTGDEVDA@mail.gmail.com>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
 <1438067468-6835-1-git-send-email-Karthik.188@gmail.com> <CAP8UFD1q5oxchNUhWc8331nAq-eVkzVOe9=56v68HcY2CDXW4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 05:48:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKIM9-0002FE-3D
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 05:48:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752592AbbG2Dsc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 23:48:32 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:35390 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752386AbbG2Dsc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 23:48:32 -0400
Received: by obbop1 with SMTP id op1so99775831obb.2
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 20:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=mdSs561sM2YW+kLXkzD8GFd71WB+29KklIGxQnxkh0k=;
        b=lqGngjDerZ47syZxTT/Bi7XogkXW5kVQN0w84dQ0tiwKBmroHtjv3kbsVfQ52xNuvu
         cdmcw4v9d4wHgaF4O9D20PtW5m5yFAtk8hlSCq5XFozvxoU8sLRDiRmzNZiW+UvLvq3i
         YneRTPDzyR3g0JvdV5Whx7JsiuzKWthB4p02Mskr4/dN7XrJxbQlKea1WMsUivTipUWL
         QkQvLAh847QZtvN7lTTKO0Om7ToL0KkFLeiiIlglnDKIbRzUigihe/fbrhTIJjQwAWG2
         X2l+qmamGk5sCYMzT5Dc9p4TsRNa1VDUdkD3bA2zdSZYTzOec65ZLjGXYC9tVsXdTzX1
         IF0w==
X-Received: by 10.182.33.38 with SMTP id o6mr37458298obi.41.1438141711656;
 Tue, 28 Jul 2015 20:48:31 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Tue, 28 Jul 2015 20:48:02 -0700 (PDT)
In-Reply-To: <CAP8UFD1q5oxchNUhWc8331nAq-eVkzVOe9=56v68HcY2CDXW4A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274880>

On Tue, Jul 28, 2015 at 1:39 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Tue, Jul 28, 2015 at 9:11 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>
>> diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
>> index a67138a..897cd81 100644
>> --- a/Documentation/git-branch.txt
>> +++ b/Documentation/git-branch.txt
>> @@ -11,7 +11,7 @@ SYNOPSIS
>>  'git branch' [--color[=<when>] | --no-color] [-r | -a]
>>         [--list] [-v [--abbrev=<length> | --no-abbrev]]
>>         [--column[=<options>] | --no-column]
>> -       [(--merged | --no-merged | --contains) [<commit>]] [<pattern>...]
>> +       [(--merged | --no-merged | --contains) [<commit>]] [--sort=<key>] [<pattern>...]
>
> Maybe: [(--[no-]merged | --contains) [<commit>]]

Thats an existing string. So not sure if this patch is the right place to
make this change.

-- 
Regards,
Karthik Nayak
