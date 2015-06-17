From: Tuncer Ayaz <tuncer.ayaz@gmail.com>
Subject: co-authoring commits
Date: Wed, 17 Jun 2015 21:52:14 +0200
Message-ID: <CAOvwQ4i_HL7XGnxZrVu3oSnsbnTyxbg8Vh6vzi4c1isSrrexYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 17 21:53:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5JOO-0004d1-SD
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 21:53:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755938AbbFQTw4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 15:52:56 -0400
Received: from mail-oi0-f51.google.com ([209.85.218.51]:35855 "EHLO
	mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754511AbbFQTwz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 15:52:55 -0400
Received: by oigb199 with SMTP id b199so740973oig.3
        for <git@vger.kernel.org>; Wed, 17 Jun 2015 12:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=qbvY5TIeuJ+BCqRf1vHrBz5JwA4KZOrj2H+xRMCmgXA=;
        b=bnEMEpNDyn4wGENLrlYefI3l2HIEom9fBRa1+cIoZhEysKr6xCBqh8rCUh1ChIpWdp
         8/p1++pLE27lYluhy441fiYOH/mLFU6iHHB2XshTbPpiW9p2LmX6cy2DEy9PBumeYYUo
         JV5de7yRUEXeTpakRnjxlywphOPkXyRL6bbKQIbRIvJDHEv8UojLLSwYaqFMx+ElDA2b
         OPF6r7VuIu4J+cidOIozlNLBgSHMLy7ahhn6QKdQwCM9YEvAdLzgGaX7VtpTBYeldMXv
         AXACUQGtyW0LvxpWUBqD5WoTWah3PWqRXU2iqV0E+4k0eb8qjxof38EYY4DJM/HdLQ80
         GxDw==
X-Received: by 10.182.153.197 with SMTP id vi5mr6050360obb.28.1434570774485;
 Wed, 17 Jun 2015 12:52:54 -0700 (PDT)
Received: by 10.76.158.202 with HTTP; Wed, 17 Jun 2015 12:52:14 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271898>

Even though I don't have time to work on a feature like this, like
others before me, I've been in situations where I would have liked to
set more than one GIT_AUTHOR_NAME (etc.) for a single commit due to
the involvement of multiple developers in authoring a change.

Is this something that breaks the design and would never be implemented,
or can it be integrated such that one can specify co-authors when
committing a change?

I'm thinking:

$ git commit --add-author "Tony Zwei <elsegundo@example.com>"
