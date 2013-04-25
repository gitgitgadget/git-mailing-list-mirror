From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Itches with the current rev spec
Date: Thu, 25 Apr 2013 16:36:17 +0530
Message-ID: <CALkWK0n67c203tLWYvCi9qiMtBo2ZOkKLYbsqFC1ukwz0CLEuw@mail.gmail.com>
References: <CALkWK0n97VLtiR96VEy86645NVoDL2rS-g7LBuLb=JpncdH6VA@mail.gmail.com>
 <vpqehdzkoix.fsf@grenoble-inp.fr> <CAMP44s3P02yFoi64j5aROQm69O4NGzvzxONyEjkpvLzW-GTenA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 25 13:07:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVK11-0005PS-Q5
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 13:07:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757980Ab3DYLG6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 07:06:58 -0400
Received: from mail-ia0-f170.google.com ([209.85.210.170]:61912 "EHLO
	mail-ia0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757863Ab3DYLG6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 07:06:58 -0400
Received: by mail-ia0-f170.google.com with SMTP id 21so2610710iay.1
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 04:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=6vTTcJ7QSyDKvJ4xUlhgFe508IRSmPAzqHbT6zJ78/I=;
        b=YXMysgeai53mFkHIlMZZTjokyX7teCRUAtfBQwyLNYHgZnd4X3FZ1WBD8Xqcey7v2a
         uprllRv3367vpec3DPuk8oXsIY5kiJNXav8gaEOtAxbE8s5t9AKcE1oqf0gB9L39jgyI
         ey+BNPSK8JGzXkv+//tp7TwkkfjOF6VG5hg1zrUB8ckrTQ89cfoyboBxhSEieQxjdWZW
         AOEmDSIy1H5nhrA2aAU3cItrrlSrXAOB9gMM+eizoVCqGgKltIXjwS4X1SZT/XQ+MNpo
         gHvODMmv/hcVJLovRM6DrjMqtqTj8PPGly4ldOM2zBcJik8sRX+PIP2F4d5PsceBXlxf
         wyLQ==
X-Received: by 10.50.72.65 with SMTP id b1mr5240898igv.63.1366888017736; Thu,
 25 Apr 2013 04:06:57 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Thu, 25 Apr 2013 04:06:17 -0700 (PDT)
In-Reply-To: <CAMP44s3P02yFoi64j5aROQm69O4NGzvzxONyEjkpvLzW-GTenA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222366>

Felipe Contreras wrote:
> Yeah, probably fine, but I would also like H~1.

You can get that now using `git symbolic ref H HEAD`.  I'm wondering
if we can do better than hard-interpreting HEAD as H at the rev-parse
level.
