From: "Mark Ryden" <markryde@gmail.com>
Subject: checking action of git-pull
Date: Sun, 7 Dec 2008 10:23:18 +0200
Message-ID: <dac45060812070023h7f6a6c86ve2e4ba9f1773f03f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 07 09:24:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9Ewg-0005jn-4l
	for gcvg-git-2@gmane.org; Sun, 07 Dec 2008 09:24:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753751AbYLGIXU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Dec 2008 03:23:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753766AbYLGIXU
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Dec 2008 03:23:20 -0500
Received: from yw-out-2324.google.com ([74.125.46.30]:5380 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753751AbYLGIXT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Dec 2008 03:23:19 -0500
Received: by yw-out-2324.google.com with SMTP id 9so292061ywe.1
        for <git@vger.kernel.org>; Sun, 07 Dec 2008 00:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=yBbF6yJ2FmqhD6I1qAaY5sxaotDTQT0WtbAwPsKJw8U=;
        b=JU4XoNKH5uJSAsapCm2KUUIkBodhtGpMgOtxibJXnYdojWPD/egQlZaHP92w79QMKu
         UZc/aOpITo7BlPkwfYrskXklArblhZAJw4dXWGy76Y/c2RLcK66Tk+SYeXGt2ragt353
         8Z+mXetJDE/NqRje9VJD7jiYET1paWI4H1Lxg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=pn9aKqpK6rfNo5+qPcOTVRGttudFa0sF0xie5x6VMMW6yohNidLTH7tMZM9al1uQ8U
         exZvyuYPnggobuWU1cD91uATFDLX6K06fYKiXtc5CUeKKPXfN5GHPXIrrTSzjI9eQnAY
         DoCusTsY2TAvfyuW/93gjfPyM5sTSdkd3jCzM=
Received: by 10.90.35.15 with SMTP id i15mr753513agi.39.1228638198297;
        Sun, 07 Dec 2008 00:23:18 -0800 (PST)
Received: by 10.90.26.11 with HTTP; Sun, 7 Dec 2008 00:23:18 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102490>

Hello,
  I am working against a git repository which is updated at non regular
intervals; sometimes it takes a day and sometimes a week or two.

I have a script in crontab which runs daily which tries "git pull" of
this repository.

I want write a bash script which echoes yhe  result of this git pull
to a log file in such
a way that in case that any files were pulled, a short message
saying "files were pulled at date ddmmyyyy" will be added to a log file.
In case that there there were no changes, a message saying
"Already up-to-date (ddmmyyyy) will be added to a log file.

How can it be done ?
can I test somehow the return value of git pull in a bash script for
these two different
cases?

Regards,
Mark
