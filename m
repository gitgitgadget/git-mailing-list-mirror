From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Using thunderbird to post/apply patches?
Date: Fri, 8 Feb 2008 12:21:24 +1300
Message-ID: <46a038f90802071521n674b61c2t5e4d4c740375b951@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 08 00:22:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNG49-0007zV-Sg
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 00:22:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758269AbYBGXV1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 18:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757001AbYBGXV0
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 18:21:26 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:46386 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755877AbYBGXVZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 18:21:25 -0500
Received: by ug-out-1314.google.com with SMTP id z38so794282ugc.16
        for <git@vger.kernel.org>; Thu, 07 Feb 2008 15:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=T2OO20bqKwQU51gb8NziD4udAFovFaSCBl1tMIIOJ+0=;
        b=XMB7s1i5AqJmpHQt7K6HXj/AW193ojQ2D3OCipCmYC+xFdnFJI+D0YFN0AQGtLnsnTMc5tpU+i29I9I8Uk/BHd743zf4QRx1o7CqsyqtBo4C2qcCbTTeURwDA/hsczhk6u6J0UEL6j0v9ZK6PZzpWKl5xHYywLRmu46CZ6Twq48=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=NBpaWHY0xb6naIyW4DphMnHAgSJ/z5DoXCvWytpPoP5D0SU4Obe/y+jc6IKdGLESYpZyaeOvN2+08x34uaZF90wDgREiUbLGJEzNZrpUU6YqzFYcHKI9wBAW9tP7+f2rTTOXbQ3L1GnvYurParH9Hrl40xdOM8JtQn8Gcs2heMY=
Received: by 10.67.115.13 with SMTP id s13mr4654970ugm.41.1202426484071;
        Thu, 07 Feb 2008 15:21:24 -0800 (PST)
Received: by 10.66.250.13 with HTTP; Thu, 7 Feb 2008 15:21:24 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73016>

Is there anyone using thunderbird/mozilla to post patches with
additional email commentary like Junio and Linus do? Are there good
tricks for this? Or otherwise a similar MUA that does things right?

The 2 workflows I am after are...

 - Load up a patch created with git-format-patch into my email editor
to add some commentary before sending. Should not munge the patch
itself!

 - Feed an email I am reading to git-apply-mbox so that if it's
reasonably formatted as a patch it will do the right thing and apply
it.

cheers,



m
