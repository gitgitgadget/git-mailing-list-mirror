From: suvayu ali <fatkasuvayu+linux@gmail.com>
Subject: Qn about git pull and git fetch
Date: Tue, 28 Sep 2010 09:59:03 -0700
Message-ID: <AANLkTi=-UU8X-7h8c4=UENRwNe+G2xGy54YhvWPnnY7y@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 28 19:00:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0dX8-0004W4-9j
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 19:00:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756947Ab0I1Q75 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 12:59:57 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:55068 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756692Ab0I1Q74 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 12:59:56 -0400
Received: by wyb28 with SMTP id 28so5171485wyb.19
        for <git@vger.kernel.org>; Tue, 28 Sep 2010 09:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received:from:date
         :x-google-sender-auth:message-id:subject:to:content-type;
        bh=FQcTdfJMmq570xdqEI3SIHrEslUyALBpmMsv3HnjnZE=;
        b=IjfNge+yW6y3H8Gn70/0cVYRV0BBrbyps7x16+dwkPOp0CByduQIhsn4L3UX4kbkVA
         WHmgWlY5Hucephm5kekgZyQ3JLO1m9aIsdFULgRGIkDxMsQy/4d/1Y0qPcqrTPYjcmUi
         K+v4DtO1b9f0QfEk59a8iYOFh7yVCJqAoDLWI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:from:date:x-google-sender-auth:message-id
         :subject:to:content-type;
        b=jZN6bcc7bgf+4GMxSMv7EGMdlu8zqRszJs6Palo4F11Ke3/1ZIGLVrSl8b0a5tG15J
         +4dxe3rbLh+czcjfunqx/eqCfI3Grs8UqQ9g0wrXtXQD94eGoZ1ldMY7qb+AKPdMf4Gv
         YBZEPMm6ueR1QgZnBku3usI4vcK1mqEc5WAC0=
Received: by 10.216.158.140 with SMTP id q12mr1370900wek.14.1285693165334;
 Tue, 28 Sep 2010 09:59:25 -0700 (PDT)
Received: by 10.216.86.3 with HTTP; Tue, 28 Sep 2010 09:59:03 -0700 (PDT)
X-Google-Sender-Auth: 2CsgIW6gENEE-iqd9W-QtMQbHh8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157444>

Hi everyone,

This is my first post to the list. I am a new (few months now) git
user and I use it for source code and notes for my research projects.
I noticed something during the course of my use. If I have a remote
tracking repository, and I do a `git pull origin master', the latest
changes are merged into my currently checked out branch. But the
references to the remote repo are not. So when I fire up gitk like
this, `gitk --all &' I don't see the latest commits for origin/master.
I have to manually run `git fetch origin' or `git remote update
origin' to see the updated commits in gitk.

This is not an inconvenience for me, just a little puzzling since the
man page says git pull runs `git fetch' followed by `git mege'. Just
out of curiosity, is there any reason for this choice?

-- 
Suvayu

Open source is the future. It sets us free.
