From: Chris Patti <cpatti@gmail.com>
Subject: Odd issue - The Diffs That WILL NOT DIE.
Date: Tue, 6 Dec 2011 16:43:50 -0500
Message-ID: <CAJ8P3RBm=RhNf6LKLqprqX6Rqx0OgRnJR+=+-Qhg4PvpeqaUDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 06 22:44:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RY2ns-0006HX-Rv
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 22:43:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754740Ab1LFVnw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Dec 2011 16:43:52 -0500
Received: from mail-ww0-f42.google.com ([74.125.82.42]:40982 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754481Ab1LFVnw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 16:43:52 -0500
Received: by wgbds13 with SMTP id ds13so302531wgb.1
        for <git@vger.kernel.org>; Tue, 06 Dec 2011 13:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=qLV6RyToZ0rtbWTdy54fUsm7YyjJR5JW7pjL3SJJSKw=;
        b=NOBOxEbD5vOwHyGlsW8yvS4MHnGfCu9WWY6KyQ9tQAEE+4kI6xnSopL2gRab56RwzS
         OpUUVubBfwuQzi7aJvfHQ/2qJgh8ujMJmVfriUsDSXkB5hcXhHL2SUWcIUAdaW/vH/6j
         eqC5MQOwzlxaS/mcl2KDbS4PyuksLJOIsAvW4=
Received: by 10.180.19.42 with SMTP id b10mr25080910wie.39.1323207830809; Tue,
 06 Dec 2011 13:43:50 -0800 (PST)
Received: by 10.223.88.132 with HTTP; Tue, 6 Dec 2011 13:43:50 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186392>

I have a Homebrew installed version if Git 1.7.8 running on OSX Lion.

I'm seeing a very odd issue where these diffs I didn't create keep
recurring in a particular repository.

I've tried:

* Nuking the repo and re-cloning, cloning into a totally different
containing directory
* git reset --hard, git checkout -- of the offending file supposedly
containing the diffs

Is there some sort of uber persistent local cache that's bound to the
remote repository?

Thanks in advance,
-Chris


-- 
Christopher Patti - Geek At Large | GTalk: cpatti@gmail.com | AIM:
chrisfeohpatti | P: (260) 54PATTI
"Technology challenges art, art inspires technology." - John Lasseter, Pixar
