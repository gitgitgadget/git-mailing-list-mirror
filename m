From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] Documentation/init-db.txt: minor style and synopsys fixes
Date: Thu, 15 Jan 2015 13:00:43 -0500
Message-ID: <CAPig+cQumvDFc6LuiAWGO4d9LeZmtNr6Os6oRGSrGU8LPsiymA@mail.gmail.com>
References: <1421317918-11677-1-git-send-email-kuleshovmail@gmail.com>
	<CAPig+cTHDf6S-R6DEZ3mV+wNhn9KojsoMy_ogg7wG4aPWnvUpA@mail.gmail.com>
	<CANCZXo6j6zXX8yrBV=OZpxZPzsf701f79YyQgvWJ+kQ3Dj0qUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 19:00:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBoiu-0001Qn-Pb
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 19:00:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752885AbbAOSAo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 13:00:44 -0500
Received: from mail-yk0-f171.google.com ([209.85.160.171]:51893 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752636AbbAOSAo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2015 13:00:44 -0500
Received: by mail-yk0-f171.google.com with SMTP id 142so7494137ykq.2
        for <git@vger.kernel.org>; Thu, 15 Jan 2015 10:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=XzEum6Cy8sZuERBBYF3kLVz86eP098Hi34vynuhGXZY=;
        b=FZd2fITLd3Dj6R3dUgrVsD0kawGRy5m217BxuUxrkEzBoUPO/3bv2WOqfBrUen6bPs
         oJBoNmpcmJX5vFxUuOB2/053j8wS8ZrjXQdscpvSV94YXljuH45kodmDUdwJPMRg7dOT
         feYBMu6tGLz05ujcFU7g6k6A6PHjnRlDGOhd8gp21qjNfgOXrH5SoBod8B86aMxP9ZMr
         RVE78Bo7irOgKm1in1j7TuaR+QxwU5hPhGbp/a+V5pfznhsqE/HO/DmGqyX6mTeZzaq0
         GRuKYJ9cIm2cdlH6/XoylH26gQvELCUYaD/izt92X+vkcktaLla3W/LCt9v5SNqvfakr
         Q2cQ==
X-Received: by 10.236.202.238 with SMTP id d74mr6669422yho.166.1421344843499;
 Thu, 15 Jan 2015 10:00:43 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Thu, 15 Jan 2015 10:00:43 -0800 (PST)
In-Reply-To: <CANCZXo6j6zXX8yrBV=OZpxZPzsf701f79YyQgvWJ+kQ3Dj0qUA@mail.gmail.com>
X-Google-Sender-Auth: PAeuZj_OAqz17pmlzboBuHq1Ec8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262495>

On Thu, Jan 15, 2015 at 12:08 PM, Alexander Kuleshov
<kuleshovmail@gmail.com> wrote:
> Yes, right,

Etiquette on this list is to avoid top-posting [1].

> how to do it better? Something like: Documentation,
> init-db/init:.....? Or something else?

Simplest would be to split it into two patches: one for
git-init-db.txt and one for git-init.txt.

Also...

>> On Thu, Jan 15, 2015 at 5:31 AM, Alexander Kuleshov
>> <kuleshovmail@gmail.com> wrote:
>>> Subject: Documentation/init-db.txt: minor style and synopsys fixes
>>> This patch constists of two minor changes:
>>>
>>> * line-wrap 'git init-db' synopsis
>>>
>>> * last possible argument '[<directory>]' was missed
>>>
>>> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
>>> ---
>>> +'git init-db' [-q | --quiet] [--bare] [--template=<template_directory>]
>>> +            [--separate-git-dir <git-dir>]
>>> +            [--shared[=<permissions>]] [<directory>]

Taking Alex's review[2] into consideration:

s/template_directory/template-directory/

[1]: https://lkml.org/lkml/2005/1/11/111
[2]: http://article.gmane.org/gmane.comp.version-control.git/262427
