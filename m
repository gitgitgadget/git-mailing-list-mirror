From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH] i18n: diff/apply statistics
Date: Fri, 3 Feb 2012 09:23:42 +0800
Message-ID: <CANYiYbHtJMw25ZDbYRbe8S_GM-gR6okkDwwNXo_yxPhPrHQp+w@mail.gmail.com>
References: <1328116977-61458-1-git-send-email-worldhello.net@gmail.com>
	<CACsJy8DrNHwLGJjj4nJHDm-NEsr6c=QW-kgxmTbsRxq057keWQ@mail.gmail.com>
	<CANYiYbGg_ORq4HhB+LRUjhwUuZs-PZf8BzAPcS1qDUMmchdCJQ@mail.gmail.com>
	<CACsJy8DfdTPfwZJq1_=RzO_f67FoLGJ1Q__Qfqtg+HxKZEMp4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 03 02:23:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rt7sS-0002c3-Me
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 02:23:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756876Ab2BCBXo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 20:23:44 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:39897 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754408Ab2BCBXn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 20:23:43 -0500
Received: by ggnh1 with SMTP id h1so1610152ggn.19
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 17:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=tcBrv3l5Wz3karMpYqwPRPvqZxCOX8sMnethBL3Qx3U=;
        b=NcifMbylnOOZkwUxbKnpswwwjQ4WI26yrib/NavGCn0LNPCVfkJbkAshh3DM5P1dy4
         QpZjMMGnZfs6S8eGgghCZCBHn5Xs5x+u/sDUDx5CHt6XIpjpIUzbrbhlDiHOqmev18sG
         qnA0SqUSoYEwd6J/pPX79XdN2GZrFNVU0lXeA=
Received: by 10.101.177.39 with SMTP id e39mr2414084anp.54.1328232222988; Thu,
 02 Feb 2012 17:23:42 -0800 (PST)
Received: by 10.236.153.195 with HTTP; Thu, 2 Feb 2012 17:23:42 -0800 (PST)
In-Reply-To: <CACsJy8DfdTPfwZJq1_=RzO_f67FoLGJ1Q__Qfqtg+HxKZEMp4g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189730>

2012/2/3 Nguyen Thai Ngoc Duy <pclouds@gmail.com>:
> On Fri, Feb 3, 2012 at 8:12 AM, Jiang Xin <worldhello.net@gmail.com> wrote:
>> 2012/2/2 Nguyen Thai Ngoc Duy <pclouds@gmail.com>:
>>>
>>> There's another patch with similar goal:
>>>
>>> http://thread.gmane.org/gmane.comp.version-control.git/189453/focus=189509
>>
>> It's cool, especially the call of interactive_use, so that
>> translations for the statistics line is only for human, not for scripts/pipe...
>
> That's the idea but they decided to allow translations unconditionally
> in the end.

Ohh, sad, not so cool. Are there any reasons?

-- 
Jiang Xin
