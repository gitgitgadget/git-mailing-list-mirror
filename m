From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH v6 2/2] mergetools: add winmerge as a builtin tool
Date: Wed, 20 May 2015 23:20:26 +0200
Message-ID: <CAHGBnuMt82oawQnoPGNiXefui6k5A3DW1ktGWvMy0m8iq78oPg@mail.gmail.com>
References: <1432112843-973-1-git-send-email-davvid@gmail.com>
	<1432112843-973-2-git-send-email-davvid@gmail.com>
	<xmqqtwv7m2hw.fsf@gitster.dls.corp.google.com>
	<CAHGBnuPyhG4y5ooR7KH0KrEhRYFu9BB+HKnnn+XhU5xL2TnL=w@mail.gmail.com>
	<xmqq8ucjm0bo.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Aguilar <davvid@gmail.com>, Phil Susi <phillsusi@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 20 23:24:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvBTU-0001bU-Tn
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 23:24:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbbETVYU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2015 17:24:20 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:34323 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753936AbbETVU0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 17:20:26 -0400
Received: by ieczm2 with SMTP id zm2so49478059iec.1
        for <git@vger.kernel.org>; Wed, 20 May 2015 14:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=TeF7i3uWRI3Vt6PuEbyMPqrSyuBL/tYswG0MhH4rn4I=;
        b=dORfntkboasNPUeXUHhycCDDCSDyNGjh8xHassbfwdmqrLHL2GItQAhpgtWcCp/8B9
         NcNIVkBaQiwFIRDO3gDm8LnbGOv/z2P9tzKNDeYXp0dXKXHYSr6YQgkm9VmzUZergINP
         N7FmCgsL1bIJwdMXLKyA4HGre/NiMaeFLAIyFvqhKy8WYilqVqZqyJIyNrjMa9dRNspu
         XDhBVgk70PExCgnrqKUSJ7nkp8fhgh3F1yAr4JumzqphL6zhXUhnzuLs8Ka1oh5HUq/V
         Ux+o+YOsBdu/XpTO4TMsN2PIoz01Hw0/XA8bjVXrhDUX+VkFt2kLBC9g5Zbmg1F5SFoN
         dm/w==
X-Received: by 10.42.105.3 with SMTP id t3mr48748357ico.47.1432156826230; Wed,
 20 May 2015 14:20:26 -0700 (PDT)
Received: by 10.107.29.149 with HTTP; Wed, 20 May 2015 14:20:26 -0700 (PDT)
In-Reply-To: <xmqq8ucjm0bo.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269528>

On Wed, May 20, 2015 at 11:00 PM, Junio C Hamano <gitster@pobox.com> wrote:

> Yuck.  So even though %PROGRAMFILES% and %PROGRAMFILES(X86)% look as
> if they are variables that can point at arbitrary places, they in
> reality don't?  Otherwise %PROGRAMFILES% may point at D:\Program

Correct. In the vast majority of  WIndows installations these
variables contain the default values.

> But of course if I view this not as a "logic" but as a "heuristics"
> that happens to do the right thing in common environments, it is
> perfectly OK ;-).

Exactly a heuristic is what it's supposed to be :-)

-- 
Sebastian Schuberth
