From: Martin Matusiak <numerodix@gmail.com>
Subject: gitk: sizing on history panels after maximize + restore
Date: Sun, 5 Oct 2014 20:52:06 +0200
Message-ID: <CAH88djVDPOcCAKad2QaYJUXZ+j4tyv=0Amr8DKgPjRRhQSSdMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 05 20:52:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xaquj-0007lZ-PD
	for gcvg-git-2@plane.gmane.org; Sun, 05 Oct 2014 20:52:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751924AbaJESwL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Oct 2014 14:52:11 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:45020 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751827AbaJESwI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Oct 2014 14:52:08 -0400
Received: by mail-lb0-f175.google.com with SMTP id u10so3251962lbd.34
        for <git@vger.kernel.org>; Sun, 05 Oct 2014 11:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=BLvGO2TrkzbNIQ+OZ1vOq/CusN5L1Us4SP3TMvBVKUc=;
        b=fVYbZFhgWL5MvIrBlmPejB9GPOe3LyiA7XH43ImXpuFtIQY91+TtJAzAWm6gxjpVbX
         hKVrrwLtY15hza/xdTb9trfWQ35Q53Irtm+6FafKouAtiTIqhXGVeYot0Wnr4yjK/J3S
         o9HNMRkICCdZQOSAdgfNtfIYGX08VBuopGUt0/YWtk9ebXylQVVioEd+WfsgnCt2MHKF
         Pfn7TkNQz4FCU5q7QjuEspbKJwhLclwucu035Ibh9kgeVgJqbBeVa6r/WAX5uu7B4Gcb
         qxF0eY7e/Uw9rDGYoMai9w6zo134O77zGmVCGL8ydKFxqOETkb3UOqNTRAvhm1o4VF8a
         hI/w==
X-Received: by 10.152.205.9 with SMTP id lc9mr19689161lac.37.1412535126539;
 Sun, 05 Oct 2014 11:52:06 -0700 (PDT)
Received: by 10.112.228.229 with HTTP; Sun, 5 Oct 2014 11:52:06 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257902>

Hi,

I think gitk is great, but I have a small annoyance with it.

As it starts up the three history panels in the top half of the screen
have the same width.

After maximizing the window they all get wider and still have the same
width as each other (scaled up proportionally, which makes sense).

But after restoring/unmaximizing the left and right panels are more
than 1/3 wide and the middle panel (author) is squashed between them.

This is on Ubuntu 14.04 trusty, but I've observed this behavior now
for years (just never actually reported it).


Martin
