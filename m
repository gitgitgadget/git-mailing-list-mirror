From: Ping Yin <pkufranky@gmail.com>
Subject: [RFC] Interactive difftool
Date: Thu, 26 Mar 2009 23:29:07 +0800
Message-ID: <46dff0320903260829j34d8c613wf9b4fcc954c8519a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>, davvid@gmail.com
X-From: git-owner@vger.kernel.org Thu Mar 26 16:30:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmrXX-0006eJ-UB
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 16:30:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752737AbZCZP3L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 11:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752206AbZCZP3K
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 11:29:10 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:19695 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976AbZCZP3J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 11:29:09 -0400
Received: by wa-out-1112.google.com with SMTP id j5so383988wah.21
        for <git@vger.kernel.org>; Thu, 26 Mar 2009 08:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=a4LZ7Eim/dzDJoghgNHyKeDM4wOM+Usomfbi+pm8+as=;
        b=ZjpHqgNoYFa7WVHfBGabG9JMtp6Fi/bWOSfYp/Eia2UsDNLcjHvYnjHUPkB036pnLP
         jdUSq+Dglm+nw4PIWJO0p2aU/sjY9UseWQ/w0jZtXP6MZb5C51sxYJWOvT3432sJTFJg
         xhjKounOBz73FaX+dybWF00Mj7aaW954M6jiw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=GD4AOty5xS6Zj2tm7MRsRYptcBvZ9o11zsUzdkELRUSFoeEwM6hMWNNyfUhEpTHLdJ
         mt02Mmkq2e2Oxza1TNDl9ArYfT6YkO5wlD6azmrtQ9gz56ocKYjBEBdZKJ5ojivDV/b7
         eZXlZz3D4kAqxwQuxA1ZNmgr5evRcr1aEi72k=
Received: by 10.115.50.5 with SMTP id c5mr690509wak.7.1238081347434; Thu, 26 
	Mar 2009 08:29:07 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114790>

Before git-difftool goes to master, i want to propose a new feature to
add to or replace the current behaviour of difftool. With current
difftool, we can only see the diff one by one. However, sometimes what
we want is to see the diff of selected files, or in a different order,
just like what we can do in the gui. So here is what i propose

$ git difftool --interactive [options]
[1] diff.c                   |   10 +++++++++-
[2] t/t4020-diff-external.sh |    8 ++++++++
Choose the file you want to see the diff of: 2

When the user types 2 and then <enter>, the external diff program is called

Further more, instead of just type a number, a letter can be prepended
to the number to represent different ways of diff. For example

t2 (tool 2): see the diff for file 2 with the configured diff tool
p2 (patch 2): see the diff for file 2 in the patch format

What do you think?

Ping Yin
