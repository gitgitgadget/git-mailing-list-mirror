From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Wrap commit messages on `git commit -m`
Date: Thu, 1 Nov 2012 21:37:00 +0530
Message-ID: <CALkWK0kQ+qCsOa87yY4wma279mp+9h+LFv3qCP_qrNdDyGNcsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 01 17:07:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTxIt-0000VL-I5
	for gcvg-git-2@plane.gmane.org; Thu, 01 Nov 2012 17:07:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761973Ab2KAQHY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2012 12:07:24 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:64476 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755404Ab2KAQHW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2012 12:07:22 -0400
Received: by mail-wi0-f178.google.com with SMTP id hr7so515521wib.1
        for <git@vger.kernel.org>; Thu, 01 Nov 2012 09:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=EYIoAIDPEec2E4Fr4M6t58O6B+zc0oMJ4HDOIM+/HWU=;
        b=WzEKqCF4LEj3IxmPkkiaCvLfSlCYx5LkLWsf5yDY3IYPAB19dR5TbyJb4OoYYTiUBp
         OuUNbltencSlujzCRfo+uK9gmJbWzRdSq0kM8HB67VysjBsmfGnTHNxYLRSuujOyio0d
         87eOlcqkYzNZ28mPvLBH0PtN+q6hRqK5m2AJuB+MHgpEkpO6ltrGALI2xC2AQVStcgHe
         RxduEOctYMwSqjITqsmCNK9hmeqpxPqGm7fzCENhqr47ObFZ3WephNVIPTgxLId+yyPS
         +yFPRQdY8VZeQJBj0IZH/R7dQWw0s/Xhta0teVqtHj2fppL3UtQbxD6+rhf3zUPM/D7a
         064Q==
Received: by 10.216.140.33 with SMTP id d33mr19933586wej.68.1351786041002;
 Thu, 01 Nov 2012 09:07:21 -0700 (PDT)
Received: by 10.217.69.201 with HTTP; Thu, 1 Nov 2012 09:07:00 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208881>

Hi,

Some of my colleagues are lazy to fire up an editor and write proper
commit messages- they often write one-liners using `git commit -m`.
However, that line turns out to be longer than 72 characters, and the
resulting `git log` output is ugly.  So, I was wondering if it would
be a good idea to wrap these one-liners to 72 characters
automatically.

Thanks.

Ram
