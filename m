From: Allan Acheampong <allanadjei@gmail.com>
Subject: Git Clone Parameter
Date: Fri, 19 Jul 2013 11:21:01 +0200
Message-ID: <FB572366-0B1D-4053-9255-979CB213B160@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 19 11:21:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V06sE-0007Lr-8P
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 11:21:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759877Ab3GSJVJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 05:21:09 -0400
Received: from mail-ee0-f50.google.com ([74.125.83.50]:37066 "EHLO
	mail-ee0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751771Ab3GSJVI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Jul 2013 05:21:08 -0400
Received: by mail-ee0-f50.google.com with SMTP id d49so2204001eek.23
        for <git@vger.kernel.org>; Fri, 19 Jul 2013 02:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:content-type:content-transfer-encoding:subject:message-id:date
         :to:mime-version:x-mailer;
        bh=aszsPhnDmFlMp4xz18R1/jaFel5ZSIzpTHvCOeCulIw=;
        b=kXpCv3TgH3jEgcZwNzHnbka+ok8HFJ77hfSzo53dGGN+ashPzSouMX3/hnqXyfQjU9
         mBYfSMwOwcDVDj+dYBENB3qUkdHF+phwk75I/B7eagCYnhgeeeVnVsPevkSZjE8jjruW
         2pydi0zZC1HxB9IoswEEiq+Ukl68fbkKVx0q9itrOE0p6NEnHhL8P9rclMdBVV8r8bwh
         2GsEXuD0vpEraPfDKi3PKoESG07SWhI17odZ2WOL96gJx2tv74GdXlTvyZxEY89OY+MT
         ez15R9B2h5empO92G/9Gxx4DK3ChvXfUg5Y+rVaLznJSKj26h7JSkIRZMk2gVHRa6Q4e
         QQMQ==
X-Received: by 10.14.110.9 with SMTP id t9mr14981862eeg.115.1374225666805;
        Fri, 19 Jul 2013 02:21:06 -0700 (PDT)
Received: from [192.168.1.136] (dslb-092-073-248-223.pools.arcor-ip.net. [92.73.248.223])
        by mx.google.com with ESMTPSA id r54sm25868429eev.8.2013.07.19.02.21.04
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 19 Jul 2013 02:21:05 -0700 (PDT)
X-Mailer: Apple Mail (2.1508)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230786>

Hi,

it would be nice to have a parameter on 'git clone' that not only clones the repo, but also creates local branches for ALL the branches that are in the repo. I'm new to git, but I found it very confusing to understand the difference between "remote" , "remotes". Is it in the cloned repo, or is it in  a remote place? If its local, why doesn't it get shown when I do 'git branch' but when I do 'git branch -a'. For example, I create a project locally with multiple branches, push it, delete it locally and clone it back to my machine. On a 'git branch' I would only see the head branch. I understand that there are projects that have a lot of branches that are not needed for that specific developer, but still it would be nice if one could specify this at clone time. Something like 'git clone <theR
 epo> -createLocalBranchesForAllBranches' . Of course the param shouldn't be that long. I could write a script with for each in but thats way too much hassle and effort for something that should be there already and I don't think I am the first to get confused by this.

I'd like to know your opinions about that and what you think about the suggestion.
Allan.