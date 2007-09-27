From: "Kelvie Wong" <kelvie@ieee.org>
Subject: Mergetool generating blank files (1.5.3)
Date: Thu, 27 Sep 2007 11:31:19 -0700
Message-ID: <94ccbe710709271131o620bf1far8893328ce98f0ba4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 27 20:31:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iay99-0003Zx-1V
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 20:31:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753827AbXI0Sb0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 14:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753797AbXI0SbZ
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 14:31:25 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:10431 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753476AbXI0SbZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 14:31:25 -0400
Received: by wa-out-1112.google.com with SMTP id v27so3260134wah
        for <git@vger.kernel.org>; Thu, 27 Sep 2007 11:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        bh=6pi+XYoKlCcwnO4wPYRGVHi/dpdUl/JZJGjLpxqOdk8=;
        b=uTTkS7Fg5isC0KgIgoFnQ3rb9qbmgDkRtHuDwURPpu6QhZAxVFFdb9Dgqh2Tfa8bKkHqN7PXN8aKNQjXRlOhrgVyvLQlNN5z7hHco17QLZjoviyW9QfSo23OYCUKpfnX4eYSVHFhl8PzW4wJIpOmgIUJwn/AU2FeXvBizqxqSg4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=LeuEyK4nEp6nrSLxPI1qI07YQ2pTmFaCtRxYUqcVpzrpXf1DHqINpDqbC7E8ZfKD5/eMD3p1xJlgZSt7wPvPVxkWu7F6YtkEBZjBmn1uecuKbvcf+dYWEUF9mumlIbseM8Q849qQFr1xgemXCUiRcIfGvPjtNoOKbQ4SVKXU2Gc=
Received: by 10.114.254.1 with SMTP id b1mr1047296wai.1190917884508;
        Thu, 27 Sep 2007 11:31:24 -0700 (PDT)
Received: by 10.114.144.17 with HTTP; Thu, 27 Sep 2007 11:31:19 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: 00b52464315cb811
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59307>

At work, I've been using a git-svn import for my daily workflow (still
somewhat of a git newbie, but now has come to the point where it's
tough to work without it), and while rebasing from svn (on a rather
old branch), I found that the mergetool option does not work too well
for me.

I am using version 1.5.3 and I have tried all of the different diff
tools (save opendiff) that are supported by git -- but in the middle
of a rebase, whenever I run the mergetool, the LOCAL, REMOTE, and BASE
temporary files that are created are all empty.  The BACKUP file
remains, and still has the proper 3-way-merge conflict syntax (with
<<<< ==== >>>>) and such, but the other files are all empty -- and
thus the mergetool of choice does not read it (it shows up empty there
too, of course).

What could I do to fix this?  I'm confident that there are conflicts
(git tells me so, and I end up manually going through all the files in
emacs anyways, but it's very tedious); or is there another tool that
reads the 3-way-merge syntax (the < = >'s) and lets me pick one or the
other, or do I have to write my own?

I know there's just something funky on my system, because someone else
doesn't seem to have this problem on his computer -- maybe it is
because I use the svn rebase, but it does that when I rebase onto
another branch too.

Thanks.

-- 
Kelvie
