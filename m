From: Kirill Likhodedov <kirill.likhodedov@jetbrains.com>
Subject: Re: git show doesn't work on file names with square brackets
Date: Sun, 7 Feb 2016 18:11:34 +0300
Message-ID: <32B9BD70-F06C-49C4-B672-24173E69B99F@jetbrains.com>
References: <6A7D4447-AC25-4591-9DA7-CD153198EC64@jetbrains.com> <alpine.DEB.2.20.1602061518220.2964@virtualbox> <25D155FA-6F05-425C-AB2D-7F0B44E0D1C5@jetbrains.com> <alpine.DEB.2.20.1602061708220.2964@virtualbox> <CACsJy8ChZzYWXePSwF6D8vPZMuz3dQe1=jtw6rSG7M1oC+RiNw@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 07 16:11:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSR02-00016w-5I
	for gcvg-git-2@plane.gmane.org; Sun, 07 Feb 2016 16:11:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753972AbcBGPLi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Feb 2016 10:11:38 -0500
Received: from mail-lf0-f53.google.com ([209.85.215.53]:34469 "EHLO
	mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753885AbcBGPLh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Feb 2016 10:11:37 -0500
Received: by mail-lf0-f53.google.com with SMTP id j78so82459471lfb.1
        for <git@vger.kernel.org>; Sun, 07 Feb 2016 07:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jetbrains-com.20150623.gappssmtp.com; s=20150623;
        h=from:content-type:mime-version:subject:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zzp3EyV+PXth/zKgct4hhnFux4wkrQBATv51IopZJ3E=;
        b=vJt8WgYVWU/bved0ysPySTU8Vd4oOxVnWa4QGo/0AhGy290HBhDKScArdWO7+50HGz
         5VWw8iUh5WhstApk5PO0pGvpVtYloN2BY4c0CI042uT0XePIed5bG4igfi0QJy88ZY93
         PJpGuh6sSgNhNuhmqckMf+KKnQHuUeHTOr6WeMY0NFLjsA21Fcqaqbs4sAbHmIBubAYN
         MyMaGvY50kWhmw0Lqq7KYsP2zCQo4AqCyTmq1nqtnME6JD1lP3B3nq2gmAuD0ivVS+ax
         vBfL9VL9OMFctDMjT6OzUK0mpHES00sI6ygvAXqjYpiNTqm8hE4/K9M8QUjHi9NDp8zI
         rOnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:content-type:mime-version:subject
         :in-reply-to:date:cc:content-transfer-encoding:message-id:references
         :to;
        bh=zzp3EyV+PXth/zKgct4hhnFux4wkrQBATv51IopZJ3E=;
        b=Nj3a7JeMHtr3rkLbKGDRCIKA3gGywTZRHu54JQP0ahE4ep+RwvNYOdtBkEMTdEyvze
         K3KYYj0JDb5GMD+qD/EClmj5oN3p/msm+9RZCywIkGTVAnZ7Kvq/zawEczsL++Wdlz4b
         tgjpqbFFnPN2wGA0xVMhn9gKAgyG9UgKgOXEYAgH4/RJ2yW1CxXCCvLpWE/oKZ3qHLu4
         sB76gfpRF2Iex8rn8B9u0ZEsR+azvglcrUFgdjBHnQ8ggLPwnF8U1QIBRmy9W6uGI9+s
         g1LY/fyQzDXH3FUmGIUS55rBhQ7CBIxNmoEc3eGC2iScPmixTnMog7F743oDEy10gZde
         YX+A==
X-Gm-Message-State: AG10YORaLkTZpxFBWwZRS46ki9JdIZOcEWpFPenJitoib6JgozWphqbawPmbJZg6Qj3Ag17Z
X-Received: by 10.25.143.17 with SMTP id r17mr9643741lfd.37.1454857896166;
        Sun, 07 Feb 2016 07:11:36 -0800 (PST)
Received: from loki.labs.intellij.net ([80.76.244.114])
        by smtp.gmail.com with ESMTPSA id um4sm3339399lbb.1.2016.02.07.07.11.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 07 Feb 2016 07:11:35 -0800 (PST)
X-Google-Original-From: Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com>
In-Reply-To: <CACsJy8ChZzYWXePSwF6D8vPZMuz3dQe1=jtw6rSG7M1oC+RiNw@mail.gmail.com>
X-Mailer: Apple Mail (2.3096.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285731>

Hi Duy,

> It's from 28fcc0b (pathspec: avoid the need of "--" when wildcard is
> used - 2015-05-02)

v2.5.0 is the first release which contains 28fcc0b.
I can confirm that older versions of Git work correctly without =E2=80=9C=
--=E2=80=9C:

# /opt/local/bin/git version
git version 1.7.1.1
# /opt/local/bin/git show HEAD:bra[ckets].txt=20
asd

Looks like a regression?