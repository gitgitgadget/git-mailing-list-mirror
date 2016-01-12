From: Tobias Preuss <tobias.preuss@googlemail.com>
Subject: gitk: Follow renames
Date: Tue, 12 Jan 2016 17:11:31 +0100
Message-ID: <CADEaiE_tfegbD4VCHRUaYjAwWBV5H+wpJEnaCVEABOn8-9+5NA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Heiko Voigt <hvoigt@hvoigt.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 12 17:11:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJ1Y4-0008WI-Uq
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 17:11:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762503AbcALQLx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 11:11:53 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:37400 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753539AbcALQLw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 11:11:52 -0500
Received: by mail-wm0-f49.google.com with SMTP id f206so328402850wmf.0
        for <git@vger.kernel.org>; Tue, 12 Jan 2016 08:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=fEC4qVOGySs71//baxf1lF7wCK0PafktEsp09tkQqqI=;
        b=TOg085eRusk2gXkgWyCyPN6ZDuX1tgNnLrX635/02iCn8jAQ2JyagodAlRDtPUq2Yo
         +w84dkUMokn6wxW0YfZNkuZNvfkraVZazBpZ6tyk7Fn5hVYbSoGtz6k7nBYPWpVLVU7o
         +a8yWCwQ0BbLWGJTRuJy3ylOWdfqVlOTIp2CTiOhnKTO2poZYRDAgOGMPOdSuBUskbR7
         jijLO7sL4x3sfkvogCUUVsINimskA6DxoCuvvAd3bieGHecAnBhyF5zgowZ1q8+bLR04
         JuznS0Xg0mFAnBMUjDR8iTG0r9v9PyXL9xlgxasTG3X1V6yUjLOBszkSKvpqMWw+JUDe
         teLQ==
X-Received: by 10.28.171.135 with SMTP id u129mr19228969wme.99.1452615111444;
 Tue, 12 Jan 2016 08:11:51 -0800 (PST)
Received: by 10.27.137.68 with HTTP; Tue, 12 Jan 2016 08:11:31 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283825>

Hello.

I am using gitk to lookup changes to specific files:

$ gitk example.txt

I noticed that the history is cut off if I renamed or moved the file
somewhen in the past.
Although I use the --follow parameter gitk does not resolve the former
file history:

$ gitk --follow example.txt

However, when I use git log --follow the full history is output:

$ git log --follow example.txt

Can you please let gitk resolve the full history as git log does already?

Thank you for your work! I appreciate very much.
Best regards, Tobias
