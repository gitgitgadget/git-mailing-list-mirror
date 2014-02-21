From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: git-svn fetch after tag conversion?
Date: Fri, 21 Feb 2014 08:42:37 -0600
Message-ID: <CAHd499AnhD9V46uokx6Waj5XwBZCh-N8ms3ihkY99USej+GDOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 21 15:42:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGrJL-0004gM-Ey
	for gcvg-git-2@plane.gmane.org; Fri, 21 Feb 2014 15:42:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755398AbaBUOmj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Feb 2014 09:42:39 -0500
Received: from mail-vc0-f181.google.com ([209.85.220.181]:48216 "EHLO
	mail-vc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754396AbaBUOmi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Feb 2014 09:42:38 -0500
Received: by mail-vc0-f181.google.com with SMTP id ie18so3268834vcb.40
        for <git@vger.kernel.org>; Fri, 21 Feb 2014 06:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=Zw6b6q+qmNWAndfShkFAp/eT0tqxU//QlGdQ852lCG4=;
        b=qAQ4NN6jmzuYD6BmtgWOV6tGxWWiboO/Ip8vhOCqOh7NvLcTd50KPgf7kCNqJnLe2m
         bs2fnDn2r/GXwpmQUjfKuDypkTBs3kYzMVddfDsiEGTsppHc6nClU3sQgFx6v1mB8C20
         dDNgHZv040+UCSQlQSEUjNyeQdJiRkx7A//LWLDTmiaALr18guaMxM5xpxqYK56ymGN4
         wJgRuVmOET8GHzOm2pCAdPZ9WG7IbPSfGIW0sLwb9VIJ4HEE6TEAiaPeNaIcKeziLh1Y
         AuPQWieb+XoLvOAGSt1G4DRaCBkz43GuQNKJtt9WMdvF1XXYByiRx92Hsph6JSJNORc9
         +dWg==
X-Received: by 10.52.246.42 with SMTP id xt10mr4190878vdc.9.1392993757243;
 Fri, 21 Feb 2014 06:42:37 -0800 (PST)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.221.49.68 with HTTP; Fri, 21 Feb 2014 06:42:37 -0800 (PST)
X-Google-Sender-Auth: KgVHc-LeDNkQ5P6cqW9OJeszGE0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242464>

I'm converting a large SVN repository to a Git repository. I've run
the first step of `git svn fetch` and now I have all of my branches,
tags, and trunk. However my tags are still just branches, I have not
converted them yet.

As I transition my team over to use Git, I wonder if it is possible to
convert the tag-branches to real tags and still be able to do `git svn
fetch` afterwards to continue to pull in changes. My goal is to have
the git repository as ready as possible so that everyone can swap to
it at once (and it'll be less downtime before i can push it to
github). There are some scenarios I worry about:

- Will git re-fetch the tag-branches if they technically don't exist
anymore (they would be real tags)?
- What if a change is made to a tag, what will git-svn do?
- New tags created, will those just create new tag-branches and I can
convert them later?

Thanks in advance.
