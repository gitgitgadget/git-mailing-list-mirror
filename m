From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: .gitignore sub-dir exclusions not overriding '*'
Date: Wed, 19 Nov 2014 16:48:16 +0700
Message-ID: <CACsJy8BHvucnEAW065OXOe5NBQkxp7+8HJb7XCGYgOa=pkxLVA@mail.gmail.com>
References: <20141119034010.GA18145@tower.spodhuis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Phil Pennock <phil-gitml@phil.spodhuis.org>
X-From: git-owner@vger.kernel.org Wed Nov 19 10:48:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xr1sb-0006mU-UN
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 10:48:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755093AbaKSJst (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2014 04:48:49 -0500
Received: from mail-ig0-f174.google.com ([209.85.213.174]:39591 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751265AbaKSJss (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2014 04:48:48 -0500
Received: by mail-ig0-f174.google.com with SMTP id hn15so2606842igb.13
        for <git@vger.kernel.org>; Wed, 19 Nov 2014 01:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=C41F+5kyhzxbMbtVYNBX9AJr3NEvjba7qIMYg2px8ZI=;
        b=cEBA1xM8Hcp5VG2umkEQrsJY3feHJ17tmSPwUF7pqwPlqC06nUWkctd1Y0R7xc5jBH
         U/SGWnfE9aWySDzSWUGbAsA3DSBoW3YpfXrd35SCGVJdjVEuSM9hMdBi3wNhVuEh+4YD
         rWHXx96msL5H5O9zoTvZSpZRD7ui7A0Rw52/5e/SVyCJDCuOvTN5JFkcV2lVsUkZkDup
         A969AtT6SVdwXwU8gu99wuNWFAr8OEoavcXJUi0tHm8lpymTADvrQLroPhzvXlZEHVkF
         MEExx9Xf6Oz1uNO4j2Q1DZcT1qeVsjW4OmoaSgfTxHLTXzHcOosFQ31TWl0iNNC49730
         82jw==
X-Received: by 10.42.153.131 with SMTP id m3mr1972231icw.28.1416390527375;
 Wed, 19 Nov 2014 01:48:47 -0800 (PST)
Received: by 10.107.176.8 with HTTP; Wed, 19 Nov 2014 01:48:16 -0800 (PST)
In-Reply-To: <20141119034010.GA18145@tower.spodhuis.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 19, 2014 at 10:40 AM, Phil Pennock
<phil-gitml@phil.spodhuis.org> wrote:
> Expected to work as .gitignore in top-level of repo:
>
>     *
>     !**/*.asc
>     !.gitignore
>

gitignore man page has this "It is not possible to re-include a file
if a parent directory of that file is excluded". In this case,
directory "foo" is ignored by "*". Although it makes sense for this
particular case to re-include something in foo because we can clearly
see there are rules to re-include. It's on my todo list, but I don't
know when it will be implemented.
-- 
Duy
