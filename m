From: Ping Yin <pkufranky@gmail.com>
Subject: How to create a new commit with the content of some commit?
Date: Tue, 12 May 2009 22:35:30 +0800
Message-ID: <46dff0320905120735l501dcaf4ia8197d24b7684cfe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 12 16:41:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3tAY-0008Sc-Ad
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 16:41:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751889AbZELOlN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 10:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752007AbZELOlN
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 10:41:13 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:57429 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750943AbZELOlM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 10:41:12 -0400
Received: by yw-out-2324.google.com with SMTP id 5so8759ywb.1
        for <git@vger.kernel.org>; Tue, 12 May 2009 07:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=yjMMbdT6PqJDpQ6DWRiruCPM4B08c6gl9Vj2RDe8/pw=;
        b=g37Vn5b5BO/LXRWaRqYq7V+c0iawKBebCipLIAuMvKGwB7djQspbmSByhxHsNTm101
         6BAhDjr9I7+wp8GLe8so0TwxRw4+ng/FXhUTu1WO1ALYuFhXwNiW4LSxNpwctOQ9NhHA
         q2U85jJYWTrdFGtKi7aVSN/53u2n6inOKuAOY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=O9/tXADBoywzb+3QgpTz8YxnCBAsKLdV0k9qEAQDTFnH0u+X6G+97Qj7P9kcDzDwCY
         IJfPBeGhKH0lbRppF6gbX+ZPk8CoHc1RV5NZP6cEfMmtdBB0R7dYeQIkn3uZKiwcEY+6
         SR99Az2Eh5PLVylDfcOU35A8r46Drd+u4F08o=
Received: by 10.90.100.11 with SMTP id x11mr3914146agb.72.1242138931324; Tue, 
	12 May 2009 07:35:31 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118898>

a----b
 \----c

Given the graph above, I want to create a commit b1 on top of c, where
b1 and b have the same content. i.e.

a----b
 \----c----b1    ( content(b) == content(b1) )

If there are no untracked files in the working directory, i can do

git checkout b
git reset c
git add .
git commit -m "the copy of b"

Is there any simpler way? And if there are untracked files in the
working directory, how to do it?



Ping Yin
