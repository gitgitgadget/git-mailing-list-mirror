From: =?Big5?B?pEG7xL5Z?= <ch3cooli@gmail.com>
Subject: git die message written to stdout?
Date: Thu, 27 Sep 2012 00:01:39 +0800
Message-ID: <CAHtLG6T5nHw-47GdRHsXNCeArKy5X5XUmHxLnj50osKoUQa+dQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 26 18:01:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGu3h-0006Im-BD
	for gcvg-git-2@plane.gmane.org; Wed, 26 Sep 2012 18:01:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756989Ab2IZQBm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2012 12:01:42 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:64862 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752137Ab2IZQBl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2012 12:01:41 -0400
Received: by lbon3 with SMTP id n3so1916076lbo.19
        for <git@vger.kernel.org>; Wed, 26 Sep 2012 09:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=m9GU+WjAazScWqOPjm/GKklLNnBzDlRZyEjMnYrHRiM=;
        b=s+6Y2KosP/8uxzjzHnrS/45Wce9Ms7e5B+56OGgwcU5j15l1GKkwEd59WA+ow0tRaV
         bvTDn/g9KUBiuJz7uvRzAu+VgPYrK8NOAhaeEEaO8kncT2aCnEeqzc3lnglE2o6zQ+wY
         f1V1ehV5hMty8aYVKaq3+uOt1Gx4lreKUWzEbNZSk3PNimrIOXgC2Mc0Icf4CCe1FQRv
         cJ9kFaUBR3/Pr24LoKW+pzVmyrdBwASZjmZK8Npj3xJwPsW705fVS7EreT6DU9buq+Sd
         8EpZ9mwdSjiNi83RYCEDNT3ssYhO2mf6XtYgbOxb4V6UvmFzPzz+veTz4QuyNWQdBbXa
         N+LA==
Received: by 10.152.135.147 with SMTP id ps19mr881281lab.52.1348675299818;
 Wed, 26 Sep 2012 09:01:39 -0700 (PDT)
Received: by 10.112.19.35 with HTTP; Wed, 26 Sep 2012 09:01:39 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206422>

Is git die() messages written to stdout?
Should it be written to stderr?
