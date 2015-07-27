From: Christian Couder <christian.couder@gmail.com>
Subject: Indenting lines starting with "die" in shell after "||"
Date: Mon, 27 Jul 2015 11:20:00 +0200
Message-ID: <CAP8UFD3UmrmREa8hN=jGNM8FMc3XHOyX9hGjfRDej_qMrNsaXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 27 11:28:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJeiL-0001GE-3V
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jul 2015 11:28:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753817AbbG0JUF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2015 05:20:05 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:32818 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752049AbbG0JUC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2015 05:20:02 -0400
Received: by wicmv11 with SMTP id mv11so130710929wic.0
        for <git@vger.kernel.org>; Mon, 27 Jul 2015 02:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=jdeO+XAnCye5VTnnjL4/K89bBIdelFFQEqie2N2W/CQ=;
        b=MLrtc8hDafWiAPmJxQD8bgK/HojjDF/XUvrdruwcE3YAew8aHj29U2jQUiC/lomWFZ
         1VnYkaQoqRBVYcU3kqxlWmU+zuMlfK3OaGWd1XuaTPG88NYnoA5n84QCoChfh6qRMaZL
         pr02vAD4VzcjzTxT+uw0VgG1j2C0Kjo6Uu8TefETo9AvSEJ3li/yfa3HNPcP2d2xSej7
         kMPkB6en2BjIvRB+IuQtdbDQHRZvnp2zWX//BFIz719vGHxIwx2LHc51BbafR9l1Ohmv
         a8slcY6/rDKEbJIMdEuSYk11w1HrXrE4c0zIKnAOLu0IngWJVkhVWBiCN+6L9LvOXSEQ
         CkeQ==
X-Received: by 10.194.23.225 with SMTP id p1mr56393966wjf.155.1437988800952;
 Mon, 27 Jul 2015 02:20:00 -0700 (PDT)
Received: by 10.194.221.229 with HTTP; Mon, 27 Jul 2015 02:20:00 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274665>

Hi,

It looks like we are very inconsistent in shell scripts about
indenting lines starting with "die" after a line that ends with "||",
like:

quite long command ||
die "command failed"

For example in git-rebase--interactive.sh, there is often, but not
always, an extra tab before the die.

It looks like there are no rules about that in Documentation/CodingGuidelines.

Also emacs in shell-script mode is reluctant to add a tab in front of
"die" in such a case.

I wonder if we should state a preference for no extra tab in
Documentation/CodingGuidelines.

Thanks,
Christian.
