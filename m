From: Chris Leong <walkraft@gmail.com>
Subject: Stashing individual files
Date: Tue, 3 Jan 2012 10:32:02 +1100
Message-ID: <CAJ6vYjduoBNrRcvcvQbX_yY-3-Qm5ZbXOM0WQpWRwC1H1OCqaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 03 00:32:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RhrMm-0005aD-Be
	for gcvg-git-2@lo.gmane.org; Tue, 03 Jan 2012 00:32:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753514Ab2ABXc0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jan 2012 18:32:26 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:55564 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753001Ab2ABXcY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jan 2012 18:32:24 -0500
Received: by eaad14 with SMTP id d14so8279698eaa.19
        for <git@vger.kernel.org>; Mon, 02 Jan 2012 15:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=jfEefwhWLu/0vfIfGSlqMEXGfdhy34njIZRfe7IrmMY=;
        b=DH85gus+s3dQryFpO5X83KSdkJttcKSCcbg89bIjky3tlMK79iwUKPkI+9E4nwk+ag
         jlBKKfT+Q7yZgfhEpxvYV21HY9HDGADfpielOCQfMjcfEAre6Z58hFreM8Qg4/AILM+Q
         nxZHmjr4t1xKtREg9ftuso4cAHQT+qKP4BI5U=
Received: by 10.205.134.139 with SMTP id ic11mr12024276bkc.114.1325547143326;
 Mon, 02 Jan 2012 15:32:23 -0800 (PST)
Received: by 10.205.139.5 with HTTP; Mon, 2 Jan 2012 15:32:02 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187850>

Hi all,

Thanks for making such a wonderful product. I find the stash command
really useful, but it doesn't work very well when I just need to
temporarily revert one or two files. I know that there is the
interactive command, but if you have modified a large number of files,
then it takes quite a bit of effort. Is there any way I can define an
alias, stashfiles, so that I can just type git stashfiles file1 file2?
Also, please consider adding such a feature into a future version.

Thanks,

Chris
