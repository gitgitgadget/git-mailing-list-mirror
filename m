From: =?Big5?B?pEG7xL5Z?= <ch3cooli@gmail.com>
Subject: git submodule update "checkout" update mode
Date: Sun, 16 Mar 2014 00:21:51 +0800
Message-ID: <CAHtLG6SPyDrD8YBpKv6bSvjtzJj8mak4ngF6_3XOPpy4VoXCXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 15 17:22:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOrLU-0007lo-Sg
	for gcvg-git-2@plane.gmane.org; Sat, 15 Mar 2014 17:22:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754905AbaCOQVx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Mar 2014 12:21:53 -0400
Received: from mail-vc0-f176.google.com ([209.85.220.176]:60820 "EHLO
	mail-vc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753734AbaCOQVw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Mar 2014 12:21:52 -0400
Received: by mail-vc0-f176.google.com with SMTP id lc6so4098044vcb.35
        for <git@vger.kernel.org>; Sat, 15 Mar 2014 09:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=vipd2nyNnAxfoBczz0YNXZr8ojnYe0EgCV/LlBrAKJQ=;
        b=mYq9oPdvb4sVT/Ru6rM25ONVsUk8OfFLBnIK91garWcTdnR5RrTaHgNSSze4fmmyi8
         x1a4ruYRDhovJ3sEvT5fqne7KRiOeBLQq0QOrXSrDIJfOPFzAeLZjGee40CAEXZQcwBe
         ak5vOK6kazpeEZ3A1tlZOQA4H+7UbMoKEkH0JcZpcNXf27qGu9OECIyAdbWVZGo3SJlJ
         fvffb57yTfmpGNHSYJDWRN+/TYY0fx9r5TqDEnAyOs/7+cxCJOOtkfM+rGnASeL97L4U
         uvu63F1Tzc8KeFaOuUmtMCyhY/RA8eL8/JWmGhdFPR7ACF4mk/bEZkxkr3FJ0gBFBmfI
         8uqw==
X-Received: by 10.52.104.68 with SMTP id gc4mr9843204vdb.2.1394900511997; Sat,
 15 Mar 2014 09:21:51 -0700 (PDT)
Received: by 10.220.132.148 with HTTP; Sat, 15 Mar 2014 09:21:51 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244157>

Hi,

In 2.0.0 release notes (00eda23),
Newly cloned submodule repositories by "git submodule update",
   when the "checkout" update mode is used, will be on a local
   branch instead of on a detached HEAD, just like submodules added
   with "git submodule add".

It is not clear.
1. Is "checkout" update mode the default? (when without any command
line options)
2. Does "merge" update mode checkouts a local branch instead of on a
detached HEAD?
