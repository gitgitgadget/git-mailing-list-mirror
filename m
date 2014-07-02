From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Show containing branches in log?
Date: Wed, 2 Jul 2014 09:50:57 -0500
Message-ID: <CAHd499A78BRVawWSHNnzJcD1Ca7RfFeEnJf0SB7py1MD5qwL0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 02 16:51:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2LsE-0007Ln-TI
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jul 2014 16:51:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754581AbaGBOu6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2014 10:50:58 -0400
Received: from mail-vc0-f171.google.com ([209.85.220.171]:44576 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754555AbaGBOu5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2014 10:50:57 -0400
Received: by mail-vc0-f171.google.com with SMTP id id10so10491811vcb.16
        for <git@vger.kernel.org>; Wed, 02 Jul 2014 07:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=fbG91jVQK7KCX7n8QN12x4geYGZk7gqxOshTGjv/5Hk=;
        b=nlrdD9LjxV6JjwP9h4td6ZQU5W0JPwr089t/irOIu6sRKdigITwcU+Fz9hi/axwb06
         2aDBKQAgA/Qa/TRdpU/Q0s+QLxcunf5AepgsQDWK/tOJs4Sw3tMOL/YLb5phwWaXMdRm
         gnb1lmvowlErpEiwee5dJUvcHxMwAVczpabsXxgMkPKv6GtSyqwUQ12qUrhrCfTtsUNu
         NS30BGJu+5hDQGEoQo4njRgh7XUX5qwUxcXBeVo3xHEBrcycecMHKMqIEYkkapqKTFWX
         ukO7WwftIkK61urL4Jbi5Q/4WxaMEaOx0zabwu8PkdEL+50/4lcL7DKJg8nh89al2+6Y
         DbHw==
X-Received: by 10.52.121.52 with SMTP id lh20mr37289674vdb.11.1404312657104;
 Wed, 02 Jul 2014 07:50:57 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.220.102.204 with HTTP; Wed, 2 Jul 2014 07:50:57 -0700 (PDT)
X-Google-Sender-Auth: XgrVssvIZKMDZpYGTtYS5VxZKOU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252784>

I know that with the `git branch` command I can determine which
branches contain a commit. Is there a way to represent this
graphically with `git log`? Sometimes I just have a commit, and I need
to find out what branch contains that commit. The reason why `git
branch --contains` doesn't solve this problem for me is that it names
almost all branches because of merge commits. Too much ancestry has
been built since this commit, so there is no way to find the "closest"
branch that contains that commit.

Is there a way to graphically see what is the "nearest" named ref to
the specified commit in the logs?
