From: Lawrence Brett <lcbrett@gmail.com>
Subject: git for game development?
Date: Tue, 23 Aug 2011 16:06:47 -0700
Message-ID: <416D1A48-9916-4E44-A200-3A13C39C4D70@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 24 01:06:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qw03b-0005Dt-Kj
	for gcvg-git-2@lo.gmane.org; Wed, 24 Aug 2011 01:06:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755303Ab1HWXGv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Aug 2011 19:06:51 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:51864 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752730Ab1HWXGu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2011 19:06:50 -0400
Received: by ywf7 with SMTP id 7so476827ywf.19
        for <git@vger.kernel.org>; Tue, 23 Aug 2011 16:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:content-type:content-transfer-encoding:subject:date:message-id
         :to:mime-version:x-mailer;
        bh=wkeccO1SlsC69J7ex84sbpgvE61lRcA/sCApAh1KGA0=;
        b=x9AuCt7ECnwgTPjeR+xgB0yOyt6FCudeaWpSEzXIIqMWWxhvv4OtpFTmhI4UgZvI3U
         5KqXNYCe3Yz7GYhhs09frpZW/s3fQHgC+EMl4ybuIQzaHvTJiAzajNVk5zV+4goTRFjF
         WX7/t/fcdLCSDg7jcGNo0352SeD89gF27dHxo=
Received: by 10.150.159.16 with SMTP id h16mr4705781ybe.196.1314140809635;
        Tue, 23 Aug 2011 16:06:49 -0700 (PDT)
Received: from [192.168.1.107] (c-67-171-14-54.hsd1.wa.comcast.net [67.171.14.54])
        by mx.google.com with ESMTPS id r2sm313920ybh.10.2011.08.23.16.06.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 23 Aug 2011 16:06:49 -0700 (PDT)
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179978>

Hello,

I am very interested in using git for game development.  I will be working
with a lot of binaries (textures, 3d assets, etc.) in addition to source
files.  I'd like to be able to version these files, but I understand that
big binaries aren't git's forte.  I've found several possible workarounds
(git submodules, git-media, git-annex), but the one that seems most
promising is bup.  I started a thread on the bup mailing list to ask about
the best way to use bup with git for my purposes.  One of the respondents
suggested forking git itself to include bup functionality, thereby extending
git to handle binaries efficiently.

My question for this group is:  would there be interest in incorporating
this sort of functionality into git core?  I would certainly find it
compelling as a user, but have no idea how it would fit into the bigger
picture.

Thanks in advance!

Cliff

P.S.  I also heartily welcome any advice/insight on my use case.  :-)
