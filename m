From: "J.V." <jvsrvcs@gmail.com>
Subject: how to share files between machines?
Date: Fri, 25 May 2012 13:28:09 -0600
Message-ID: <4FBFDD49.2000801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 25 21:28:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SY0Bu-00046P-EU
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 21:28:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184Ab2EYT2P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 May 2012 15:28:15 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:38923 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756862Ab2EYT2P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2012 15:28:15 -0400
Received: by dady13 with SMTP id y13so1633785dad.19
        for <git@vger.kernel.org>; Fri, 25 May 2012 12:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=+ANkfdLJNZ4U48Ycp+sHnVL3TnjHTl7iAC3SH2HHFcc=;
        b=V6y5Tvl5m4BvvI4siyBxCrGAkX3qeGJYTeqfoR4iGPak+BtWg7dpcZfqjLUONlxHG9
         KFUoIo92DSs4M45JGiUkVDCMQrDtNvRhRe3fq26jtLA8udHQi8k6yEpcJ32XmrdbCw56
         z1/YiYfxQSBB5Kk39xzWC6AUt2cvi6NYZIgt9aTdzN/KJ77iy9ZnM0Lzx1Z+183llwhX
         Gi1BiWvTjRPgUAatdWFii7GIAjFJP1z4KGpE0AL27YGyYSpEoSXYWdHElkruRlFQ4wZE
         agEpU8yxp6IFYSxQFILpLejgoIxAdk6onRsjwEKsmfo9DHNfGUCaHJ9eqeRubX4VzEsF
         /CEQ==
Received: by 10.68.225.9 with SMTP id rg9mr254366pbc.137.1337974094701;
        Fri, 25 May 2012 12:28:14 -0700 (PDT)
Received: from [10.21.1.60] ([64.55.39.36])
        by mx.google.com with ESMTPS id tx9sm9964274pbc.10.2012.05.25.12.28.13
        (version=SSLv3 cipher=OTHER);
        Fri, 25 May 2012 12:28:14 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198511>

We have a shared git repository (origin).  Everyone on the team clones 
the repo, does some work, commits locally then pushes to the shared 
repository.

I have a box where I have cloned the repo.  I have another box (test 
box) where I have also cloned the same repo.  I change/commit/push code 
on either box to the shared repo depending on the task at hand.

Now I want to do something different.  I want to create new files on my 
local box in various directories that are part of my local git rep, and 
share them only between just the two boxes.  So I need the ability to 
commit/push to another repo such that others on the repo mentioned in 
the first sentence will not be affected.

There will be various files in various sub directories, so when I pull 
on the second box, I want all the files to come down and be put in the 
same directory that they existed on my box 1 where I committed them.

Is this at all possible? Maybe by creating a bare repository on my box 1?



J.V.
