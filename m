From: Lin Mac <mkl0301@gmail.com>
Subject: How to undo changes?
Date: Thu, 29 Apr 2010 09:08:19 +0800
Message-ID: <l2l10d816431004281808s79a559e6p308052c788c9a4ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 29 03:08:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O7IEt-0007KG-05
	for gcvg-git-2@lo.gmane.org; Thu, 29 Apr 2010 03:08:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755633Ab0D2BIU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Apr 2010 21:08:20 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:62582 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755009Ab0D2BIT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Apr 2010 21:08:19 -0400
Received: by pxi17 with SMTP id 17so3036184pxi.19
        for <git@vger.kernel.org>; Wed, 28 Apr 2010 18:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=bTKi98Oa8ZxgoPYOWn6UB7h9zQp579H0zCULTn2Vgc0=;
        b=kGtxG1evC+2AfomQ8cVHjQAs3bn8/K1N2BnqYhylLsGTgqsMhB+fbkRKPy/ks6WS34
         RmTtILibaR1Dv1ZNN4exwx3J88L7jYRhlLyZEKz75xaK+CYl+Qifh8LyOOhQhSF4N1M4
         //dfzh83u0CLbI4b4OqSvgcbssZ+M1KGpfpHI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=eM6XaGjKtvcxcb8wb6UEAywbJ2Ds5Z/hge6vVIok4eGzmyIlUYkFCmX4HvJ3gFrSMh
         zLAwOeAgyoQGNUzBIMozDEqJbcamIR5KfNZcqsIW171sN1qAG0QgUkbcUL7m2f6BS5ik
         cZ0YSJXmSH7lu0Dz2Kb3lq2ZeDo4vMlH9N+rw=
Received: by 10.141.188.27 with SMTP id q27mr762684rvp.73.1272503299088; Wed, 
	28 Apr 2010 18:08:19 -0700 (PDT)
Received: by 10.140.135.7 with HTTP; Wed, 28 Apr 2010 18:08:19 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146024>

Hi,

1.
I have multiple files modified, but would like to undo the changes in
one of the changed files.
"git reset --hard" do not accept single files. So I used to use "git
diff <file> | patch -p X", but X cannot be know until I checked the
patch and know the path relationship. Is there other way to do it?

2.
Sometimes I delete old unused branches with "git branch -D <branch>",
but I just realized theren't a reflog log for such operation. If the
branch is the only reference to the logs, deleting the branch makes
the commits become dangling commits.  How could I recover those
commit?

I run into situation 1 from time to time. Luckily I have never ran
into situation 2, but would like to know the recovery ways.
Thanks in advance.

Best Regards,
Mac Lin
