From: Anish Tondwalkar <tondwalkar@virginia.edu>
Subject: Moved code detection with `git apply` a la `git blame -C -C`
Date: Tue, 18 Aug 2015 16:11:09 -0400
Message-ID: <CALZPV0Dgmu5fJqQEXwxVvn9Na6jUtvkDbAwY9mAZKeFSMqo8xQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 18 22:11:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRnE3-0003qO-Rx
	for gcvg-git-2@plane.gmane.org; Tue, 18 Aug 2015 22:11:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751739AbbHRULL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2015 16:11:11 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:34244 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751050AbbHRULJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2015 16:11:09 -0400
Received: by pdbfa8 with SMTP id fa8so71654354pdb.1
        for <git@vger.kernel.org>; Tue, 18 Aug 2015 13:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=HaIGId1wrofRHrZlYqKDIvd03HEqW1BcCyPqnteX/Gs=;
        b=0qCh0gscrD7SikWmgbd4jqRBPNJtBS7uuBuBb64dIs1SbHuA+fHMhm8S6CxKn8hQTi
         48SSE7P83paNkZ/5YnRhN4XU7giVczLiK3hsnUEGI2lTtgeQ13bX9yQmEtUxiRyz4RZt
         nmw/6OqizfS+F9a2Wr06WbBLYR5XQih5sRYAjEFu6GcmM67YvpnTRYpZFf2eX4oB9SvE
         TyncDP4RZP2wVdjuv5y/1x5fT/y0gR58XijjtATZDVW8sYW7e8pMev+KV2/d8Ns7m1H5
         DESLtUXEVdxnTsN9Q0C/keaPuLkTQoVZ5dcySxARTcwHkc0CRiuTFFealm8O6h9Zibmo
         EysA==
X-Received: by 10.70.94.194 with SMTP id de2mr16946243pdb.8.1439928669335;
 Tue, 18 Aug 2015 13:11:09 -0700 (PDT)
Received: by 10.67.7.134 with HTTP; Tue, 18 Aug 2015 13:11:09 -0700 (PDT)
X-Google-Sender-Auth: GDs9JPcut8fgcE6h4wDvLPPSa2g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276159>

I stashed some changes, then refactored my code to move the function
they're in into a new file. Now, I want to apply it to the new file. I
know git can figure out this relationship between the files, because
`git blame -C -C` can find it, but is there a "more idiomatic" way to
apply this diff than to have git spit out a diff, and edit it
manually?

-- 
Anish
