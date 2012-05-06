From: jaseem abid <jaseemabid@gmail.com>
Subject: Arguments to git hooks
Date: Mon, 7 May 2012 00:05:51 +0530
Message-ID: <CAH-tXsB4PBS_YjW4DCjT6ORmNPomQ8XMPbKx3hxVNH=FyB2u3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 06 20:36:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SR6Jx-0004ie-Vu
	for gcvg-git-2@plane.gmane.org; Sun, 06 May 2012 20:36:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754103Ab2EFSgd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 May 2012 14:36:33 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:54601 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754094Ab2EFSgd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2012 14:36:33 -0400
Received: by wibhj6 with SMTP id hj6so2811338wib.1
        for <git@vger.kernel.org>; Sun, 06 May 2012 11:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=ER2LQWAmPBniH/WFwlBgGLtjnvfJHq3GVMMW7yBIEk4=;
        b=k3kagt5T9SxQkDoTx+nsr3keCA4OumWZc6WjAThyay3GCQniDW+IpxuSgNjIQnU+Ds
         ISayylFsbmgQUNtPfFdefxTwOMOCFhzjM62FOxI8qHgMyqXMe0YVXoCRICIeS9eHTlp5
         p5uJQN4yus6itwwPkt0jyXmnoUINOKUwKUoCiFvR9o5OQquR6B5vycsqm6kx+Cz5HR2C
         W0APgMTn5WF38P9NWK8Kz2TrUWQYCU3x3UA5IgDdYJSgVIOoxTCMYKET+7qKE2NMUxca
         gczNfFoObCeVtW50y6RAPo5NFn9G0vrgb5CaIXDshUHddb44nLhH3EXi8TD6TjLTD47V
         Jzzw==
Received: by 10.180.104.231 with SMTP id gh7mr28889439wib.10.1336329392024;
 Sun, 06 May 2012 11:36:32 -0700 (PDT)
Received: by 10.227.39.96 with HTTP; Sun, 6 May 2012 11:35:51 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197205>

Hello all,

I am trying to write a hook '.git/hooks/commit-msg' to be run before
every commit.

How can I pass arguments to the script? Now by default the only arg I
am getting is `.git/COMMIT_EDITMSG'`. I would love to get the list of
files I tried to commit also into the script so that I can run a lint
program on it before committing it. How can I get this done?

V/r,

--
Jaseem Abid
http://jaseemabid.github.com
