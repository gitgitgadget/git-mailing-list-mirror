From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2 44/44] request-pull: rewrite to C
Date: Sun, 29 Sep 2013 11:35:33 +0530
Message-ID: <CALkWK0nHYt-=gCCavo4tgbgcQFgideDokKakyHxH3VJJtodOnA@mail.gmail.com>
References: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com> <1380405849-13000-45-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 29 08:06:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQA9R-0002q0-Vv
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 08:06:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752788Ab3I2GGc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Sep 2013 02:06:32 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:62595 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752663Ab3I2GGO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Sep 2013 02:06:14 -0400
Received: by mail-ie0-f179.google.com with SMTP id e14so7480613iej.38
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 23:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Cikb8iwt84uLRHpPn95/d2PlWYaXFdjW7ZrqdMhOIqA=;
        b=0QntfJlDWlwPl50euYe+pTzjcPc0+w6/i3O7ZeS2cnlJYyY3xBfZhz+YP8SQVxYLnO
         mH7vf1q+vZqqj5CILgiNJzucYv4Uv2YwBkC2BgKhQEP0IAzZeoxeJFmoPoeXFJl6c1n6
         2FwOSuIX+Bw6tsZJlm2caXKb0Eizfiq3kZvjDOrBz35ZDeASPslDEK8s8k1w2ET6SBdh
         2/K5GAxLcdzO4K4CdAnDMEBeuyalje5l1j/nInfiEHD1kCpfzBK6zZATLipfvQvX7q6u
         7ysET80Ij4y3AGzFOnZJJKUYv+qBDmbfwixFiz1V0SsXunkZ09lVa25YKZjOyDMRrgut
         j7Mw==
X-Received: by 10.42.61.147 with SMTP id u19mr11868565ich.36.1380434773398;
 Sat, 28 Sep 2013 23:06:13 -0700 (PDT)
Received: by 10.64.73.36 with HTTP; Sat, 28 Sep 2013 23:05:33 -0700 (PDT)
In-Reply-To: <1380405849-13000-45-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235593>

Felipe Contreras wrote:
>  builtin/request-pull.c | 275 +++++++++++++++++++++++++++++++++++++++++++++++++
>  git-request-pull.rb    | 199 -----------------------------------

My head started hurting beyond part 15: I need more coffee ;)

Right now, I'm looking at these two side by side:
https://github.com/felipec/git/blob/724e759e777e21ddc1e1a77b5bad16a301dffe38/git-request-pull.rb
https://github.com/felipec/git/blob/68dd43654e265d8ebe42daf43646c636d3f0ff99/builtin/request-pull.c

Truly beautiful. No more
kitchen-sink-dependency-embedded-lua-language-war-flame fud.

I look forward to more eyes, and a clean merge. Part 2 is missing a
commit message, but the rest of your series looks very reasonable.
Thanks a lot for doing this! You've opened the door for an incredible
amount of learning opportunities.
