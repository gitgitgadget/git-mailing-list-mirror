From: "Alexander Gladysh" <agladysh@gmail.com>
Subject: [Q] Tell Git to follow symlinks?
Date: Sun, 24 Feb 2008 14:05:36 +0300
Message-ID: <c6c947f60802240305w40a7af96yc47f90e573384c04@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 24 12:06:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTEgR-00072T-5j
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 12:06:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752082AbYBXLFj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2008 06:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752011AbYBXLFi
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 06:05:38 -0500
Received: from wr-out-0506.google.com ([64.233.184.238]:21142 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751937AbYBXLFh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 06:05:37 -0500
Received: by wr-out-0506.google.com with SMTP id c48so1652323wra.23
        for <git@vger.kernel.org>; Sun, 24 Feb 2008 03:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=hnTLkMDNqvUIrhFmE6vW+dtVp4kbg6sqUHwxtS0LKKU=;
        b=gYWnkd+5OSDhAYaJHp3Geyu6idZj57BTCEh3Q9ZZteaBsVtUBKIKkGjG+hpYDXoC8u00uRT4hGx3hhcEzxzWmyt1VqjBt1XdbZQvhD9GZ6psCDmQ9Rx+KOAgXnPejNsUGtLfB/yy7wLKaEgL/1jNKqSwHH19D2b5xSCOduIfMi4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Wu/kVWLdGy4lQCyK7HWnTn+hNZVifyOvQhnwltNxBjCTLb+VxyPb3+B+zipHklNPrfFgcprpT+/hmTl5lr9DxMCObkuTRDAwSqiWme6cMEpBlv8UNmnqrCPjfvw3xz5e9F1DRL2SYV9DQiVnwdD4NPHAJ8nstDwf+As4hrhjMds=
Received: by 10.114.160.1 with SMTP id i1mr1780056wae.49.1203851136135;
        Sun, 24 Feb 2008 03:05:36 -0800 (PST)
Received: by 10.115.109.14 with HTTP; Sun, 24 Feb 2008 03:05:36 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74925>

Hi, list!

Sorry for a rather dumb question.

I'm trying to build a rudimentary GIT-based backup system for my remote host.

I want to put all relevant data (which is scattered throught the
system) under single large Git backup-only (i.e. no development)
repository.

And then on the remote system set cron to do something like

    git add . && git commit -m "`date`" && git gc

And on local system set cron to do git pull.

I thought to construct my repo of the number of symlinks to other
places, but apparently Git does not follow any simlinks.

I have considered using zillion of git submodules, but looks like this
solution would demand more work than I'd like to put in there.

Please give me some directions on the building such dumb backup system I want :)

Thanks in advance,
Alexander.
