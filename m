From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v4 01/10] ref-filter: add option to align atoms to the left
Date: Tue, 28 Jul 2015 17:35:44 +0700
Message-ID: <CACsJy8DMAUfOPHRZuOhf1dLABqhb_aP3LOLqBE7xo3_aMMSyYg@mail.gmail.com>
References: <1437764685-8633-1-git-send-email-Karthik.188@gmail.com>
 <1437764685-8633-2-git-send-email-Karthik.188@gmail.com> <CAPig+cQSy6imD_z+a9tvprJtn2-20awLJOcUQAksyv6HceVzxQ@mail.gmail.com>
 <CACsJy8Bq3y25QsQbntpNcVz=TQziiXY-XQ88Y_Cps10YF8zrJA@mail.gmail.com>
 <CA+P7+xob8eUf=oJHYN3fBB3k+XX+Jj8Vy0fKLtVQUGdsWDyaKA@mail.gmail.com> <CACsJy8Dr29B7Lei-jFqgPViZwd6BZcJde0jkcAwySYcY2v8QqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 12:36:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZK2FE-00010F-85
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 12:36:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755836AbbG1KgP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 06:36:15 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:35670 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755818AbbG1KgO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 06:36:14 -0400
Received: by igr7 with SMTP id 7so110314898igr.0
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 03:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=jwDvTXb4iFUDB8isrpPm7mwEicKgmOR5CYY1Dd+D8Os=;
        b=J6P/9psgSqhW5RAdfMOAg+lqbiyeKfuY2aJSCvhdAMKYXmuHcwdFUhHo35OwFkKJH/
         SnGSB+rs9DUnsLS3w1RUukajUDJh91ngw7v8V/Y3Ksx3B3+HzyJ+9Y91x6NAsiXem9rf
         gXRebHvKJVRw+BXazrmJKrSTGm8reLZt2+sRgF6Ow7Qbzbq73NUcIc/iSRE+M/HSfbHa
         QAv0wxVZHf+kjPCKfkelUSmh7iViZqZHgze4vS2IqyuKb2WJKf026kSSAQy+lT1Y+Kg+
         k6MHOZOFCwPRDeMpcjnaOD55x6vJZjT4BS3Xk9w6Q96hsYV3thbjM8rCuaFXfntqiMYl
         Jzbw==
X-Received: by 10.107.134.22 with SMTP id i22mr52118351iod.111.1438079773412;
 Tue, 28 Jul 2015 03:36:13 -0700 (PDT)
Received: by 10.107.191.193 with HTTP; Tue, 28 Jul 2015 03:35:44 -0700 (PDT)
In-Reply-To: <CACsJy8Dr29B7Lei-jFqgPViZwd6BZcJde0jkcAwySYcY2v8QqA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274765>

On Mon, Jul 27, 2015 at 5:18 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Mon, Jul 27, 2015 at 2:39 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
>> On Sun, Jul 26, 2015 at 5:39 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>>> On Sun, Jul 26, 2015 at 11:08 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>>> You can generate an interdiff with "git diff branchname-v4
>>>> branchname-v5", for instance.
>>>
>>> Off topic. But what stops me from doing this often is it creates a big
>>> mess in "git tag -l". Do we have an option to hide away some
>>> "insignificant:" tags? reflog might be an option if we have something
>>> like foo@{/v2} to quickly retrieve the reflog entry whose message
>>> contains "v2".
> ...
>
> But maybe we're abusing reflog..

Actually a good place for this stuff is "git branch
--edit-description". A lot of manual steps to save old refs, do
inter-diff.. but it's probably good enough.
-- 
Duy
