From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Strange cherry-picking issue with 1.7.5.msysgit.1.1.g05d0e
Date: Sun, 01 May 2011 10:28:44 +0200
Message-ID: <ipj5k5$j04$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: msysgit@googlegroups.com
X-From: msysgit+bncCPLFkNe0FhDUs_TtBBoEgB85Mw@googlegroups.com Sun May 01 10:29:37 2011
Return-path: <msysgit+bncCPLFkNe0FhDUs_TtBBoEgB85Mw@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-fx0-f58.google.com ([209.85.161.58])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCPLFkNe0FhDUs_TtBBoEgB85Mw@googlegroups.com>)
	id 1QGS24-0005KP-0n
	for gcvm-msysgit@m.gmane.org; Sun, 01 May 2011 10:29:36 +0200
Received: by fxm9 with SMTP id 9sf5541978fxm.3
        for <gcvm-msysgit@m.gmane.org>; Sun, 01 May 2011 01:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:x-beenthere:received-spf:x-injected-via-gmane
         :to:from:subject:date:lines:message-id:mime-version:x-complaints-to
         :x-gmane-nntp-posting-host:user-agent:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=fZF220uth1MJWDusUCHxF1CQn3SNLoFSFILqLR90aac=;
        b=3HrRnJh9dvS9yPN9FOiOxw8AYBnkn0P42aJaU0Z1LGsV+z75fk++tewPmX68ByRlMR
         TGvNM0IbzTPMYMMprcWVncrDgzIQzkiBaUc6JWWd3k7kLJyRJPIb/Kw25nDv7uwNZoLH
         81b0wSvggGY/1S0NY/6dNARgZJRq0+ydnMnKI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:x-injected-via-gmane:to:from:subject:date
         :lines:message-id:mime-version:x-complaints-to
         :x-gmane-nntp-posting-host:user-agent:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        b=1ddyF1znkM8XIuHnr0jgL1ugxMkE8F3ZsA3j2+gua+E5V09jRqz/Cs3364rCtEAfHZ
         11lNFI+W7SVDnQGFHuyIeUe12rjRx0n+JcDBAOMtmMqp2in5hWuakrRdorIo1+f/yVjp
         uvC7vsQ88J23WPLdTfxeYuhlLpVoHkCBm2Cr4=
Received: by 10.223.160.141 with SMTP id n13mr1033223fax.21.1304238548668;
        Sun, 01 May 2011 01:29:08 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.223.60.10 with SMTP id n10ls43045fah.2.gmail; Sun, 01 May 2011
 01:29:07 -0700 (PDT)
Received: by 10.223.55.70 with SMTP id t6mr563641fag.22.1304238547575;
        Sun, 01 May 2011 01:29:07 -0700 (PDT)
Received: by 10.223.55.70 with SMTP id t6mr563640fag.22.1304238547560;
        Sun, 01 May 2011 01:29:07 -0700 (PDT)
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
        by gmr-mx.google.com with ESMTP id c13si486629fak.2.2011.05.01.01.29.07;
        Sun, 01 May 2011 01:29:07 -0700 (PDT)
Received-SPF: pass (google.com: domain of gcvm-msysgit@m.gmane.org designates 80.91.229.12 as permitted sender) client-ip=80.91.229.12;
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvm-msysgit@m.gmane.org>)
	id 1QGS1a-00059b-T3
	for msysgit@googlegroups.com; Sun, 01 May 2011 10:29:06 +0200
Received: from p5ddb02c5.dip0.t-ipconnect.de ([93.219.2.197])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <msysgit@googlegroups.com>; Sun, 01 May 2011 10:29:06 +0200
Received: from sschuberth by p5ddb02c5.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <msysgit@googlegroups.com>; Sun, 01 May 2011 10:29:06 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: p5ddb02c5.dip0.t-ipconnect.de
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
X-Original-Sender: sschuberth@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of gcvm-msysgit@m.gmane.org designates 80.91.229.12 as permitted
 sender) smtp.mail=gcvm-msysgit@m.gmane.org
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172533>

Hi,

while preparing for the msysGit 1.7.5 release, I came across a strange issue with cherry-picking when using my own local build of 1.7.5.msysgit.1.1.g05d0e (built from the msysgit.git / 4msysgit.git devel branches; note that 4msysgit.git's devel is based on git.git's aka Junio's next).

To test the recent "BindImage" additions to the Windows installer, I did:

# Create a topic branch based on msysgit.git devel:
sebastian@PASSAU / (devel)
$ git checkout -b ss/bindimage
M       git
Switched to a new branch 'ss/bindimage'

# Cherry-pick the "BindImage" commit from msysgit.git's mob:
sebastian@PASSAU / (ss/bindimage)
$ git cherry-pick 59467863efd336ba3a443a88ce140ab1e59a29f0
error: could not apply 5946786... Call BindImage on installer for all the exe and dll files
hint: after resolving the conflicts, mark the corrected paths
hint: with 'git add <paths>' or 'git rm <paths>'
hint: and commit the result with 'git commit'

# Inspect the working tree:
sebastian@PASSAU / (ss/bindimage|CHERRY-PICKING)
$ git status
# On branch ss/bindimage
# Changes to be committed:
#
#       modified:   share/WinGit/copy-files.sh
#       modified:   share/WinGit/install.iss
#
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#       modified:   git (new commits)
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       share/InnoSetup/ISCmplr.dll~5946786... Call BindImage on installer for all the exe and dll files

So the cherry-pick fails although it should apply cleanly here. If I run the same command on the same working tree using msysgit 1.7.4, the cherry-pick applies fine. And where does this strangely named untracked file come from?

Note the "CHERRY-PICKING" in the prompt which comes from js/cherry-pick-usability that we picked up from junio/next during our rebasing merge. At first I thought this issue might be related to that branch, but reverting 37f7a85 and d7e5c0c did not solve the issue for me.

Any ideas what might be causing this?

Thanks for any insights.

-- 
Sebastian Schuberth
