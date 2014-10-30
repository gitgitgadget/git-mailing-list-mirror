From: Cong Wang <xiyou.wangcong@gmail.com>
Subject: Re: Editing git changelog automatically
Date: Wed, 29 Oct 2014 23:13:16 -0700
Message-ID: <CAM_iQpWAHtTOXsiGPbQOMs4x9VBMaFOXMUYaSZi4V1aFrvTgUg@mail.gmail.com>
References: <CAM_iQpWNQbv_GTT+H5KNCqqRS3qWfBuBge4+ZTAS_WiaREku4w@mail.gmail.com>
	<1414389944.7883.2.camel@spirit>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Thu Oct 30 07:13:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xjiz9-0005MB-6u
	for gcvg-git-2@plane.gmane.org; Thu, 30 Oct 2014 07:13:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751590AbaJ3GNR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2014 02:13:17 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:40729 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914AbaJ3GNR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2014 02:13:17 -0400
Received: by mail-ob0-f171.google.com with SMTP id wp18so3665151obc.16
        for <git@vger.kernel.org>; Wed, 29 Oct 2014 23:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=mYJV4xT0RtbccNvEt9aBN/mtHRbjjRUc4GR1pNHnbvM=;
        b=z/15fW2b0s3ThIoOXffc/y/SeknGdnGIR7Iyd7Ji2bmW9qqgwBut+aycQa4Aeswgmb
         aPXitSca8/8dcP0Zz26kWHnWgwZlGbslH7LVJ7puUeZBa/4+xHmGcCrEZ8kaIPcG34k+
         R0phUgZsTsX8kwfPdLvXtLp07DLNibyAj9ywZDdkR/bAHg5XsQQKQU6jKUfSOfwDm+vh
         yIwUFr5hnamowuoH2GJeMDbRXZQMluAaoAWE/F/NZKokJN0Pr32XGldW6wRbOv6t8TvD
         MHtUESaLVOhz6Oh4zeCDvhJeNVToi9NxgsRohD9p72c30qCabqepC8sUw8ObAEGU1by2
         CEXQ==
X-Received: by 10.182.71.77 with SMTP id s13mr12794087obu.43.1414649596517;
 Wed, 29 Oct 2014 23:13:16 -0700 (PDT)
Received: by 10.182.27.72 with HTTP; Wed, 29 Oct 2014 23:13:16 -0700 (PDT)
In-Reply-To: <1414389944.7883.2.camel@spirit>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 26, 2014 at 11:05 PM, Dennis Kaarsemaker
<dennis@kaarsemaker.net> wrote:
> On zo, 2014-10-26 at 22:27 -0700, Cong Wang wrote:
>>
>> My question is how to edit dozens of git commit changelogs
>> automatically?
>
> You can use git filter-branch in --msg-filter mode.

This is exactly what I am looking for. Good to know this git command.

Thanks!
