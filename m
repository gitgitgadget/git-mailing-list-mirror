From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v4 01/10] ref-filter: add option to align atoms to the left
Date: Mon, 27 Jul 2015 00:39:10 -0700
Message-ID: <CA+P7+xob8eUf=oJHYN3fBB3k+XX+Jj8Vy0fKLtVQUGdsWDyaKA@mail.gmail.com>
References: <1437764685-8633-1-git-send-email-Karthik.188@gmail.com>
 <1437764685-8633-2-git-send-email-Karthik.188@gmail.com> <CAPig+cQSy6imD_z+a9tvprJtn2-20awLJOcUQAksyv6HceVzxQ@mail.gmail.com>
 <CACsJy8Bq3y25QsQbntpNcVz=TQziiXY-XQ88Y_Cps10YF8zrJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 27 09:39:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJd0Z-0003Eb-5p
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jul 2015 09:39:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbbG0Hjb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2015 03:39:31 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:37606 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897AbbG0Hja (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2015 03:39:30 -0400
Received: by igbpg9 with SMTP id pg9so65958108igb.0
        for <git@vger.kernel.org>; Mon, 27 Jul 2015 00:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=sUYUWQ9KrlAG8S2jCELenWJOWQQFfQw4LunIBf6jwn4=;
        b=NZG55xPFjeuZ5jXT27t0ocy3lB4Yh1Rf7AIDlzWxWvZv5UUDcKYDz34HiRenvIiVHM
         ZwStle+F39AxcpBEhLDqbR5Od0rGGxpmJilwEd1F24IRXqaE2afixPJG8fhHlEMN97n4
         vmuNV6ufcEcHutYY/8Q+2+B8HAKSInClOI4Q92fhblWHPLW3NQA4cIkqfPHvYHsxtJJL
         JPhl5THAxPyW/y3bzsKwLSfs4OezfmdLVjQ43bQC8aqKupv/rH9r5fNCzlvTV8kZ7HAA
         r10YLrfmycA/GfKYYWQsFnh7qyY8qAh1f29T46hrRm33ZeJmlKrIQ63Oz4CU4OspRzXw
         OMCg==
X-Received: by 10.107.136.160 with SMTP id s32mr41027252ioi.174.1437982770212;
 Mon, 27 Jul 2015 00:39:30 -0700 (PDT)
Received: by 10.107.5.203 with HTTP; Mon, 27 Jul 2015 00:39:10 -0700 (PDT)
In-Reply-To: <CACsJy8Bq3y25QsQbntpNcVz=TQziiXY-XQ88Y_Cps10YF8zrJA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274662>

On Sun, Jul 26, 2015 at 5:39 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sun, Jul 26, 2015 at 11:08 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> You can generate an interdiff with "git diff branchname-v4
>> branchname-v5", for instance.
>
> Off topic. But what stops me from doing this often is it creates a big
> mess in "git tag -l". Do we have an option to hide away some
> "insignificant:" tags? reflog might be an option if we have something
> like foo@{/v2} to quickly retrieve the reflog entry whose message
> contains "v2".
> --
> Duy
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

You can normally find the previous commit via the reflog. Various
changes to the settings can make the reflog be maintained for longer
if you have longer lived patch series. That's how I would suggest it,
rather than branches, as I tend not to keep old versions around on
separate tags or branches.

The problem with "foo@{/v2}" is that people don't always keep values
inside the message it self, but maybe "foo@{/pattern}" would be a
useful extension?

Regards,
Jake
