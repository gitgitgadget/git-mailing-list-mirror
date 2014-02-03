From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Running "make rpm" fails on a CentOS 6.3 machine
Date: Mon, 3 Feb 2014 10:16:12 -0500
Message-ID: <CACPiFCJh8Q63801f6zk4WQ0x=A19gBj83wO6dTD4q+EsjaBXJQ@mail.gmail.com>
References: <CALMr_pWHfaHq46418UPcqGKm6bFc61jw-VqGJYV8Ogc9yuHDFA@mail.gmail.com>
 <20140130181643.GG27577@google.com> <20140130185104.GV3241@zaya.teonanacatl.net>
 <CALMr_pVP-YVJ9K7ZpQxk3d5YBFQmCZBonFeUYY1fxdZNHHZJHA@mail.gmail.com> <20140202210724.GX3241@zaya.teonanacatl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Erez Zilber <erezzi.list@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Todd Zullinger <tmz@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 03 16:16:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WALGJ-00069x-Vr
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 16:16:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751872AbaBCPQe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Feb 2014 10:16:34 -0500
Received: from mail-vb0-f50.google.com ([209.85.212.50]:59077 "EHLO
	mail-vb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751472AbaBCPQe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Feb 2014 10:16:34 -0500
Received: by mail-vb0-f50.google.com with SMTP id w8so4692430vbj.23
        for <git@vger.kernel.org>; Mon, 03 Feb 2014 07:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=SMYIle6OAiQ1Pisauyv2FbmQvCRVNwTkuj3/bRrM8tA=;
        b=t0lFCOKG2ACCo2+UJsIoLzsEYhhPeV+JZz2bA1O9pAjgopZQCkAlwT10ef3xHOLQwo
         voHXH5Gg7wKgQfABlySHGoMYmXcY/WxMsuiuL6mGtt97Ul7T4c2SXznOZpz7heZGBktr
         WxpRrxTMYZygyrJN37xpix3p3Y65JaRCj35+kdfkyBHl1HdqgaWlK62x2fmG5fFLIpCu
         orx0Q0FE/XTxU/QDTpFC+baSL1+t1VIY5n7ji02DbYsJd1fdLRJpdmFKNiE/u2eJDXdb
         tadpBfmJMQRO6baji+zO6kjbPIBl7vGV6xFCDVUD6ikvwedmmioSrBuJqN1HY1BboYdI
         XLKg==
X-Received: by 10.220.147.16 with SMTP id j16mr1434229vcv.28.1391440592317;
 Mon, 03 Feb 2014 07:16:32 -0800 (PST)
Received: by 10.220.183.138 with HTTP; Mon, 3 Feb 2014 07:16:12 -0800 (PST)
In-Reply-To: <20140202210724.GX3241@zaya.teonanacatl.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241437>

On Sun, Feb 2, 2014 at 4:07 PM, Todd Zullinger <tmz@pobox.com> wrote:
> # Install fedpkg
> $ yum install fedpkg

fedpkg is amazing. I (ab)use it (and the associated build machinery)
for lots of private package builds.

> # Create an el6 srpm
> $ fedpkg --dist el6 srpm

here I just say "fedpkg --dist el6 mockbuild" and it makes the srpm
and the binaries in mock. Automagic.

> /var/lib/mock/epel-6-x86_64/result/.

with mockbuild the packages appear in a subdir of where I'm working.


m
-- 
 martin.langhoff@gmail.com
 -  ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 ~ http://docs.moodle.org/en/User:Martin_Langhoff
