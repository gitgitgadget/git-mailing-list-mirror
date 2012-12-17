From: Tomas Carnecky <tomas.carnecky@gmail.com>
Subject: Re: How to specify remote branch correctly
Date: Mon, 17 Dec 2012 05:30:45 +0000
Message-ID: <1355722245-ner-6603@calvin>
References: <slrnkct0r3.dsp.narkewoody@zuhnb712.local.com>
	<CAH5451=7frqa-YHXubvO=dMK2CvVoWR-VFZ3XCmKouNiQz4gAg@mail.gmail.com>
	<slrnkcta0j.mlu.narkewoody@zuhnb712.local.com>
	<CAH5451kmTW+nO4V4pjSdaqhHAb=RX-tawLo=rJfuPnDRDWeSEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Andrew Ardill <andrew.ardill@gmail.com>,
	Woody Wu <narkewoody@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 06:31:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkTIS-0003oQ-1o
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 06:31:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810Ab2LQFbF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 00:31:05 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:55616 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750749Ab2LQFbE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 00:31:04 -0500
Received: by mail-ee0-f46.google.com with SMTP id e53so2971770eek.19
        for <git@vger.kernel.org>; Sun, 16 Dec 2012 21:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:subject:to:cc:references:in-reply-to:mime-version:date
         :message-id:content-type;
        bh=AYbDRgKL/hj7FDjzZ+zUh669Nek2vgf5A5iAVQl7ttI=;
        b=lIGdRVJRttYrAhuWopSN5u4FBLU0Ra0ozHUn1RcKoBrFM/l86yND1KaAgVM8qbeGmf
         5t1u87llb7m3ivM/RgfgkYrDyh+MeVer3IYV9RlQ2FwF/wmfuSRwespTDr1RbJ8ZqWxw
         CC7SlhWsL0mAiebnUerZbvqSn2gqZW9xpHQmMfydqNRmuuy737IiYy1n/Ut+8uoxIvNB
         XW232DRLsoxrvv2bNXnY20wfcmdSWVYZQqA/EuKVooZRPUDyyHPsYeSWNkudwYUXnRsx
         UNnGS3x2QoS42ThjZ/qJ69pIe2yVCarBbTCJMzL7c3jON+SeeXTnKdA3lTYjGquq0ULP
         do8w==
Received: by 10.14.209.193 with SMTP id s41mr38478994eeo.9.1355722262816;
        Sun, 16 Dec 2012 21:31:02 -0800 (PST)
Received: from calvin.caurea.org (pub082136067238.dh-hfc.datazug.ch. [82.136.67.238])
        by mx.google.com with ESMTPS id 46sm26811905eeg.4.2012.12.16.21.30.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 16 Dec 2012 21:31:02 -0800 (PST)
Received: by calvin.caurea.org (Postfix, from userid 3301)
	id 94051125F08; Mon, 17 Dec 2012 05:30:45 +0000 (UTC)
In-Reply-To: <CAH5451kmTW+nO4V4pjSdaqhHAb=RX-tawLo=rJfuPnDRDWeSEA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211633>

On Mon, 17 Dec 2012 16:13:08 +1100, Andrew Ardill <andrew.ardill@gmail.com> wrote:
> On 17 December 2012 16:06, Woody Wu <narkewoody@gmail.com> wrote:
> > 1. git checkout foo.
> > By this command, I think I am checking out files in my local branch
> > named foo, and after that I also switch to the branch. Right?
> 
> Correct. Your working directory (files) switch over to whatever your
> local branch 'foo' points to, and your HEAD is updated to point to
> your local branch 'foo'. Unless something goes wrong/you have
> conflicting files/uncommitted changes etc.

'git checkout foo' has special meaning if a local branch with that name
doesn't exist but there is a remote branch with that name. In that case it's
equivalent to: git checkout -t -b foo origin/foo. Because that's what people
usually want.
