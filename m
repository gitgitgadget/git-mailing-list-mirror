From: Lex Spoon <lex@lexspoon.org>
Subject: Re: [PATCH] git-p4: Use -m when running p4 changes
Date: Fri, 17 Apr 2015 09:20:21 -0400
Message-ID: <CALM2SnZmCJ2nVqPyLiepF1zJH=S0BzCTM=-L6hnn8Vnrb+prCw@mail.gmail.com>
References: <CALM2SnY62u3OXJOMSqSfghH_NYwZhzSedm3-wcde-dQCX6eB9Q@mail.gmail.com>
	<CAE5ih79UcJfuhzgTdTPy2K51sa6--4bvaVaKL3nsUcC2kq4Ffg@mail.gmail.com>
	<CALM2SnafBHz8YeWtUtQDUgLBP_s9AiJy=9UC6XveqP0zrYMEqA@mail.gmail.com>
	<55304290.9070907@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>, Pete Wyckoff <pw@padd.com>,
	Junio C Hamano <gitster@pobox.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Fri Apr 17 15:20:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yj6C3-0000EV-Hl
	for gcvg-git-2@plane.gmane.org; Fri, 17 Apr 2015 15:20:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753339AbbDQNUX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2015 09:20:23 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36382 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753183AbbDQNUV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2015 09:20:21 -0400
Received: by pabsx10 with SMTP id sx10so125199275pab.3
        for <git@vger.kernel.org>; Fri, 17 Apr 2015 06:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=gWx6HvzxCG7ua9GdYlhQum0NcoIkMujFWhkhDHdBkpA=;
        b=VFIY0vXFVt1fOjZTEugouMdMnoVUTTXNBbxZ4W5eqa/0Gf0fr5Na+Rl2APOPjTmzYs
         8wEiN8C4LbEZkbK0OxKIETwfDyUjiNNtwAWynw/sqsoL1FcHimhrclpJdliHg91ESKtf
         ObjosK4dRLTgycIizhHif3KCAEJVg3uxZiqvZIV5jNclJTTs0SMsXUoq5t9DKi3KLdA3
         mr/hedkx9lgMOHWTUgZIDNGNUFGAKV3KJY9d928hvcMWCxLmRshHEgAYgQnoWtTD84kO
         zCWrEoRA4vhOiVDApYwbhFYAYOuO3iVC5z5wex6AZEZ8z9XPv8pRVShCVpqBb+Qgfhn0
         3LJw==
X-Received: by 10.70.125.129 with SMTP id mq1mr5507493pdb.19.1429276821266;
 Fri, 17 Apr 2015 06:20:21 -0700 (PDT)
Received: by 10.70.25.132 with HTTP; Fri, 17 Apr 2015 06:20:21 -0700 (PDT)
In-Reply-To: <55304290.9070907@diamand.org>
X-Google-Sender-Auth: sCVEvXeHZT-sLyhBsxuUSmYPG6o
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267353>

Thanks, all. I will update the patch as requested and resend a [PATCH
v3]. This time without the redundant headers. I will also make an
extra effort to make sure that the raw tabs do not get converted to
spaces this time. Oof, I am really out of practice at programming with
raw tabs, much less getting them to make it through email software.
Thank you for your patience.

test_seq is a neat utility. Also, I don't know why I didn't think to
update the document page. Certainly it needs to be updated.


Lex Spoon
