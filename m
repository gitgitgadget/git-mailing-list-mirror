From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Git Completion after colon in push command
Date: Thu, 14 May 2015 13:52:38 -0500
Message-ID: <CAHd499Bn_bwbjFLJpcDFF5wE0Y6EgCYqJAQOZV=H-1XWmjb69A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 14 20:52:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsyFQ-0004TK-2X
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 20:52:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933285AbbENSwj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 14:52:39 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:36586 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932807AbbENSwi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 14:52:38 -0400
Received: by iepk2 with SMTP id k2so67307455iep.3
        for <git@vger.kernel.org>; Thu, 14 May 2015 11:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=4gwdFgFxhmwDaLgbKokgCknTQkHRIWazqvjZ5KG4RUU=;
        b=gawiGIOQ7HQ7evysjllLjw93ZRbyd+/Bnp+AzzQ2Ypx6GHZeDJm62mF3PigJL0ARwd
         99aM75kJ+gr3bmgfACG1N3pt5AGjPlbZwKcckF35TwbcwQpVpWsS4hd39RaAKFR2JfQU
         cZJu+bNIAi7qWz8h8YjzS3gWSO/Tno6cUY17Gpg1XWjx+k8EFQ1baq85cZPSmQ8g90UU
         v1vFEbWdxixEQnWoZkZBS9mR+vpk+Eguf5q4G53T92+TOwsM5+gj8AI6Li5HiaQPGOl/
         RqlCzC0aRZ7ZA8hrxyxuHGoix4c0TTudpdtxlODx0ZjGlW2AICfFMAFIIfc0t3eezT7t
         nDMw==
X-Received: by 10.43.162.136 with SMTP id mk8mr16018565icc.28.1431629558147;
 Thu, 14 May 2015 11:52:38 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.36.86.148 with HTTP; Thu, 14 May 2015 11:52:38 -0700 (PDT)
X-Google-Sender-Auth: eQ8s2uszpNzWU21_K190n8HcIdM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269067>

I Googled around for an answer to this but I'm concerned maybe it's an
issue with my environment. Perhaps you guys can help me out.

I'm using Git 2.4.1 on Windows through mintty terminal. I grabbed the
latest git completion shell script from here:
https://github.com/git/git/blob/master/contrib/completion/git-completion.bash

I source it manually in my .bashrc file.

Tab completion works for ref names everywhere except for push. Suppose
I have a branch named "releases/1.2.3"

When I do this:

$ git push origin :rele

Right at the end of that, I press TAB expecting it to complete the ref
I'm pushing to delete. But it does nothing. Any reason for this? I
recall this used to work a few months ago before I upgraded.

Thanks in advance.
