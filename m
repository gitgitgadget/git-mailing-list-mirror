From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2] all: new command used for multi-repo operations
Date: Wed, 23 Jan 2013 17:15:16 +0700
Message-ID: <CACsJy8BHZ--n6HeuGt3xk13vwE9ec=dQYhiF_FpdKF47yo=Gmw@mail.gmail.com>
References: <1358928767-16283-1-git-send-email-hjemli@gmail.com>
 <CACsJy8DskoCi9Lg+HW0JeQBe4HX-bMXNHUgfrsg+DoqBN9-ntQ@mail.gmail.com> <CAFXTnz6mU999DBQG9mPKyjtit4e4WF=bUf_E8XwGR8d5sUPO0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 23 11:16:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxxNJ-0008Kc-TK
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 11:16:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754830Ab3AWKPs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 05:15:48 -0500
Received: from mail-ob0-f176.google.com ([209.85.214.176]:42932 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754723Ab3AWKPr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 05:15:47 -0500
Received: by mail-ob0-f176.google.com with SMTP id un3so7912740obb.7
        for <git@vger.kernel.org>; Wed, 23 Jan 2013 02:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=WzZM6xqtWtCDJfOukpsEmDvc4UkUNGbgR/7R959x5Jg=;
        b=k0DnbHKkdiOqLOX6WNkuFBU8AdNqfAU20mXndWm27dxt1KYR2lzgSYEcY7zBcYV14c
         P3pLdiLmnGCuvWpib0AO5EoxzH/MW2h+pPmrX/yCAf50w+oX+/9BitEcMbAFm7Nqo2H6
         07i7I121mPOwW2V8JXhmnKqrxWKeS5CnHztxOst/S9Reo/fpKL/K7PdBvWUgoeEPvo/B
         tONHFo5jyh4JJmoIYuwq82oP0wvXNkemUa19tbj1veeJsKI8VlBpSW2Y57W0DB6St6wj
         G99RK5/aR4LTNL5Yl7MvGkq0wLbPldueHhUT2/f6t9J82Oquio+SM/pClb/9ZKejfh8s
         45ug==
X-Received: by 10.182.0.19 with SMTP id 19mr575181oba.15.1358936146437; Wed,
 23 Jan 2013 02:15:46 -0800 (PST)
Received: by 10.182.153.69 with HTTP; Wed, 23 Jan 2013 02:15:16 -0800 (PST)
In-Reply-To: <CAFXTnz6mU999DBQG9mPKyjtit4e4WF=bUf_E8XwGR8d5sUPO0w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214307>

On Wed, Jan 23, 2013 at 4:24 PM, Lars Hjemli <hjemli@gmail.com> wrote:
> On Wed, Jan 23, 2013 at 9:55 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>> Perhaps we could add the subrepo's object data to the in-memory object
>> database of git-all, then do the diff without launching new commands?
>
> The `git all` command is regularly invoked outside of git repos, so
> I'm not sure if this would work.

We could initialize an empty object database in memory. But my
suggestion is probably off topic. I thought this was about a a git
repository with a collection of submodules. If there are no
connections between repos, perhaps git-all fits better as a subcommand
of git-repo:

http://source.android.com/source/version-control.html
-- 
Duy
