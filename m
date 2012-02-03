From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] i18n: diff/apply statistics
Date: Fri, 3 Feb 2012 08:28:02 +0700
Message-ID: <CACsJy8BksBhzu2cHNEr5S7u7dhsavBHm9e6fnPvdD31sr_d+gw@mail.gmail.com>
References: <1328116977-61458-1-git-send-email-worldhello.net@gmail.com>
 <CACsJy8DrNHwLGJjj4nJHDm-NEsr6c=QW-kgxmTbsRxq057keWQ@mail.gmail.com>
 <CANYiYbGg_ORq4HhB+LRUjhwUuZs-PZf8BzAPcS1qDUMmchdCJQ@mail.gmail.com>
 <CACsJy8DfdTPfwZJq1_=RzO_f67FoLGJ1Q__Qfqtg+HxKZEMp4g@mail.gmail.com> <CANYiYbHtJMw25ZDbYRbe8S_GM-gR6okkDwwNXo_yxPhPrHQp+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 03 02:28:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rt7x9-0004Pd-6J
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 02:28:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316Ab2BCB2e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 20:28:34 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:59395 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757608Ab2BCB2d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 20:28:33 -0500
Received: by bkcjm19 with SMTP id jm19so2684639bkc.19
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 17:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=RDu1Q8Igup+6PeSG6j7JHq4r2QONxPx6YlX7smBws9o=;
        b=C1hL2j7kcKQLOq1S5S4dbdrUGjWCNy4uQauGjSExQfTAvVKHFPNBMTAOi2IgpY8lpa
         PPT4k+kMC+enFm7lQI6vxxTZcsdQhUYlKw+MlPjEtxzBrSLR9t9Z4aCpkf9bDzGkV4CC
         fCPLLj+v+pjnq55wUx2MaPKpkLadUQWFh+h/4=
Received: by 10.204.157.17 with SMTP id z17mr2444539bkw.37.1328232512157; Thu,
 02 Feb 2012 17:28:32 -0800 (PST)
Received: by 10.204.33.70 with HTTP; Thu, 2 Feb 2012 17:28:02 -0800 (PST)
In-Reply-To: <CANYiYbHtJMw25ZDbYRbe8S_GM-gR6okkDwwNXo_yxPhPrHQp+w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189732>

On Fri, Feb 3, 2012 at 8:23 AM, Jiang Xin <worldhello.net@gmail.com> wrote:
> 2012/2/3 Nguyen Thai Ngoc Duy <pclouds@gmail.com>:
>> On Fri, Feb 3, 2012 at 8:12 AM, Jiang Xin <worldhello.net@gmail.com> wrote:
>>> 2012/2/2 Nguyen Thai Ngoc Duy <pclouds@gmail.com>:
>>>>
>>>> There's another patch with similar goal:
>>>>
>>>> http://thread.gmane.org/gmane.comp.version-control.git/189453/focus=189509
>>>
>>> It's cool, especially the call of interactive_use, so that
>>> translations for the statistics line is only for human, not for scripts/pipe...
>>
>> That's the idea but they decided to allow translations unconditionally
>> in the end.
>
> Ohh, sad, not so cool. Are there any reasons?
>

Inconsistency mainly. I don't see anything sad about that though. You
should read that thread.
-- 
Duy
