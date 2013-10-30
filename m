From: Tony Luck <tony.luck@gmail.com>
Subject: Re: [PATCH] commit: Add -f, --fixes <commit> option to add Fixes: line
Date: Wed, 30 Oct 2013 10:28:06 -0700
Message-ID: <CA+8MBbK3dicmwOJb0mhTwr59O1tqzZgEGmMfSQV61Z=aK_64oA@mail.gmail.com>
References: <20131024122255.GI9378@mwanda>
	<20131024122512.GB9534@mwanda>
	<20131026181709.GB10488@kroah.com>
	<20131027013402.GA7146@leaf>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg KH <greg@kroah.com>,
	ksummit-2013-discuss@lists.linuxfoundation.org,
	ksummit-attendees@lists.linuxfoundation.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Josh Triplett <josh@joshtriplett.org>
X-From: linux-kernel-owner@vger.kernel.org Wed Oct 30 18:28:17 2013
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1VbZZ2-0002lI-D9
	for glk-linux-kernel-3@plane.gmane.org; Wed, 30 Oct 2013 18:28:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753270Ab3J3R2J (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 30 Oct 2013 13:28:09 -0400
Received: from mail-vc0-f172.google.com ([209.85.220.172]:44987 "EHLO
	mail-vc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750865Ab3J3R2H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Oct 2013 13:28:07 -0400
Received: by mail-vc0-f172.google.com with SMTP id ks9so1153374vcb.31
        for <multiple recipients>; Wed, 30 Oct 2013 10:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=pABuGA2nz3dbOXCEJYEx6O7gLqosGTFFW6EVCvJuzZo=;
        b=i+m8+S+Kkk0n5dcCTTHAwfKzXagdW+7ZXFk2gu2BZ5KVpAQTZjS2MCd1tSSAf5kjy3
         d17EsxFd+HsAlxVsEI0IVRlbn2w+NzS1luGAs5mIA7/1mH+kIKTooyvN2cy8gjdITbJh
         bjEYvqkuIHxT7oogXO6hpr4jyiiEwih5qza69Dpll4Tg6XoYrnWO60MXrpbzdto1F9qj
         swOvCaT6UMSkCS9xJIZucnBJ8iGtrDlWxIXYVJ0IciZ1QNY63KXgIP5JS66cdKQNvltb
         7FBcYzRJhqJaLtsVtWWFXtO5e7NlLyPStGjtpc3QlhiQOlsLdYReDXVqz9lM6Ppxl3R+
         BjLQ==
X-Received: by 10.220.11.7 with SMTP id r7mr3803485vcr.12.1383154086679; Wed,
 30 Oct 2013 10:28:06 -0700 (PDT)
Received: by 10.58.253.66 with HTTP; Wed, 30 Oct 2013 10:28:06 -0700 (PDT)
In-Reply-To: <20131027013402.GA7146@leaf>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237040>

On Sat, Oct 26, 2013 at 6:34 PM, Josh Triplett <josh@joshtriplett.org> wrote:

> +               format_commit_message(commit, "Fixes: %h ('%s')\n", sb, &ctx);

What is the value of double wrapping the commit message inside '...'
and then ('...')?

-Tony
