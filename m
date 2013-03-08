From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: Re: rebase: strange failures to apply patc 3-way
Date: Fri, 8 Mar 2013 13:02:21 -0500
Message-ID: <CADgNjan9v++__TSPE55j7+=BBZrVEkMD52O+9kXAm-C8SRV+Ww@mail.gmail.com>
References: <7A483B92-D671-46CA-9EFD-83C6F4C97B5E@quendi.de>
	<494292C5-EBD9-487B-8846-9D9DD23ACB83@quendi.de>
	<CADeaMWp_R0HLwEYn7O3oX4-0OoSeqLfzz_2AYXT-Po88nM4HkQ@mail.gmail.com>
	<205D17C4-F737-46E9-BC48-D16D5948C707@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Fri Mar 08 19:03:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UE1dn-00054Y-J9
	for gcvg-git-2@plane.gmane.org; Fri, 08 Mar 2013 19:03:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759946Ab3CHSDK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Mar 2013 13:03:10 -0500
Received: from mail-wg0-f45.google.com ([74.125.82.45]:59693 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757876Ab3CHSCZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Mar 2013 13:02:25 -0500
Received: by mail-wg0-f45.google.com with SMTP id dq12so2929226wgb.24
        for <git@vger.kernel.org>; Fri, 08 Mar 2013 10:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=uHy/awaJApeFKa7Z4MhAh7A/rzCTjVzMNy10tF5N7ks=;
        b=lnqTJfutEHVxrx9XRg0ycb9qqmHvrCduTSEvezqoErLD9ma2bh2+YPSm4o9r0DARyd
         A53ogWrwwpJeWTaOOv0O8Y6zzjdSdnWScvPWxMmpDIJdUjK6fB//PVEWUBCYy3QpKyZm
         LgGF37OCav6Fjs5cfLnbhRjz0BG7GDFvXgy5h6BSQqfbUW1VPG4OA/WklqJ19TfThWSh
         xpTpSFOTlQj/ujrfq89cEQzehMsnz49pR9w6bLEeCs7IEMjUjMEenf3PyTIdXdPACwCY
         1BF6Kx563lyMBBIGT3S7ufQtCa0OAvJ5qFLfABSZWJs0uxZrkib6lA4EwNQwc5+bYZ/u
         AXCg==
X-Received: by 10.194.63.240 with SMTP id j16mr5859711wjs.45.1362765741723;
 Fri, 08 Mar 2013 10:02:21 -0800 (PST)
Received: by 10.194.138.107 with HTTP; Fri, 8 Mar 2013 10:02:21 -0800 (PST)
In-Reply-To: <205D17C4-F737-46E9-BC48-D16D5948C707@quendi.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217676>

On 3/8/13, Max Horn <max@quendi.de> wrote:
> I tried this a dozen times, but 'git apply' failed to fail even once. No
> surprise there, given that the patch that throws off rebase every time is
> clean and simple. I am flabbergasted :-(

Hm, what if you add in the "--index" flag? i.e.
    git apply --index .git/rebase-apply/patch

Wonder if that makes any difference...
