From: Alex Henrie <alexhenrie24@gmail.com>
Subject: Re: [PATCH] Documentation/init-db.txt: minor style and synopsys fixes
Date: Wed, 14 Jan 2015 14:01:17 -0700
Message-ID: <CAMMLpeRScVE=TNuc9L6iKRP2GMMR4qmdo6gm6kWGsRRA31EA5Q@mail.gmail.com>
References: <1421256839-28660-1-git-send-email-kuleshovmail@gmail.com> <CAPig+cSgXQrsmi7D7crxHuRvDgu_1Oq32dtNsvqX+o1+-A7eYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Alexander Kuleshov <kuleshovmail@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Jan 14 22:01:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBV4S-0007wz-DH
	for gcvg-git-2@plane.gmane.org; Wed, 14 Jan 2015 22:01:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753909AbbANVBk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 16:01:40 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:60805 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751390AbbANVBj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 16:01:39 -0500
Received: by mail-ie0-f174.google.com with SMTP id at20so11266207iec.5
        for <git@vger.kernel.org>; Wed, 14 Jan 2015 13:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=BUsaibUoLoCeMa3YdbAjf4Vys6Q8I/ATiHxWw8VMjac=;
        b=JN/UN6HcA6wj94a6lbIs7EozwTX7a8rC9nDxB+Y2JVMmchmoapBi9vnmlai597A62y
         XCneH3ij0++wSaVQgUC1zcVI7kSz4Jqvi1e3bd2sXm/aC4aNTNCzPNKbQDH5MrM0Ieab
         jbLuN+DHXaJ9dRdVi/uXINhEnFtDsdlMTvhzP/+NHwUdiuMRoacgaGUepSpnKLPFqYi5
         yuDb9oZEVfrUt5nBG6rzpjCwDm4jO1ehP5c9DzGn3QFVwOgEdBq4rmJYpa7RXlcO6sKe
         kSAzJJvxqLF8GtxZ/sQXJMONCo4FZJih1T2kcPkN9lrvRy+hkQEHnfhgCj7/5BpTH3/k
         wbHQ==
X-Received: by 10.107.135.34 with SMTP id j34mr6430653iod.84.1421269299010;
 Wed, 14 Jan 2015 13:01:39 -0800 (PST)
Received: by 10.107.128.194 with HTTP; Wed, 14 Jan 2015 13:01:17 -0800 (PST)
In-Reply-To: <CAPig+cSgXQrsmi7D7crxHuRvDgu_1Oq32dtNsvqX+o1+-A7eYA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262427>

2015-01-14 13:47 GMT-07:00 Eric Sunshine <sunshine@sunshineco.com>:
> On Wed, Jan 14, 2015 at 12:33 PM, Alexander Kuleshov
> <kuleshovmail@gmail.com> wrote:
>> -'git init-db' [-q | --quiet] [--bare] [--template=<template_directory>] [--separate-git-dir <git dir>] [--shared[=<permissions>]]
>> -
>> +'git init-db' [-q | --quiet] [--bare] [--template=<template_directory>]
>> +                         [--separate-git-dir <git dir>]
>> +                         [--shared[=<permissions>]] [directory]
>
> I realize that you copied/pasted the text from git-init.txt, but this
> should really be [<directory>].

We're also transitioning to using hyphens to separate words in
template placeholders, so here you would have <template-directory> and
<git-dir>.

-Alex
