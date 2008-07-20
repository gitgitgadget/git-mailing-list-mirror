From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: git blame --porcelain
Date: Sun, 20 Jul 2008 22:28:01 +0200
Message-ID: <bd6139dc0807201328i41aa7d09jf9a1c4dc6f60a367@mail.gmail.com>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailinglist" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 20 22:29:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKfWm-0006tr-HB
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 22:29:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752040AbYGTU2I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 16:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752028AbYGTU2G
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 16:28:06 -0400
Received: from rv-out-0506.google.com ([209.85.198.238]:30192 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752022AbYGTU2E (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 16:28:04 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1082103rvb.1
        for <git@vger.kernel.org>; Sun, 20 Jul 2008 13:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=ZiUx1PbhfdW9iRWOc0U0lHpFfKZfHQWw/mvE0qDlgL0=;
        b=sWC43vHLa3xIeTwZLHIiLY008JXfJhgHMuBw47aoICDdnpl1+5/zLxGsoUnYBgu0MK
         ZxgnyQg0IhLpeqOjg/x2WUWTjtRgW4hiddOdt34WGrz9bYFATIJOXQOrRnh9F1xVrKYh
         a8dhPdJJHPREEAr/aE4EepkcLqOAG36gpfQgk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=T+mACrcF0Y+UqqUeNjjdo6AMzbng3kzVIIoZRdoVcPuzS/oUpvm8uunL6vQrqnxKNM
         s1c2JlBJ0no+BhZrgrdscA7QRe+SKLjFG5h8LR1Dtf40wpBFjmk6IQ4oxkOyoq7CXSwP
         0eLZX6jtHY24QcO/i3BZAFC6dJjqakp9RyEOk=
Received: by 10.142.132.2 with SMTP id f2mr1007115wfd.256.1216585681985;
        Sun, 20 Jul 2008 13:28:01 -0700 (PDT)
Received: by 10.143.38.17 with HTTP; Sun, 20 Jul 2008 13:28:01 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89224>

Heya,

Contrary to what one would expect, the '--porcelain' switch to 'git
blame' makes the output suitable for... plumbing use? As far as 'git
blame builtin-blame.c' tells me (gotta love the recursion there) it
has been this way since cee7f245 when the option was introduced. What
is the rationale behind this? Is it called '--porcelain' because it is
meant to be used by the plumbing to create new porcelain? That seems a
bit far-fetched though...

-- 
Cheers,

Sverre Rabbelier
