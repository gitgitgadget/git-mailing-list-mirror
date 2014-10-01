From: James Hancock <james@bookstobrains.com>
Subject: Can you git clone -partial? I am looking to make a mobile app and it
 would be nice to have.
Date: Thu, 2 Oct 2014 00:51:58 +0800
Message-ID: <CAOHoyPr3E9U3XPEjmrSNkT0okHcRN2H7OKyrt-Ar3WMMDL=4vw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 01 18:52:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZN8H-0005Qp-PK
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 18:52:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753035AbaJAQwC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 12:52:02 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:37219 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751724AbaJAQwA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2014 12:52:00 -0400
Received: by mail-lb0-f170.google.com with SMTP id u10so717480lbd.29
        for <git@vger.kernel.org>; Wed, 01 Oct 2014 09:51:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=oz4ZcqE4r7zPo6ah9yIeKCpUljaOdwcKNUY8mkEjbao=;
        b=HNAZB2n3caxaRepsCoa4XlpN8CeLSxqmeT0NW6Y2imyJ7cnePzYRTHOkjIT7wiFg+p
         AT6q0YyDini3FR4ngwijrD8adst6WZ9YvGDW6SHlrRWvENxQThf7bYlT77ZdYSx9dT6m
         vKt2Y3mJzmUmkgZxy3jDhALcfK+eFbSCT9WU9bfL4VkXMrcAK5jL92AAIg5L7Y7gXFxl
         L37CCBJ/OIE66kE2DjfHz9xSzgIGu1EfmUoHJ+RWguY4QwX3HA+UFcXQ1mAuecyOyfb3
         clJx7/YrmhXtkc5ni3KjH8ht98uMi2p6rili9Brz4vBQx08y1O139KnycOcUHRgmKl+J
         6txw==
X-Gm-Message-State: ALoCoQkBDHew0Kr3MbQdtbhnHEP9r0B79sS06oWOAIpv2tkxEiXWSeABSvSpnZUhpQWUbmrYGatV
X-Received: by 10.152.8.168 with SMTP id s8mr35210715laa.3.1412182318825; Wed,
 01 Oct 2014 09:51:58 -0700 (PDT)
Received: by 10.25.30.10 with HTTP; Wed, 1 Oct 2014 09:51:58 -0700 (PDT)
X-Originating-IP: [58.115.134.159]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257758>

i am thinking about developing an app and I want to integrate it with
git but I only want to store a portion of the file on disk. It is
going to be in a mobile enviornment and I want to just get one file or
a small group of files.

I read that you can clone and then only look at one peice but is it
possible just to clone one peice? And if not what would it take? Maybe
this is a feature people would like to have. Just hypothetically, what
would need to happen?

Either
git clonepartial /repo /file/or/folder/in/repo
Or
Git clone -partial /repo /file/or/folder/in/repo

I guess you would need to keep the projects .git in order to maintain
consistency, or would you? I'm going to do some more research about
what .git does exactly.

Cheers,
James
