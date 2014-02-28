From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 01/11] builtin/pack-objects.c: change
 check_pbase_path() to use ALLOC_GROW()
Date: Fri, 28 Feb 2014 19:40:19 +0700
Message-ID: <CACsJy8AmQeVb-i6Sn0BH-_ikEXPHTdtKnQRyzChX1WfD9Lj4Jw@mail.gmail.com>
References: <530FA3E7.8020200@yandex.ru> <531056E7.3010305@yandex.ru>
 <53105995.3010001@yandex.ru> <CACsJy8C2h13JFqh=CKvR=3TByHkxWCNR-XhK-WxA+DOE3GmvAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
X-From: git-owner@vger.kernel.org Fri Feb 28 13:40:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJMkJ-0007CA-BB
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 13:40:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751681AbaB1Mkv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 07:40:51 -0500
Received: from mail-qg0-f42.google.com ([209.85.192.42]:41544 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751296AbaB1Mku (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 07:40:50 -0500
Received: by mail-qg0-f42.google.com with SMTP id q107so1890296qgd.1
        for <git@vger.kernel.org>; Fri, 28 Feb 2014 04:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=QFJ3u5ihjC2LaGSAX67mPcIaa2nQ++g6TCsWG82xMlo=;
        b=Vi/Faa7Vk3PahFsSxArwmk7BK5KeCtIi4sVMEUnHjJmlkmln2ZZ2cfuujiVuGHDOJB
         XNPN6FKUQJ/owZ0hH0QXLmGilpwZ0GzozHIdGWeJyrXxU50bDD3gPTTAsTiE5qKDiV6A
         0lxBAc24qZ5564K8yt6tDs+/PllbpxtPSeul/Dw3I/tXB1LSGSD/v6zbn1AhO07GFmOJ
         W6m3b8vFTmefYmnU95tNi5vuWk9BCQkLpksYJLwUpWTRmsB36wpJxTTAi4fg79udhxov
         PC5PmQ6JMh6reo2Ap244/ccSv8/s0WmqLRYuYb9I9+iFSsZA8QV3oMemYYWqA11MGlOV
         jh1Q==
X-Received: by 10.224.36.67 with SMTP id s3mr3306229qad.8.1393591250018; Fri,
 28 Feb 2014 04:40:50 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Fri, 28 Feb 2014 04:40:19 -0800 (PST)
In-Reply-To: <CACsJy8C2h13JFqh=CKvR=3TByHkxWCNR-XhK-WxA+DOE3GmvAQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242950>

On Fri, Feb 28, 2014 at 7:32 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>>         done_pbase_paths_num++;
>
> If you move this up one line, then you don't have to "+ 1" in ALLOC_GROW
>

same comment to a few other patches. The rest of your series looks good.
-- 
Duy
