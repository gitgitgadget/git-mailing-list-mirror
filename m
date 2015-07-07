From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v8 00/11] add options to for-each-ref
Date: Tue, 7 Jul 2015 21:35:21 +0530
Message-ID: <CAOLa=ZTP+=aQL_JW4+O7jUh5jTD1bWpk7xbguYUsW1DkotAafA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <christian.couder@gmail.com>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 07 18:06:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCVNc-0000a5-68
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 18:05:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757645AbbGGQFw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 12:05:52 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:34394 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755116AbbGGQFv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 12:05:51 -0400
Received: by obbkm3 with SMTP id km3so131725792obb.1
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 09:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=VXzJgHqjxZTyP1VuGT/9DLiIgkt3JjpDUMuCnzVXJ/k=;
        b=Zr8dnM7NglrjkpOWSuSxHXwuJ/MRp/g0fMt9A40zCi9k2sYo0te00BKvscUfgQhSqB
         Vcp0Kzo+ZGkGALnCc+356zN0hHt6j5zPZZRJhLKiyhafE8ty8PA72CGmXS1Cc4T0drmF
         ETkllUa3yd8Uja9GIs70yv7DjNpnnWkxbCpq7oa/sSWATNVl8iVxlkTTS/BYedIa4/ux
         GsQy1wI0305PsuEnviJbQs7J4YeJ/iDIElG2/ybT9nFQ7jdShcllc0+fS9D2US5ct5bk
         zFHbXtrls2czZmZ4DiYUKj4r0a4r3VeVTH5hSbtqFKtaHXdab1/1DYb9FkKlHmsBvzQS
         LwQg==
X-Received: by 10.182.33.38 with SMTP id o6mr4872567obi.41.1436285150457; Tue,
 07 Jul 2015 09:05:50 -0700 (PDT)
Received: by 10.182.95.174 with HTTP; Tue, 7 Jul 2015 09:05:21 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273569>

v7 of this patch series can be found here :
http://article.gmane.org/gmane.comp.version-control.git/273233

This is a continuation of my GSoC project to unify git tag -l, git
branch -l and for-each-ref. Continued from this patch series :
http://thread.gmane.org/gmane.comp.version-control.git/271563

Changes in v8:
[04/11]: Change "pertain to" to "points at", Grammatical change.
[05/11], [04/11]: Random spaces left in macro definition
[10/11]: Mention the movement of code from tag.c

Thanks to Matthieu Moy for suggestions on the previous versions.

-- 
Regards,
Karthik Nayak
