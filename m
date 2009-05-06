From: Geoff Russell <geoffrey.russell@gmail.com>
Subject: Tracking the untracked
Date: Wed, 6 May 2009 10:49:34 +0930
Message-ID: <93c3eada0905051819l92dc7ey331d69f009cc9c8b@mail.gmail.com>
Reply-To: geoffrey.russell@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 06 03:19:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1Vnc-0005vp-F1
	for gcvg-git-2@gmane.org; Wed, 06 May 2009 03:19:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754051AbZEFBTg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2009 21:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753808AbZEFBTf
	(ORCPT <rfc822;git-outgoing>); Tue, 5 May 2009 21:19:35 -0400
Received: from mail-qy0-f133.google.com ([209.85.221.133]:43935 "EHLO
	mail-qy0-f133.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753795AbZEFBTf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2009 21:19:35 -0400
Received: by qyk39 with SMTP id 39so2008866qyk.33
        for <git@vger.kernel.org>; Tue, 05 May 2009 18:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:date:message-id
         :subject:from:to:content-type:content-transfer-encoding;
        bh=CRvF5aurtaC5tcF+9sx+lCu6TOaz2DaoHjcfSycXyiI=;
        b=GnEzn2+9KrrQpk7rMTtVzEGZ8ZREKRBRw7eVDUNvbHIWY3l4gt5UeTdmvpTseEqGOM
         N3Ed8jehud+Z88ZmPmm1DU5rXYzKWjLyrzxl1tUQkL0gDBlGvrERoN//5LvMe5YFOrjR
         k7kQv738pan958Ud0rgaU2hf2RUMYV1lBFvKQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=FpEQzkgYZihyb8XymMf5+fAyaqgahtrYypLbv81xqYy5j54mi2lP7gtBBW7OJpeXCE
         WJBs/M0iVotVwDW2FRYX/EBfGFbYBp9wG5lS1OexfNgGGbQfvIv0x7HQnb395tVnXQkO
         ng3y9T5G9WHt8eqxDUrqYLWQLaPRgBUqLvFvA=
Received: by 10.220.92.79 with SMTP id q15mr1569386vcm.11.1241572774335; Tue, 
	05 May 2009 18:19:34 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118322>

Bug or feature? I don't know.

On the master branch I have some untracked files e.g., object modules,
executables.

I create a branch B1 and add+commit the untracked files.

When I switch back to the master (git checkout master), the untracked
files are no longer where I left them.

Basically, I'm trying to find a way of having a huge bunch of stuff in
my repository and
tracked, but which doesn't get pushed to the central program repository .. which
has always just been source for us .. I figured I could stick it on a
branch which doesn't get pushed.
But that doesn't work for the reason mentioned.

One solution would be to have a class of files that is "unversioned
but tracked".

Alternatively we could just bite the bullet and track everything.

Any ideas?

Cheers,
Geoff Russell
