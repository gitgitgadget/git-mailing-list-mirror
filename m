From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: git-scm.org bug: Broken link in git-push documentation
Date: Sun, 24 Apr 2016 21:28:58 +0200
Message-ID: <CACBZZX6aMXzs04DuEiQNtH1Y27s4V4=-7u8HwtuZ=PoADTFOtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Scott Chacon <schacon@gmail.com>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 24 21:29:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auPil-0002NX-FJ
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 21:29:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753319AbcDXT30 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 15:29:26 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:33477 "EHLO
	mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753200AbcDXT3X (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 15:29:23 -0400
Received: by mail-qk0-f177.google.com with SMTP id n63so55402894qkf.0
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 12:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=gLb+4sACQw8T0x3JOoxFfb5lwhme0j1xc8xozj38j04=;
        b=v+dNo52AU+pabEJK1s0cP+jrLiBzEbOEXQzSN3O/NHtoXF1auay5d0LqzUqZodQ3O+
         g4H/knXVfDHqn42wwGKy/ak94ghPfcQzZBRUngvFq1tZbgWczFzyP+gUXrIYuX6n/QVk
         E4HGE/92+wSQ7IN6KKEumZQErle5p1CQXu/CiPtHmGAwX/GuvVKmOh+prVNCFlUPekIB
         tAtQH9IzdwwQv5fSzr7WU6YrPlBsVka5Wyl6FZrcMGJq4Ly0ltfMdwWmiG2CrLG5sBB8
         LW1wnNADvNFyWOnaVQ2WSPS2ScrJBf64FXlr74yLUEcgJnAxNL2H+RR4ejONOUf2DySP
         6xsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=gLb+4sACQw8T0x3JOoxFfb5lwhme0j1xc8xozj38j04=;
        b=dtLb63giQODaZh4M91TPPr+NVOtPCtfdVE3rOZ1mC0e6IV+ZvDP8KzURLzS/HMoQxn
         KBMqd58taG2zSkyU9uJp4NmU2gif8TRyQ9w1Jl8wyZxMC6oSpKdvwb8/I0jyGpc8PqT6
         W8KJevAeUN/DYAayMN6uKQcDIyesZPizrLY6/pOFxLFc2y8KY5B+tWHZzgPsjaY0VpbL
         PLbu7d5f/IUs4OaglQzFM2dMXlREDKEDLFFhfU2dVdJo5MjDj4O221dNqSG61zYHvvea
         odhemKyyRX26M4Ooa/QBEc1G8B/GAl8RJgOgLk5rx/VTtNoiiERVmiABRZUBbeJhc9FT
         G5ZQ==
X-Gm-Message-State: AOPr4FVYTWJrhxnkoHz3cuKjT0HeTrOcUJoq33Fxa8oC2w+DeNg8u+xiimGl+0qUvnysO3KHiBdo/kZBngD+mg==
X-Received: by 10.55.145.6 with SMTP id t6mr14272685qkd.206.1461526157507;
 Sun, 24 Apr 2016 12:29:17 -0700 (PDT)
Received: by 10.55.77.133 with HTTP; Sun, 24 Apr 2016 12:28:58 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292433>

I couldn't find a way to report git-scm.org-specific bugs, but I guess
whoever maintains it these days also reads the list.

Here:

https://git-scm.com/docs/git-push#OPTIONS

If you click on the "GIT URLS" link it's broken. If you search for
"urls.txt" in the document you can see that this is because whatever
git-scm.org is using for its HTML generation apparently doesn't
understand recursively includes, git-push includes urls-remote.txt,
which in turn includes urls.txt, only the first level of includes is
processed.

The git.git "install-html" version of the documentation doesn't have this issue.
