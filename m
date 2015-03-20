From: Ray Xie <samuiotoko925@gmail.com>
Subject: A git hook that does git cherry-pick and push automatically
Date: Thu, 19 Mar 2015 21:07:28 -0700
Message-ID: <CAA4Z6SXzekMdPgKKaXqAObPcpFXDWpaQvNhJg6DEsOxbMOy3Lw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 20 05:07:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYoDe-0003m9-KU
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 05:07:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750914AbbCTEHa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 00:07:30 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:33021 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782AbbCTEH3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 00:07:29 -0400
Received: by iecvj10 with SMTP id vj10so84009142iec.0
        for <git@vger.kernel.org>; Thu, 19 Mar 2015 21:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=9hpXbbULYr18Bq7iaSm8EMJLi2HJzhQo86P+1jQftGI=;
        b=YdTbuywVA8Y6QuWD7gEAX5KXSTTG/9lfi1CpqmHXobTsusrNXUYWcMm/dv24LfHMJ3
         zqlrbW8ko2Dyei8uqOXXSfmG4z3dsp32CimvAFCUibwLYSKb3HJx8lf7TmRm5QWXuoXD
         6uekm5TupihQcRu9SaaVf3gvTsQpT0TrF7o5C6KU9C2IphJwe63T9zgqr1mVYDBBFz/d
         uTwxFnXyKSwL5tL3CfjSNjqIot+IUQYXo6Fg2F8ra1MiZk4usWHLMrTYEul0ruGJOeSc
         zqWUL3BjyU7jsQWHCiO0FWbuvAb9vcU5GCTx5HlYeVemhOOlAqVneQ44JTDzL0cYtKUe
         iQ9g==
X-Received: by 10.50.79.230 with SMTP id m6mr1856077igx.33.1426824448761; Thu,
 19 Mar 2015 21:07:28 -0700 (PDT)
Received: by 10.107.24.66 with HTTP; Thu, 19 Mar 2015 21:07:28 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265861>

So today I had a shocking moment while I was doing my cherry-pick,
after I performed all the pre-checkin duties (the usual build the
code, run the test to make sure the cherry-pick infact works), I found
out that my original commit was already cherry-picked, then I found
out someone in engineering make the decision to do an automate
cherry-pick from that branch to another so he added a git hook to run
do cherry-pick and push on every commit, yes, a simple cherry-pick
then push; mind you, these are not feature / dev branch, these are
release branches, both of them.

Then after I came back from the shock, made a big protest about how
this is the worst thing I have seen and I will never live with it, and
that's why "git cherry-pick" and "git push" are 2 separate commands,
as any reasonable developer, you do your very best to ensure you are
not pushing something that is fundamentally broken; however for the
life of me and talk these few people into senses.

So, I am sending this to seek for some expert advice how I can drive
some sense into these people so they don't screw up my life as an
developer.

Regards,
Desperate developer, Ray.
