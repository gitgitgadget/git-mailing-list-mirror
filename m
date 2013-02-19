From: Russell Myers <mezner@russellmyers.com>
Subject: git-p4: Importing a Git repository into Perforce without rebasing
Date: Mon, 18 Feb 2013 21:40:45 -0500
Message-ID: <CAA5tD2sZiYcH+edbuO2Uh43zNUOyDYUO_JHpRhrLOjSqV-PfpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 19 03:41:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7d8p-0002tn-HZ
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 03:41:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757515Ab3BSCkr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 21:40:47 -0500
Received: from mail-bk0-f41.google.com ([209.85.214.41]:39787 "EHLO
	mail-bk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757331Ab3BSCkq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 21:40:46 -0500
Received: by mail-bk0-f41.google.com with SMTP id q16so2878419bkw.0
        for <git@vger.kernel.org>; Mon, 18 Feb 2013 18:40:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:x-originating-ip:date:message-id:subject
         :from:to:content-type:x-gm-message-state;
        bh=leE7zqs69U48lKSFLfd77mt9RV4fJhzh5pMaB/afD0k=;
        b=LeT65Gdzzm6PQ/kTM7r3P8YCK4iduD03fHXjCqzAEUgJoHX8/INFHM8v/8SMyQNuJm
         7/ygOuL38rz/b4dKjcqdNMZpSypvbuy221pkrLpqv43q82vCE8x1LWEQisOx3kXhQ95A
         NbAOWejKHsJj2QFkdAAFZsScnlVHIuz0NYxkulwnevUc1+w3dOz/7inYVUYcX+BLRCaP
         m+izeiD+y0dVuRFiy+25nrQlnP1ktDWZy4M/WscE269yjesmpNabfqX+TOLlCAtS0Kr0
         MaPVZDFamNNzLlGmT/31so2HEtVekIRE2iCmVpk+FUftYFwSgNB4tapOtFOcJeD1C8fn
         pUjw==
X-Received: by 10.204.146.22 with SMTP id f22mr5523213bkv.120.1361241645293;
 Mon, 18 Feb 2013 18:40:45 -0800 (PST)
Received: by 10.204.233.67 with HTTP; Mon, 18 Feb 2013 18:40:45 -0800 (PST)
X-Originating-IP: [99.99.46.163]
X-Gm-Message-State: ALoCoQnWyOSUQk+9yMrN7HHi7Bn5hlH3UQqWYxj2Dp8R3o4G2lR2AUmDAj12HplSTrgYNQV07gRc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216554>

Hello,

I'm trying to take a Git repository which has never been in Perforce
and push it to Perforce and having difficulty.

It would appear that git-p4 requires that a repository is cloned using
"git p4 clone" in order to use it to push back to Perforce. That would
not be the case here as the repository in question has never been
tracked by Perforce.

I know that I could create another Git repository that has some
commits in it cloned from Perforce and rebase on top of that; however,
the repository I'm trying to import is rather large and rebasing would
require me to change many merge commits. I'd like to avoid doing this.
The repository has many thousands of commits in it.

In short my question is this: Using git-p4, is there a way to push a
Git repository into Perforce without rebasing on top of commits coming
from Perforce?

Thanks,

Russell Myers
