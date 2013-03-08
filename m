From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: Re: rebase: strange failures to apply patc 3-way
Date: Fri, 8 Mar 2013 14:20:22 -0500
Message-ID: <CADgNja=Ej8jnYn027GX986VrmuqVemM7aE59rynHzUpToPVaEw@mail.gmail.com>
References: <7A483B92-D671-46CA-9EFD-83C6F4C97B5E@quendi.de>
	<494292C5-EBD9-487B-8846-9D9DD23ACB83@quendi.de>
	<CADeaMWp_R0HLwEYn7O3oX4-0OoSeqLfzz_2AYXT-Po88nM4HkQ@mail.gmail.com>
	<205D17C4-F737-46E9-BC48-D16D5948C707@quendi.de>
	<CADgNjan9v++__TSPE55j7+=BBZrVEkMD52O+9kXAm-C8SRV+Ww@mail.gmail.com>
	<B21B6CEC-7507-47A1-9BBB-FB95EA6B831F@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Fri Mar 08 20:20:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UE2qY-0000gE-IL
	for gcvg-git-2@plane.gmane.org; Fri, 08 Mar 2013 20:20:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149Ab3CHTUY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Mar 2013 14:20:24 -0500
Received: from mail-wg0-f50.google.com ([74.125.82.50]:42076 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851Ab3CHTUX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Mar 2013 14:20:23 -0500
Received: by mail-wg0-f50.google.com with SMTP id es5so2961962wgb.29
        for <git@vger.kernel.org>; Fri, 08 Mar 2013 11:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=ej2h7EnqgQ86pvUnSa08F4KW8F4hMhGgnUHpR6VkTds=;
        b=CqxGh56RA5wsjJbHuSD8DlDef9hp58GzNTaMhdNPkVtR1olgzze4Q2EgxiLVerGPhC
         TFQGzgRQvYUmQn+RNDrUIJnwiMrXEHeByP1epivET/xGM/XNHp4IIpuern4xK0xBFKDz
         xWTyQ5iI/Papg1vzXDGrIfFZWROyRoOr4XgipWVk5EJVFilcBxjJbUYNhfM+RDZaY3Xu
         tUvOyrR5+Hjc9HZSHBL9haPaF0x0mbGCcv6QW59DixfXtqXl+keSGwCTUsqfMi6tVxBl
         fNUEV1/pylwBxTSJ3g3fs3fRACpdNKmjT3qt3yBRaNQsboCPU5H9+Mhn19pb9mUJ4+0p
         Y4IQ==
X-Received: by 10.180.81.164 with SMTP id b4mr89140wiy.34.1362770422750; Fri,
 08 Mar 2013 11:20:22 -0800 (PST)
Received: by 10.194.138.107 with HTTP; Fri, 8 Mar 2013 11:20:22 -0800 (PST)
In-Reply-To: <B21B6CEC-7507-47A1-9BBB-FB95EA6B831F@quendi.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217678>

On 3/8/13, Max Horn <max@quendi.de> wrote:
> Same result, it works fine.

Just shooting in the dark here... I wonder if there's some background
process running in OS X that's messing with the files/directories
while rebase is working... backup, virus scan, etc? Or maybe some
programs that you're using at the same time? Maybe also make sure you
don't have any programs (shells, editors, etc.) opened that's
accessing those files/directories?

Does the error always happen at COMMIT A and COMMIT B? Or is it all
over the place?

In cases where COMMIT A succeeded, did it say it did a 3-way merge? Or
was it exactly as the output in your original message? i.e. no message
at all
