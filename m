From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v14 6/6] commit: add a commit.verbose config variable
Date: Wed, 13 Apr 2016 14:45:31 +0530
Message-ID: <CAFZEwPN+N+21CN+P3oegaxEve59BKHabdfyM_c7QdjV+bonpQA@mail.gmail.com>
References: <010201540cb60832-9402a692-3caa-47a1-9e8e-ae5a1bc7eb2f-000000@eu-west-1.amazonses.com>
	<010201540cb60966-e9711378-3b22-4fbb-a2c7-f6876a6fb3c6-000000@eu-west-1.amazonses.com>
	<CAPig+cTcCyGu5Y8aHbE3i6fXh3T_mD0ZiuxPFh=DVHOE38pE5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 11:15:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqGtf-0004nr-Oq
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 11:15:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759719AbcDMJPe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 05:15:34 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:34518 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759597AbcDMJPc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 05:15:32 -0400
Received: by mail-yw0-f194.google.com with SMTP id h6so5789922ywc.1
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 02:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=O4XSexOGJegoj14h2zIAHZ6XNBXCULw4kMxOZORQ3bo=;
        b=zgdYRRBoEPTtLFA8SkQ2DWPP9RwxgAM3coN6ljbxIhhTG81O1KfvwEPz76CZ/S8v9K
         dbo0zoAsH828hubPTV6jRrQUvTQLsNECpM8+Ke4iPioGvHE9AEq3iv8WVYh/KaUfcG3s
         lOzJJmSm2Xu5HHfP+mAqSgdFnolH8fjZB78jPdGlInlIFWY1SZi/EsvZibtKmTyrfGKv
         6TqRgZ2a8dzqfCq4teIPZapyYmKn1f4roKA0xHdslg+NKcUa9yFeTGP5tVyRZ//TNDkL
         0r0zKjPV56EnEoXcVZCOE2bZ9wmnWukTXX4Y5wzg2VWbxj7fSlVvb3bG86tzpFlTBSPN
         ALgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=O4XSexOGJegoj14h2zIAHZ6XNBXCULw4kMxOZORQ3bo=;
        b=Sm+VMkf87pRJiNm7IJEwGZfcQnetEOG245zxiNvqCm6mZfA5jPSXGr18sqZ7QDjH2S
         j8gS+UxYNMAjt/F6NzLt1m9AZXRWvwykAjOGDVZbFAZ9bNHzYZPW7B2xOeUUrHrs3AaR
         jIojZRd8fkWb8KvElvkSSpxJzhEekdE7NRPq2DHTRcgtBlqc2pMgelrd3DHGFR5wvQn/
         gSQ+D8tcjJDWboQd8BYjyG7cFZlC+zJUYY8mm7D8CJMvhPoRDXmPsktzS9pO3kOW3Tl3
         MlF7CR9JD7xKlCsQUd4ysJavtqWPAZM9wybyOw/+X8jJoYNUO7AH1ZmguCPeSPG2Pf9T
         55OQ==
X-Gm-Message-State: AOPr4FULlNw33vIs6M9X6L7fPy6nxtl2xwRvSM2R9qc1OrBPbCVolWi87ZRzdogvnVomrt0DGcES9iW080jnOg==
X-Received: by 10.129.93.193 with SMTP id r184mr4258515ywb.68.1460538932053;
 Wed, 13 Apr 2016 02:15:32 -0700 (PDT)
Received: by 10.13.219.81 with HTTP; Wed, 13 Apr 2016 02:15:31 -0700 (PDT)
In-Reply-To: <CAPig+cTcCyGu5Y8aHbE3i6fXh3T_mD0ZiuxPFh=DVHOE38pE5w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291383>

On Wed, Apr 13, 2016 at 11:44 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, Apr 12, 2016 at 7:02 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>
>> +test_expect_success 'status does not verbose without --verbose' '
>> +       git status >actual &&
>> +       ! grep "^diff --git" actual
>> +'
>
> But what is this test checking?

status is also a consumer of the verbose whose initial value is set to
-1. This makes it include verbose in status output. This bug was fixed
by explicitly initializing verbose to 0 if -1. SZEDER pointed out a
bug[1] which broke some tests in and then when I fixed it, you
requested me to include tests even in this patch[2] which I found
convincing enough.

[1]: http://article.gmane.org/gmane.comp.version-control.git/289730
[2]: http://article.gmane.org/gmane.comp.version-control.git/289993
