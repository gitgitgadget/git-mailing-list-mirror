From: Jon Seymour <jon.seymour@gmail.com>
Subject: RFD: a submodule-like facility that tracks branches rather than 
	commits
Date: Sun, 2 May 2010 21:02:58 +1000
Message-ID: <w2n2cfc40321005020402gdc210b79v2652afa849cf7a60@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 02 13:03:10 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8Wx4-0003ii-4I
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 13:03:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755857Ab0EBLDA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 May 2010 07:03:00 -0400
Received: from mail-qy0-f183.google.com ([209.85.221.183]:34451 "EHLO
	mail-qy0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754280Ab0EBLDA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 May 2010 07:03:00 -0400
Received: by qyk13 with SMTP id 13so2560319qyk.1
        for <git@vger.kernel.org>; Sun, 02 May 2010 04:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=aklaRIpJLlWwxlFOqBY0CUWsnhcQLeEPkCb9QJrec4Y=;
        b=wpNW+5QQ6MZEHuYGDwdvbizu6cKAQHuyejLkpV2sEpZHqactt5PJKtvwSBPxBsj2by
         t/tPd3lP2tW3gu754nA9xpBYBAERhVhdFV189f6f+rea55R43tcPjh7V8mJ9qljHky87
         Vhhhj4bx8/wb4B9/mW067xdQRXYepnpI2gQ6k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=LWBISem51LsA6JEOM3M3cbOHtyFQy4q5ibJ3NoM6HbUWX4HVH8jFQR4JJ8hoJQKF1L
         dO9+mltGnU7LrFVIv1ftOtyPz0NUm0owu7z8BkpMM46+8ty2/81GcNPvoXWyJvl1dP9F
         36fIdLFX3hXjXEAPqi7ieDxIZljfrVFK6QoTE=
Received: by 10.229.86.16 with SMTP id q16mr1214054qcl.39.1272798178972; Sun, 
	02 May 2010 04:02:58 -0700 (PDT)
Received: by 10.229.224.65 with HTTP; Sun, 2 May 2010 04:02:58 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146162>

Has consideration ever been given to a submodule-like facility where
the configuration information maintained in the supermodule for the
submodule is not a gitlink but is instead the name of a branch (or
generally, a symbolic reference within the nested submodule).

In this case, "git submodule update" would checkout the specified
branch of each submodule rather than the specified commit.

Of course, the intent of such a facility would be to allow git
supermodules to be used to simplify management of a group of related,
yet indOfependent, git projects.

jon.
