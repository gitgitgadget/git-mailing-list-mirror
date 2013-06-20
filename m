From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Daily deb/rpm builds of git
Date: Thu, 20 Jun 2013 17:02:28 +0200
Message-ID: <1371740548.17896.20.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 20 17:02:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpgNh-0001gB-SK
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 17:02:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757784Ab3FTPCe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 11:02:34 -0400
Received: from mail-we0-f169.google.com ([74.125.82.169]:47569 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753541Ab3FTPCd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 11:02:33 -0400
Received: by mail-we0-f169.google.com with SMTP id n57so5599336wev.28
        for <git@vger.kernel.org>; Thu, 20 Jun 2013 08:02:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:subject:from:to:date:content-type:x-mailer:mime-version
         :content-transfer-encoding:x-gm-message-state;
        bh=wows99fdu7lta/A5NMFHhbSjwZdLYo8NRLZCGZKLx78=;
        b=iybuvlCW1hb5JX9PtKOXSp8GQq+ElulSZgXCgciUXVMtBGPDOBqsxxIKGsNDw7Z3B1
         1FvK8ANfpiiDOh600wO1kmsPLTxlFMmaRBgJIjyivOjTZo3t31U6ew4Rcvmwl+AfaKis
         htZyKvGpjSF1QOZ4PvbDmSflnwgsEAZC1DhDLO+9Gzuofci3xUep9s9vH10klN3mVUo9
         fX96k8iBKSgTwcEvAvdeLZQNbYdk47mXFwkOyjTahi/MPhYrcQAHHnjqhQXGd+QC7tAy
         ho1bppmS2vVdhRA+b/7wbSlMNTB8V96y+rNc0kweVvqFpQjJl+mVwCz8YSp3o/hmO6ke
         RRCw==
X-Received: by 10.194.60.5 with SMTP id d5mr6101728wjr.26.1371740551728;
        Thu, 20 Jun 2013 08:02:31 -0700 (PDT)
Received: from [10.42.1.4] (82-168-11-8.ip.telfort.nl. [82.168.11.8])
        by mx.google.com with ESMTPSA id ev19sm1127018wid.2.2013.06.20.08.02.29
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 20 Jun 2013 08:02:30 -0700 (PDT)
X-Mailer: Evolution 3.6.2-0ubuntu0.1 
X-Gm-Message-State: ALoCoQlMI0XHnarmNk3XVYU0xCkR3DBo3IQg7wqPP1xO+PeZlvAnVHMZNeaZ9s3cDjorA89z8zG0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228509>

Hi all,

To make it easier to help test changes that are in-flight, I've started
using and publishing daily snapshots of -next as packages for Ubuntu
12.10, 13.04 and 13.10, Debian 7.0 and Fedora 17 and 18.

If anyone else wants to use these, they can be found on launchpad and
openSUSE's build service. They could also be useful to give to people
who report issues, as a simple way to check against the latest git
development.

The .deb packages use Debian's packaging, with only the version numbers
changed. The .rpm packages use Fedora's packaging, with only the version
numbers changed. So neither are 'vanilla' git, but what people are used
to on the respective operating systems.

For Ubuntu:
sudo apt-add-repository ppa:dennis/git-next

Ubuntu alternative, because launchpad is seeing long delays
(12.10, quantal)
echo 'deb http://download.opensuse.org/repositories/home:/seveas:/git-next/xUbuntu_12.10/ ./' | sudo tee -a /etc/apt/sources.list
(13.04, raring)
echo 'deb http://download.opensuse.org/repositories/home:/seveas:/git-next/xUbuntu_13.04/ ./' | sudo tee -a /etc/apt/sources.list

For Debian 7.0:
echo 'deb http://download.opensuse.org/repositories/home:/seveas:/git-next/Debian_7.0/ ./' | sudo tee -a /etc/apt/sources.list

For Fedora:
(17)
sudo wget http://download.opensuse.org/repositories/home:/seveas:/git-next/Fedora_17/home:seveas:git-next.repo -O /etc/yum.repos.d/git-next.repo
(18)
sudo wget http://download.opensuse.org/repositories/home:/seveas:/git-next/Fedora_18/home:seveas:git-next.repo -O /etc/yum.repos.d/git-next.repo

-- 
Dennis Kaarsemaker
www.kaarsemaker.net
