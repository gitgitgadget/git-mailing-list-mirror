From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: [bug] gitk: wide patches and commit messages break display
Date: Mon, 16 Apr 2007 11:40:39 +1200
Message-ID: <46a038f90704151640s773c8989x9aa0990099b06d80@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 16 01:40:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdEL1-0006jg-NL
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 01:40:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754088AbXDOXkl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 19:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754090AbXDOXkk
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 19:40:40 -0400
Received: from wx-out-0506.google.com ([66.249.82.229]:3376 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754088AbXDOXkk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 19:40:40 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1425798wxd
        for <git@vger.kernel.org>; Sun, 15 Apr 2007 16:40:39 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=n7sxKYB96wNGzFJ9yY7Fmseq4kJ9vHSnH6NSqrJsPxZ6SN0AKy1Cc3bcQLIQVcN6Scpd2QzdXcO1qP1wcJ0WVy0kJscb790Z1RhemtyM1tCsPKrIy43vEzs9L9KbdzhAs9AdBNYpXD6r68fOyMMxWbxRHKi8fC1ba1zIDSUoJ68=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=fy6p3Zy5BHJqJnojyTnZVv7JRogGZ8HMJEzqpf2XqzZ/PZXKqrcOWYD5Bxv8mNIwvKDU/YtmuHxZvVLe1NVz5Cp23waUeV0/Ig0qahVN4kkZ+E07fx7L/vrssFnGun+3uX1KvEyml9UF3Y37jB1ipV0MBEIzOj1qeMmY2zvKh5Y=
Received: by 10.90.105.20 with SMTP id d20mr4466062agc.1176680439539;
        Sun, 15 Apr 2007 16:40:39 -0700 (PDT)
Received: by 10.90.52.17 with HTTP; Sun, 15 Apr 2007 16:40:39 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44549>

I am having 2 different problems with gitk and "wide" patches

 - the commit list appears garbled if the first line of the commit
message is wider than the display window, as it gets wrapped and
doesn't quite fit in the 1-line-height allowed by the commit listing

 - the patch view never gets horiz scroll bars, even if the width of
the commit message and/or patch itself is wider than the canvas

If I find some time to wade through tk source and understand it, I'll
try to post a patch for the first one. I suspect the second one is a
bit harder. In any case, someone with a more adept hand at tk might
find it easier ;-)


martin
