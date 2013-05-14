From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [RFC/PATCH] branch: show me the hot branches
Date: Tue, 14 May 2013 19:19:43 -0400
Message-ID: <CABURp0rVoRwWUBXP5ZdsPByd47hDj7w9y5eddNQfiDfkttAKvg@mail.gmail.com>
References: <1368475365-18680-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 15 01:20:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcOVw-0005S5-Ak
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 01:20:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758603Ab3ENXUG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 19:20:06 -0400
Received: from mail-ve0-f180.google.com ([209.85.128.180]:32781 "EHLO
	mail-ve0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758565Ab3ENXUE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 19:20:04 -0400
Received: by mail-ve0-f180.google.com with SMTP id pa12so1357118veb.25
        for <git@vger.kernel.org>; Tue, 14 May 2013 16:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=5FoRoIKtC0FJhe3PeGpifgHsRhROLAmsjK0hgqLnM74=;
        b=gxmiJBbuqFjp+RqQU3FrJQ0kHzNwg06WCQ1sx58VGOgpJtKlvzb2FCzAFeVEHDZo/a
         nGKvYaM+zv7EwNFFaoM0U33Zna7xP+oq8i8sA6AUK18hRTqqEr2z1uMmXWKAv/ZwzrnK
         HdFTTxUk482MUQfjkVSDGPZDokVjvwRGBWaqL60QuDhUtGU8YwmwcO28nCDcD5As9ZZE
         5kHEY7ohRPeBaQl9X/UpQpcF+97/eqhCjJnNZXV+qa8ItdzN118ZJGjlqZRKd/gRlfP2
         DfWDjg6vnkJttMo3Srt0FvSLsHl4/fbSULsag/oLX/js+ELA48zi4yotw27ktAzYywTH
         BnWA==
X-Received: by 10.52.37.196 with SMTP id a4mr19887854vdk.82.1368573603270;
 Tue, 14 May 2013 16:20:03 -0700 (PDT)
Received: by 10.58.135.1 with HTTP; Tue, 14 May 2013 16:19:43 -0700 (PDT)
In-Reply-To: <1368475365-18680-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224368>

On Mon, May 13, 2013 at 4:02 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Uses commit->date to sort displayed refs.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---

I dig it.

I imagine it with --date-order and whatnot.  But I might like it even
better if it were reverse-sorted.  Maybe it needs -rt for that. ;-)

Phil
