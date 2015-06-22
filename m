From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 04/19] for-each-ref: add '--points-at' option
Date: Sun, 21 Jun 2015 17:45:56 -0700
Message-ID: <CAPc5daVNapbjAHwiUq5PXfCnWii4Cs1v6dvDAGFfnVkAJhFZnA@mail.gmail.com>
References: <CAOLa=ZS_vn8ZNrb7mtqZKU4Y3RCZojcbeMYfbx=3X-aVjhdpSA@mail.gmail.com>
 <1434919705-4884-1-git-send-email-karthik.188@gmail.com> <1434919705-4884-4-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 22 02:46:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6psS-00079L-TZ
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 02:46:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753977AbbFVAqR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2015 20:46:17 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:34396 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751503AbbFVAqQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2015 20:46:16 -0400
Received: by obbkm3 with SMTP id km3so10928779obb.1
        for <git@vger.kernel.org>; Sun, 21 Jun 2015 17:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=eOS5q3pWXqfdP0TZUkm8V3dQgAnLy02d5aW5cUu/J9Q=;
        b=M2lrJbMZd1V0wHsHXAkpEnGcFBIONEXmp2K+vO8XJAgDiqbPyHTCYIAlOf1WmoftaY
         vutlGlU/7ozxAZH3hG5TTgFlWXJlMYCT09z+EwDCQqa+DUwc0GJks8YwLhzcS722aMDf
         IsSDf6NN82p74lRwu+AXwPX146PQ9WJZC6gLccY7HTIPQa3027FRrgqChFihdeVR4pw9
         7eTbITM49qffHpHXHnshNPD4anP27kuQnEGUSgv+gARYh1tYtEffXyBZzR86IOXWY6U0
         pRkyK0VlRem4UVz7dha/7k9ycOoh1m6xxAMfOm16sOPLbUTSQJnkvoV1k/wJpTiUDHk9
         RCgA==
X-Received: by 10.202.186.132 with SMTP id k126mr21730996oif.60.1434933975606;
 Sun, 21 Jun 2015 17:46:15 -0700 (PDT)
Received: by 10.202.202.129 with HTTP; Sun, 21 Jun 2015 17:45:56 -0700 (PDT)
In-Reply-To: <1434919705-4884-4-git-send-email-karthik.188@gmail.com>
X-Google-Sender-Auth: 6On4g2figWi3LSRt8OQmOGw7diM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272310>

 3 & 4 as a single patch may make more sense, if we were to tolerate the
"let's copy & paste first and then later remove the duplicate" as a way to
postpone touching "tag.c" side in order to first concentrate on for-each-ref.

I have not formed a firm opinion on what the right split of the series is, but
so far (assuming that the temporary duplication is the best we can do) what
I am seeing in this series makes sense to me.

Thanks.
