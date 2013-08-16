From: =?UTF-8?B?U2HFoWEgVG9tacSH?= <tomic80@gmail.com>
Subject: git undo # last command
Date: Fri, 16 Aug 2013 10:55:06 +0200
Message-ID: <CAAUyY9ADW2iHVWhTGcTF8j0hrdumpBcLv_mLo0y8VDAyBpftJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 16 10:55:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VAFoo-00008B-Qn
	for gcvg-git-2@plane.gmane.org; Fri, 16 Aug 2013 10:55:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754915Ab3HPIza convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Aug 2013 04:55:30 -0400
Received: from mail-qc0-f180.google.com ([209.85.216.180]:55789 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754042Ab3HPIz1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Aug 2013 04:55:27 -0400
Received: by mail-qc0-f180.google.com with SMTP id j10so951278qcx.39
        for <git@vger.kernel.org>; Fri, 16 Aug 2013 01:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=udMzgaPRz9GAFUbvcu+NlkxUr9zLr1Dsu+e/C0AGURk=;
        b=qBG900ktebKvJEL3zBrnX0FVi+RWDn08wMIr36DByn2IPnv1RWEIm9/bJNeRq5K0SF
         mUUrvhf7wmgCqcvbrnl+ohfRaz6uY9uvFsrYcjB/JN9NBBQfa8liyK1uJd7t1rUgLkcm
         DQU8Gbpee2HAjKDLJVmtjanyoQGc4Jbxtgy3FgT7f4Xm4Qe+8ANQf3vnY86oukyXdEak
         qT4tNZ2m/aJQg5dv5bpQgXM1ambpV48/2yDIgpUy7h+ynuE7/onMYyBjuUn4GrTsgHHe
         5QGO+D6L9dNuWT6PxKmtuf0Nb/VB0uWwV91/LxoDIC3tdFUK5AX6i9MyvybisumJ9tR8
         a0SA==
X-Received: by 10.49.47.50 with SMTP id a18mr446592qen.61.1376643326675; Fri,
 16 Aug 2013 01:55:26 -0700 (PDT)
Received: by 10.49.29.134 with HTTP; Fri, 16 Aug 2013 01:55:06 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232403>

Hi to all,

I've been using git for some time now, but I'm in no way a git expert.
I typically hack my way through the variety of commands that git
provides. I believe that most git users work similarly.

it just occurred to me -- the command that I would REALLY like to have
is simple:

  git undo

which 'undo'es the last action that has not been pushed yet --
whichever the action is. Similarly to the 'back' button in the
browser.

Currently, when I make a mistake, I have to search the net to find the
*right* command that will undo my last action/command. That's boring
and time consuming. git undo would make things much easier, I believe.

Would creating such command be possible? I guess that 'behind the
scenes', the command could analyze the reflog and act based on that.


What do you think?

--=20
Best regards,
Sa=C5=A1a
