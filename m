From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: git config error message
Date: Mon, 12 Nov 2007 10:35:07 -0500
Message-ID: <9e4733910711120735p653c643eveb44627bf4532b1a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 12 16:36:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrbKH-0007GC-O9
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 16:35:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbXKLPfL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 10:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757402AbXKLPfK
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 10:35:10 -0500
Received: from nz-out-0506.google.com ([64.233.162.228]:37913 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751250AbXKLPfJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 10:35:09 -0500
Received: by nz-out-0506.google.com with SMTP id s18so981085nze
        for <git@vger.kernel.org>; Mon, 12 Nov 2007 07:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=WYrqRfRD/AiJGYYAeppGglRIUovTnTTeoHViGeUIM5A=;
        b=ss7kkUPX1oFucmRo35llUl9zBmteoDRhNUlivDKSQ8tsYGk2VLbTy4o4VVYRYA3tjv8gIM06zryahZtoyt3sGO/rif0MKlppzqNp4rZet9ZE9KqSxIkYxsI7RyijnyrHWVSzJlyzSVcIW1aqaL7EVUS/qU7fj+sH9OUVtJSifWc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=OasBY7+DqhJXLXXQTyzb7z9LcN6u9ZyO2VY5QVfhJKqoKQMDPrWVZc0wISmtkB1fg+EGe/lA8xOkfqUo38u72VRQMj3Pl4F4V/k1Ga2JwvzvJZw3zaf7/PO2Wv9X0gfzk6VOoHyz7OYs5AzZgR6bRTjmiqhWSdOy+X5Ou/tfccE=
Received: by 10.114.12.9 with SMTP id 9mr598540wal.1194881707680;
        Mon, 12 Nov 2007 07:35:07 -0800 (PST)
Received: by 10.115.54.19 with HTTP; Mon, 12 Nov 2007 07:35:07 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64637>

I'm not in a git repo, this error message is misleading.

jonsmirl@terra:~/foo$ git config remote.origin.url
http://git.digispeaker.com/projects/digispeaker-kernel.git
could not lock config file


-- 
Jon Smirl
jonsmirl@gmail.com
