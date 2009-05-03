From: Nicolas Sebrecht <nicolas.s.dev@gmail.com>
Subject: [gitosis] unexpected error for a warning msg
Date: Mon, 4 May 2009 01:23:00 +0200
Message-ID: <20090503232300.GA20066@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: nicolas.s.dev@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 04 01:23:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0l1i-0003LL-0U
	for gcvg-git-2@gmane.org; Mon, 04 May 2009 01:23:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755197AbZECXXJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 May 2009 19:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753686AbZECXXI
	(ORCPT <rfc822;git-outgoing>); Sun, 3 May 2009 19:23:08 -0400
Received: from mail-ew0-f224.google.com ([209.85.219.224]:62235 "EHLO
	mail-ew0-f224.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753420AbZECXXH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 May 2009 19:23:07 -0400
Received: by ewy24 with SMTP id 24so3525610ewy.37
        for <git@vger.kernel.org>; Sun, 03 May 2009 16:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:mime-version:content-type:content-disposition
         :user-agent;
        bh=hfbesEyf9uEs11AnW5OirG+VmfuG83JntnyfvQ+i5wk=;
        b=ocWszmx16RwC0/8qEkZBChKbQvd0iw9smvXcRajNxkzRn/tevbdLjcqTvx0kGL1tK5
         /PfAYCMW0OhSiDKZOMXYa7c5xWjSrr+0k7iN0le5MzZT+i2wjaCragm8hQEodNrYqA3y
         abQE+B+l5DvkptO5tT1je/MJRV6oJw7RJA+sc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=DCV84wj4R0jg2rew0VFG4/IhTAwEzU+qqxRicJqUggGp4bzWUKgSdMeUIR4t29XiVj
         jZOhMswhRm3mpP0NUxRW+AivIHPPNlbPw9AoRaRBd9OogMIVsPWqxcS/m3ZY+5PmqnKW
         a3v4DEzb2oJ8eFuXU8iypq5z51+nF0EPvWoR0=
Received: by 10.210.20.6 with SMTP id 6mr2060895ebt.72.1241392984572;
        Sun, 03 May 2009 16:23:04 -0700 (PDT)
Received: from @ (91-164-143-25.rev.libertysurf.net [91.164.143.25])
        by mx.google.com with ESMTPS id 24sm9781301eyx.33.2009.05.03.16.23.02
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 03 May 2009 16:23:04 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118196>

Hi,

I had the following issue using gitosis today:
http://colabti.org/irclogger/irclogger_log/git?date=2009-05-03#l2233

The name of the key file was 'keydir/Jacques@BLACK_ANTEC.pub' which gave
the warning (when pushing): 
WARNING:gitosis.ssh:Unsafe SSH username in keyfile: Jacques@BLACK_ANTEC.pub

Changing the filename into Jacques.pub solved the issue.

I was expecting an error message instead (not a warning) as it seems to
_not_ permit such a filename.

Why the initial filename is fobidden?
Could the warning be substituted by an error?

Thanks,

-- 
Nicolas Sebrecht
