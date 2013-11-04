From: Oded Arbel <oded@geek.co.il>
Subject: Importing from subversion with full history
Date: Mon, 4 Nov 2013 09:50:16 +0200
Message-ID: <CAOqhUvzXUmF3bSX6ShQ3DpBGLgQfGyeUBabY=YkORSpSa0bvcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 04 08:50:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VdEvd-0002yM-W5
	for gcvg-git-2@plane.gmane.org; Mon, 04 Nov 2013 08:50:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751642Ab3KDHuS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Nov 2013 02:50:18 -0500
Received: from mail-ea0-f182.google.com ([209.85.215.182]:58222 "EHLO
	mail-ea0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751242Ab3KDHuR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Nov 2013 02:50:17 -0500
Received: by mail-ea0-f182.google.com with SMTP id o10so3256663eaj.27
        for <git@vger.kernel.org>; Sun, 03 Nov 2013 23:50:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=tlITqK7gXU1NieTcN3AUNfM39XAhLbqGPz4IKzN7k34=;
        b=Tuwjajhqmxbd+3tnR+/3s6ReHoRRXb/uz+/6lkDKY/xwAWWO6H6HehiEghUdi7+Sx5
         L4k1DzvgkI17/0wOls3Fm2yOYfLpG0VUN1YVd8wGCUDiJBj0wOAalM0ar5lP4ihHzY+r
         9zigffC9ZM6+zhMkWLe5QUIjyM+P7krGP4YG2A5iRCRjlwlwSYY2umFTP80MDTS3KVQj
         UgfipbqKNFs5PhMio4n3fDXYYUCcX115ZUxZjrG+9hQFwz9RBYNoe+uOS/SkMZemgQUt
         THiud4dTFMlRlkBsqeWAe7XbvofVaYzm6cw5jTbFzj/XpWDZL1UvNWI8/vTyNIeGsQ++
         7VsA==
X-Gm-Message-State: ALoCoQmTcjT8fsj4v4iW/JSPuzBo0Xf3U5RpOZxrSw4vaeNf89VayXgmylZK6/SD/RBmmp0+tf5y
X-Received: by 10.15.75.73 with SMTP id k49mr16720151eey.36.1383551416380;
 Sun, 03 Nov 2013 23:50:16 -0800 (PST)
Received: by 10.15.32.9 with HTTP; Sun, 3 Nov 2013 23:50:16 -0800 (PST)
X-Originating-IP: [134.191.232.71]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237285>

I'm trying to import our team's old subversion repository to git, but
I'd like to retain the commit history. I tried 'git svn clone' but
that only retrieves commits from the last copy onwards.

Because the svn setup is really bad, there is no way I can reproduce
the "stdlayout" structure that 'git svn' likes, or any other structure
where the trunk isn't a just few versions down from a copy.

Is there a way to have 'git svn' not do "--stop-on-copy" when fetching
history? I'm perfectly fine with getting a simple linear history
(because trying to do anything else with our svn setup will put our
sanity in danger), but I couldn't find any documentation on how to do
so.

Thanks in advance,
-- 
Oded
