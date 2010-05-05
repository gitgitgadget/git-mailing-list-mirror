From: Mahesh Vaidya <forvaidya@gmail.com>
Subject: Detecting GIT_DIR runtime
Date: Wed, 5 May 2010 21:08:00 +0530
Message-ID: <t2gb42431c81005050838w425412d9jfe176c3b637e77c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 05 17:38:14 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9gfr-0000GI-QT
	for gcvg-git-2@lo.gmane.org; Wed, 05 May 2010 17:38:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932576Ab0EEPiD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 May 2010 11:38:03 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:35050 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760536Ab0EEPiB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 May 2010 11:38:01 -0400
Received: by pwi5 with SMTP id 5so876408pwi.19
        for <git@vger.kernel.org>; Wed, 05 May 2010 08:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=Nc1FuKDTaebySyzp0tU1uZzSDpCK6cJspH5oCa1XEjQ=;
        b=Tez3c6NQlPv+kBeQ3ajJL754xj8fvF/cs63A5XSzaib50sGzYZT1uqeNL0oNP0qeb7
         /guYjCtUdlP/NxbO6LUNmeP1EFOkUbzXqPMw4hM7ZXONMu1W5M+Xu8MZNRYs7deZ3Xgu
         4WuApS9x6Vwb+UQqMmiaD8dTu18uZ8qbZAW/U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=C4yYvMQBmCi6wdv0G+IeGhu3ufJ0+VyeEPyQiqJrPnwpNL6FXxXCoubZSaxuRhiEln
         IGP+9pTTUFXczedyqfivyvjRwO9NWEt1tI2d3IUY/LNvG61oblaxYcGfZFr8T4rmkHKe
         0Nva0/8broTN5yj525TSIM7/CEq2pEyEzRRbE=
Received: by 10.142.195.9 with SMTP id s9mr4988571wff.55.1273073880281; Wed, 
	05 May 2010 08:38:00 -0700 (PDT)
Received: by 10.142.156.16 with HTTP; Wed, 5 May 2010 08:38:00 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146406>

I have a tree like
/home/mvaidya/WORKSPACE/nvos/mvaidya-master-100.local/some/folder

I would like to issue come command say "git fetch" from any level of
the tree. How can I deduce path of .git folder. Reason I need it as I
some application configuration saved in .git/workspace.properties and
I need to some action before git fetch.



-- 
Thank you and best regards.
Mahesh Vaidya  / 9740500144
http://www.twitter.com/forvaidya
