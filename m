From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Mar 2014, #07; Fri, 28)
Date: Sun, 30 Mar 2014 09:01:53 +0700
Message-ID: <CACsJy8CucWgHWjwpq+=wD1KQuTNpx2sokhQtFY02Puy-FFJi4w@mail.gmail.com>
References: <xmqqtxai7ym6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 30 04:02:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WU54u-0002To-Li
	for gcvg-git-2@plane.gmane.org; Sun, 30 Mar 2014 04:02:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752680AbaC3CCZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Mar 2014 22:02:25 -0400
Received: from mail-qa0-f45.google.com ([209.85.216.45]:58169 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752531AbaC3CCY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Mar 2014 22:02:24 -0400
Received: by mail-qa0-f45.google.com with SMTP id hw13so6648467qab.4
        for <git@vger.kernel.org>; Sat, 29 Mar 2014 19:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=XRVdUktqE2YCIU+M5Oy0iy4i7gqBbEcokZVWVFxUrLQ=;
        b=oK8mmwmn53TB3it0kCv46voeundKN8CAZpNUc3RWfkKM1ZR2FRNxz8eq9RsGQ3vCFN
         M6T20kYu9F4TIB21NCXinFIlf6KNpEj7zf2eMyP0T8yrHBIIW71yKUGbR5ApO3DLc7Ag
         548EhMOOdRgWi45C35Gxe0An41ckOCbv5rY6uAqbPyBc+HIRdVMZ/SrW3w8rvjRSXbbr
         pMAYKh23AEH1/A3IElhsBLgKWmnK7IbSjPXgLeJn21YvjdsbCB6RuBRMRPFGvI1QW2uO
         VcSy54fqPEwo8uTu2se6xtEg55iBSPoewvVSftKW+kyLch1nSAKcL62SX/APk2l4YcJe
         /V7g==
X-Received: by 10.224.36.83 with SMTP id s19mr19017003qad.50.1396144943516;
 Sat, 29 Mar 2014 19:02:23 -0700 (PDT)
Received: by 10.96.103.166 with HTTP; Sat, 29 Mar 2014 19:01:53 -0700 (PDT)
In-Reply-To: <xmqqtxai7ym6.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245453>

On Sat, Mar 29, 2014 at 5:21 AM, Junio C Hamano <gitster@pobox.com> wrote:
> * nd/gc-aggressive (2014-03-17) 4 commits
>  - gc --aggressive: three phase repacking
>  - gc --aggressive: make --depth configurable
>  - pack-objects: support --keep
>  - environment.c: fix constness for odb_pack_keep()

Using --before=1.year.ago my way does not keep all recent chains short
because commit time is unreliable. But even with better recent object
selection, the performance gain is still within noise level. I suggest
we keep " gc --aggressive: make --depth configurable" and drop the
rest.
-- 
Duy
