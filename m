From: Yi EungJun <semtlenori@gmail.com>
Subject: Re: [PATCH] http: fix charset detection of extract_content_type()
Date: Sun, 15 Jun 2014 17:21:00 +0900
Message-ID: <539d5770.23de440a.5332.ffffe521@mx.google.com>
References: <539caff7.e7bc420a.76b9.fffff853@mx.google.com>
Content-Type: text/plain; charset=utf-8
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Sun Jun 15 10:21:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ww5gd-0004JE-9M
	for gcvg-git-2@plane.gmane.org; Sun, 15 Jun 2014 10:21:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751492AbaFOIVH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2014 04:21:07 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:61894 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993AbaFOIVF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2014 04:21:05 -0400
Received: by mail-pa0-f49.google.com with SMTP id lj1so3465738pab.36
        for <git@vger.kernel.org>; Sun, 15 Jun 2014 01:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:from:date:references:in-reply-to:subject:content-type;
        bh=bjxCumCwKwdkNh93kNeO6su88yJ0UQLtwgl6yLYmOu4=;
        b=q51GPuab8Q/4qOdqLFBl9wCELPmHMSemRMMBc3CzfsJzrTn4FIKBpw5kgpHJmH3wyn
         45ZmWjKXSB606GAPCPboaO9vqO/qYW6HUMFg+wkGGNU+FPBShV4/kQLO7EjRzpGjVrLf
         n7Jt7sn2laOI0HrVj5TxmnNtAqj4YwZrsM3KaPfxZqSzIVBQfW/znBi7YspyAYj3b0lW
         c/DufeY91k70jeJrBgWDmhim2qX4pmiv2neokUkEQl5to41g0SJ1ZwWYp3IwBrlDjRGG
         V5Xxlj6BI24RP4kD5TUYzvvxrYJYNgUwtoa4yNZxN76v2Hn2/C+Gk2SFEGxTxwe4nItQ
         QUOg==
X-Received: by 10.67.21.205 with SMTP id hm13mr15714770pad.112.1402820465049;
        Sun, 15 Jun 2014 01:21:05 -0700 (PDT)
Received: from nori-ThinkPad-X1-Carbon ([14.40.27.230])
        by mx.google.com with ESMTPSA id qj3sm12350462pbc.91.2014.06.15.01.21.03
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 15 Jun 2014 01:21:04 -0700 (PDT)
X-Google-Original-From: Yi EungJun <eungjun.yi@navercorp.com>
Received: by nori-ThinkPad-X1-Carbon (sSMTP sendmail emulation); Sun, 15 Jun 2014 17:21:00 +0900
In-Reply-To: <539caff7.e7bc420a.76b9.fffff853@mx.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251673>

Could you change the author to "Yi EungJun <eungjun.yi@navercorp.com>"
if you apply this patch?
