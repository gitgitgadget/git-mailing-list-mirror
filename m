From: =?Big5?B?pEG7xL5Z?= <ch3cooli@gmail.com>
Subject: git pull --no-ff documentation
Date: Mon, 1 Oct 2012 11:36:16 +0800
Message-ID: <CAHtLG6ROuyCg9WK79igJ=a=6pwT+7TjOJLCNwe454oW3hiJETg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 01 05:37:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIWof-00011j-LF
	for gcvg-git-2@plane.gmane.org; Mon, 01 Oct 2012 05:37:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751902Ab2JADgS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2012 23:36:18 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:55964 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751476Ab2JADgS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2012 23:36:18 -0400
Received: by lbon3 with SMTP id n3so3627549lbo.19
        for <git@vger.kernel.org>; Sun, 30 Sep 2012 20:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=PjBEl+AdyOcUxDBbTTEPnifLjr9cO+Rmx5wnQu2jbMI=;
        b=LiDHXwmZKcI2FRxdcxdk7tUukA+YHlcfQGP1yVgL5rot6VNhD10dtcsn4mht3V4ods
         ETlqF65CU7twTQNimw7Lmd7XIarZNXPUWIaM9YTkUrBg6THgZqUliMXWm7xc9+hWPJhP
         BqXCLAx5S7xey954nH1O92QfgBHCCw11ZC4uFQ9EtXkl2r6pWSEuLA5C756qXeISJkBV
         pyeZK71qdTNMoi0SPNiQcTNHzNi5GJ8QY2/cxBv0sNE+RmOfRXLFkXvcL7E3Tjt53zB3
         yDxFi9jkTiqran0AsJk6es6/S2RUWNkOVsfpHif/gNScc+A+HW2/ZZu3i4HCzwocB4GE
         jCkA==
Received: by 10.152.47.112 with SMTP id c16mr10887009lan.50.1349062576378;
 Sun, 30 Sep 2012 20:36:16 -0700 (PDT)
Received: by 10.112.19.35 with HTTP; Sun, 30 Sep 2012 20:36:16 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206710>

Hi,

The order of options in git pull is not clear in the documentation
It only says
git pull [options] [<repository> [<refspec>...]]
So we have no idea which options should come first

I tried
git pull -v --no-tags --progress --no-ff origin
but failed with unknown option 'no-ff'.

But if I ran
git pull -v --no-ff  --no-tags --progress origin
it succeeded.

Regards,
ch3cooli
