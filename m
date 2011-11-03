From: Hong-Ming Su <halleyinvent@gmail.com>
Subject: How to make "git push/pull" work in non-clone repo?
Date: Thu, 3 Nov 2011 22:59:49 +0800
Message-ID: <CANiMyiFfiLnK8-q7vTZ9VAtkW8ip2NQfpR4iaU2oSnnonVDuUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 03 16:00:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLylp-0003hu-Pw
	for gcvg-git-2@lo.gmane.org; Thu, 03 Nov 2011 15:59:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933602Ab1KCO7x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Nov 2011 10:59:53 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:54614 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932765Ab1KCO7v (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Nov 2011 10:59:51 -0400
Received: by eye27 with SMTP id 27so1171696eye.19
        for <git@vger.kernel.org>; Thu, 03 Nov 2011 07:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=THigPVhnTMYN8lNh+iJ+DNi2c6RObVIE3gBjwyE7NOo=;
        b=UF3I5DCpgE2HpPPu5uAhfo3GPaj32NtWFC/JZhVDjuaDOZw4xQyt3dcD27xHjm4xTP
         U8rkwFwaID8z5uAvZGSaXPEEmKiJEgxfoUazgBb64Wji3Km8RCQ9+eHF/hTWEKwoj0Zm
         2cmTN5YHm3XQOjLNepl1Z0eV+P7TPfLNSOkZE=
Received: by 10.14.18.4 with SMTP id k4mr990071eek.169.1320332390055; Thu, 03
 Nov 2011 07:59:50 -0700 (PDT)
Received: by 10.14.127.4 with HTTP; Thu, 3 Nov 2011 07:59:49 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184719>

Hi,

I create a repo X with git init. After several commit in X, I clone a
bare repo Y from X.
I try to continue work in X, and push to/pull from Y. The command git
push and git pull fails. I see the error message but I do not know
which git command can fix that problem.
Then I clone Z from Y. git push/pull works in Z.
How to make "git push/pull" the same in X as in Z?

Thanks,
Hong-Ming
