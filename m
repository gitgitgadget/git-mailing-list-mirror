From: Henrik Nilsson <henrik30000@gmail.com>
Subject: New Bzr to Git migration tool
Date: Thu, 9 Jul 2009 16:59:30 +0000
Message-ID: <d51232210907090959v5dfc2b88x367657c64278e6ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 09 18:59:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOwyH-0002cg-Ny
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 18:59:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751878AbZGIQ7d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 12:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751875AbZGIQ7d
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 12:59:33 -0400
Received: from ey-out-1920.google.com ([74.125.78.149]:10151 "EHLO
	ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751628AbZGIQ7c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2009 12:59:32 -0400
Received: by ey-out-1920.google.com with SMTP id 3so69692eyh.36
        for <git@vger.kernel.org>; Thu, 09 Jul 2009 09:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=L0hEC3XMbBWT9goM+H51agPfNc0h2jh/q5XLnDUhGJE=;
        b=PLtDk5vfZU39VkZBwlH+yuvgmcR1f+5Ra2+gyCJohA/WMmM4I75SPNyGKDHeh+43n9
         HcLwORtGJ7wUQZ6chJ4GHJNTpuNLLuV+IZgTojw3rcTd9mI4p0wivJp9HZmDzil0pGDz
         h531CSziRj+d0ImT4VCXqBhq8TeVL+UYiw/08=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=qtrxKScCzqGeq0N4D2ZAWN5Yw6GwCcuj9LuUJbIHuZ/DyrrkGl76Y3ZiRXvZ3Pg/6c
         NK9gbAG4ibaAAOFRDROrcNzOa31uEq3OVTaRGrROjt5ehEDniEWGzsIuLkQW5h1kGC2F
         d6xuz9yTFH+91wlnSlSCuR2WsDQFcQSG8iclM=
Received: by 10.216.53.12 with SMTP id f12mr283883wec.72.1247158770677; Thu, 
	09 Jul 2009 09:59:30 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122992>

Hi
I recently wrote a Bzr to Git migration tool and thought I'd share it
with anyone who might be interested.
It's written in shell-script and iterates through the Bzr commits
while adding those changes to a new Git repository.
Usage is to run it from within a Bzr repository. BzrToGit can be found
at http://sortedbits.ath.cx/scripts/bzrtogit.sh

Henrik Nilsson
