From: Dmitry Malikov <malikov.d.y@gmail.com>
Subject: 'Minimal' diff-algorithm producing a different result than 'myers',
 'patience' and 'histogram' ones
Date: Tue, 12 May 2015 15:07:46 +0200
Message-ID: <CAAg4OeLuR9NY1NaEsjqd4hbuLqZuUo7j+BsVvQT37APY_QEYUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 12 15:07:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ys9uc-0005ox-CN
	for gcvg-git-2@plane.gmane.org; Tue, 12 May 2015 15:07:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932647AbbELNHu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2015 09:07:50 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:35166 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932339AbbELNHt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2015 09:07:49 -0400
Received: by igbyr2 with SMTP id yr2so106740827igb.0
        for <git@vger.kernel.org>; Tue, 12 May 2015 06:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=Hhs8VKWIZa0sasJk5Q9SOQcaOM1ZOFN4DsZA8KTMie4=;
        b=XMiOTaNxWecd3bBlYi+thX+zaT30oLtfTOk2B+15RAtJCgDIRR4VM0nO7y7XesMoYw
         EFZDdDHtDBV6s1kWsSgKGGddNqGZdQ3CJ/DQTy7Sp2B4m9afoVjTbCBJxTcdS6KmVeFz
         rqe1f8QDLLgUH/pU+IZbKS+WJckmdEZ3nvRPjfSfvrLbrCsZSZ5LUuAp+CvLOXGV7wJ1
         IU+ZkqfB4LT8j//AMef87UC2GDSAnCxOxcWRiLiT5vUw8WIaofXgBbZXjgv2uSjhvzEX
         FsiwTrv0q968eVpORc/GUWNZdz0F3ITwDryVRVt+PXUgOJ21BdJ/osoHIlKEHbU0lmmH
         4Ywg==
X-Received: by 10.42.119.2 with SMTP id z2mr2770866icq.1.1431436066976; Tue,
 12 May 2015 06:07:46 -0700 (PDT)
Received: by 10.107.13.66 with HTTP; Tue, 12 May 2015 06:07:46 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268852>

Good day,

I'm trying to compare 4 different git-diff algorithms and the
'minimal' one is the most vague and non-obvious. The documentation
says "Spend extra time to make sure the smallest possible diff is
produced." - that's all.

By any chance, is there any example of diff when 'minimal' algorithm
produces a different result than a 'myers', 'patience' and 'histogram'
ones?

PS: in case of a question like 'why do you need that?' - it's for
testing purposes of some git wrapper library.
