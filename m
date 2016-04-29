From: termnml tml <termnml@gmail.com>
Subject: git-subtree checkout under alternate foldername (git version 2.8.1.windows.1)
Date: Fri, 29 Apr 2016 14:33:38 +0200
Message-ID: <CAEDerUrtWSeka5Er4FqktWvPWkD53VqQpvawu9DNtY-JKbMg8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 14:33:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aw7c7-0005O4-B7
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 14:33:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753000AbcD2Mdj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 08:33:39 -0400
Received: from mail-oi0-f52.google.com ([209.85.218.52]:36194 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752793AbcD2Mdj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 08:33:39 -0400
Received: by mail-oi0-f52.google.com with SMTP id x201so116579611oif.3
        for <git@vger.kernel.org>; Fri, 29 Apr 2016 05:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to;
        bh=i3g/y+RGOm/zqkHI99WLAQ4WmTkub332QcCXZvYQ11c=;
        b=s7MIHSZrpgKDjtklhk/PSLp38pTVXCNCuWjz9ckHArHs/bHPiynBtgFzWKZejFk03P
         3uzQkmvtkhlWJCSmAvLqYdQUvQgf+3kf0bMSE5SY9nUEabndDri5hEdyMMNfsVLKp2G2
         mL2eQ9WZfYwrv/VeNxlIcXu1zajscrdXfYKCYv416+YZ8/zTrZqv8CsqxcAdct+LtPNk
         Qnzxw8Afvw609e4jSPzgYlwTj3J3epEirh7zMlsj0oE0PNOZSiczBcN7XPCr4WP7nqS0
         mXYYnRbb6ntbwyL6We3ssGglxZ+tdIkU/D5QYNvk+aJpsTsYJCAB0e0vWvLTyfH2eAEY
         t/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=i3g/y+RGOm/zqkHI99WLAQ4WmTkub332QcCXZvYQ11c=;
        b=SFQeDBcq7hCfQXxqCfAjfCNKvUkpTBG8KRoYExvJCuU52+mJXYmIWiYtiJsYBVtw9Q
         gdFt87BgN6Zk3BY+w/mDdmeHj7ppf3I1z6VZrFusNeOKgQyhVDyd+cArChGFhURic8J+
         m0nSdosy3ztNeR8Dpf2/mqOZ2kKmffebx5Fb70DAxbrvMQD+qSmDfJEdm6ERguzZDbV1
         6/qcWOo+2uiPHTbFpiUeLAtEQxUPn8b78wcojbMT8LOUqO17MH5LdUB5Np5WiO6jtPmu
         haDcApjCqpynAy4TcxsBYec0CnA7/U+mw0fmcHnX9vKHbCS3O5efHulVKEGJa0WMVou+
         2RmA==
X-Gm-Message-State: AOPr4FW4F/YOX8ljfyvDyE76zd9v2EmuvpGI993n2w9ACOQrNfbbGYq9Lez9m9cInAdyZ34IQgvBlo2ACFUnOQ==
X-Received: by 10.157.49.118 with SMTP id v51mr9579347otd.97.1461933218044;
 Fri, 29 Apr 2016 05:33:38 -0700 (PDT)
Received: by 10.157.24.17 with HTTP; Fri, 29 Apr 2016 05:33:38 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292990>

Hi people.

I want to creat a git repo with two upstreams.

The first is the root of JointsWP (https://github.com/JeremyEnglert/JointsWP
) going straight to my root (repo /).
No problem with this upstream-jointswp.

The second is the sub dir /templates of WooComerce (
https://github.com/woothemes/woocommerce).
he content in this one should go directly into my subdir /woocommerce.

I was able to do a sparseCheckout to only catch the /templates subdir of
the upstream(-woocommerce:/templates).
Now I want to "mv or rename" the checked out /templates to /woocommerce.
I want to keep full track of the commits done to /templates in the
upstream-channel.

Or is the git-subtree the wrong way to go?

Stackoverflow:
http://stackoverflow.com/questions/36894522/git-subtree-checkout-specific-folder-under-other-name

Thank you great folks.

PS:
Sorry if this is the wrong place for my question.
Got a headsup to try here. ;)
