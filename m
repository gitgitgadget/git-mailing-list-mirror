From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 05/10] Import wildmatch from rsync
Date: Fri, 5 Oct 2012 18:18:46 +0700
Message-ID: <CACsJy8A_+-2tp43vtGHdXnR06x1TDoa9QDsMGPOmT2x0-itVvA@mail.gmail.com>
References: <1349412069-627-1-git-send-email-pclouds@gmail.com>
 <1349412069-627-6-git-send-email-pclouds@gmail.com> <alpine.DEB.2.00.1210051129510.16797@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Fri Oct 05 13:19:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TK5wH-0004xV-47
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 13:19:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752837Ab2JELTT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2012 07:19:19 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:41704 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752545Ab2JELTS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2012 07:19:18 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so3434002iea.19
        for <git@vger.kernel.org>; Fri, 05 Oct 2012 04:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=xjC53K99WgSws9HikivBdbflMOBwJyKAVABKitEgUNQ=;
        b=IJykJZIHH1/FaOUc+T8pJT1agz79gfNXs00OAT2pjQpuIUCawiC/sdrKqF8EkZBpAS
         kxiMPbuMjN5i+V7o7fBy+Ay0VDWfPNOZsO1wNuiC6cHsevlmMv30KXgHneyVfJlyVI/f
         NeT5sgztXj7kVliRqyMNdIPT15xADWmKtcEkA8npL+szy1H7N+DVgk9ZpL1QT7jc3A2i
         xWzU6WpPX0uxEHOGwYg3gueML4v/RmiAgni7KoU3fLRQBP0wkbyHmvtZie656sft/pce
         8DrdQYFcqBZnGfbmOBG/aMECx0qNpQmVTO4zFD9dekbTe6G9A4/0DFYQ90Kr47BDlg01
         fAyg==
Received: by 10.50.220.129 with SMTP id pw1mr793887igc.47.1349435957426; Fri,
 05 Oct 2012 04:19:17 -0700 (PDT)
Received: by 10.64.143.168 with HTTP; Fri, 5 Oct 2012 04:18:46 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1210051129510.16797@ds9.cixit.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207099>

On Fri, Oct 5, 2012 at 5:30 PM, Peter Krefting <peter@softwolves.pp.se> wrote:
>> These files are from rsync.git commit
>> f92f5b166e3019db42bc7fe1aa2f1a9178cd215d, which was the last commit
>> before rsync turned GPL-3.
>
>
> However:
>
>> diff --git a/test-wildmatch.c b/test-wildmatch.c
>
> [...]
>
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 3 of the License, or
>> + * (at your option) any later version.

A copy mistake. I probably did not look closely at this file as it's
not the main source, we could even rewrite it with little effort. Will
update with GPL2 version next round.
-- 
Duy
