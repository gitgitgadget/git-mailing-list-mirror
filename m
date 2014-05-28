From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Bug in shallow clone?
Date: Wed, 28 May 2014 21:16:43 +0700
Message-ID: <CACsJy8AmxNDcxtT0XiR8-j=sO0Eo8t5E2apf5SuYU6+EogNm7w@mail.gmail.com>
References: <5385EC5B.8050400@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Thomas Kieffer <ThomasKieffer@web.de>
X-From: git-owner@vger.kernel.org Wed May 28 16:17:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpefP-0005XA-K7
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 16:17:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753827AbaE1ORP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2014 10:17:15 -0400
Received: from mail-qg0-f54.google.com ([209.85.192.54]:61082 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753458AbaE1ORP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 10:17:15 -0400
Received: by mail-qg0-f54.google.com with SMTP id q108so18031278qgd.13
        for <git@vger.kernel.org>; Wed, 28 May 2014 07:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=GjHZok4n4elTXOFVKBPCxP14ZqUx4/8XtzNI9burIg0=;
        b=03b19uvwcszmilDV13dZeiBg23Qy2J9IA0wMdAwJS+mNWenZsH4o6pYVaE3bAXIxBD
         iJ8szSNLZGR+BmzitowQZbJh7rTz2NnTDy/YPAJpmOuyT7yaqGIDjMtx8hIq9YpGiqw2
         yJsZJcn/uxmK9f9xJ1ww2Itk5s6/dtD3G3kaBqpDuM0S/Z1lH8qpFY7NW3TjyAW9exqw
         gHnwVfM9uxiyvfYbvDcoFeFQmz+yWE/DTwtJo48HsKYoH+W8CmEyGXg74xtZ3K4h2Poh
         6hG2HAHq/8BklMV3jfgJD6g2P1gZdVPQTUR+MJUSRMXi2Rcs9EGoqnrCzfcO7JdscbmJ
         y+iQ==
X-Received: by 10.140.91.161 with SMTP id z30mr51050821qgd.65.1401286634258;
 Wed, 28 May 2014 07:17:14 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Wed, 28 May 2014 07:16:43 -0700 (PDT)
In-Reply-To: <5385EC5B.8050400@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250282>

On Wed, May 28, 2014 at 9:02 PM, Thomas Kieffer <ThomasKieffer@web.de> wrote:
> I then clone the bare repository with --depth 1.
>
> git clone file:///path/to/bare.git ./clone --depth 1
>
> It always returns the last two commits. If I specify --depth 2 it returns
> the last 3 commits.
>
> If I use --depth 1 on a Github repository it works as expected.
>
> Am I doing something wrong or is it really a bug?

Depth calculation has been corrected lately. It depends on your
version, maybe it's older than 1.8.2? If it's the latest, we screwed
something up again..
-- 
Duy
