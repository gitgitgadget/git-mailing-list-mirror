From: robert mena <robert.mena@gmail.com>
Subject: Branching strategies
Date: Fri, 9 Sep 2011 19:01:11 -0400
Message-ID: <CAAZ43xaFzJWzPsqhP0QDRTP0Ea-dMpCpr1vDiujFFn94j+SRCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 10 01:02:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R2A5r-0001Sf-MY
	for gcvg-git-2@lo.gmane.org; Sat, 10 Sep 2011 01:02:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934023Ab1IIXC3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 19:02:29 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42778 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933979Ab1IIXBM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 19:01:12 -0400
Received: by fxd22 with SMTP id 22so1097784fxd.19
        for <git@vger.kernel.org>; Fri, 09 Sep 2011 16:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=4AlUNvlcQJrxfGOFu1ypwRu1W8J6POyxrenaEAaODL0=;
        b=ZQj+Kxzco94veTyPqXRLfSJ5zZeVx3ZYW9nkejfvBl96CLNVmKDpgSvjsCTFBjjFjs
         vU/hvyUbaLx45WSZg3KDugW6QoZADM/L9YdKtqOawl9XthXT3RHbuGkQmrX3dKkY2dYj
         G3+eKO0EPyx+V4QNOEii5QXpbbgwJBBOL7/zE=
Received: by 10.223.39.10 with SMTP id d10mr318281fae.136.1315609271128; Fri,
 09 Sep 2011 16:01:11 -0700 (PDT)
Received: by 10.223.105.147 with HTTP; Fri, 9 Sep 2011 16:01:11 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181129>

Hi,

I have a project where I have to do a continuous integration, adding
features/making changes on a daily basis.  Some changes are one liners
with no functionality just, for example, textual changes or a new
button.   Some are actual features or bug fixes.

So today my developers do their business and publish the changes in a
beta site where the customer or the qa takes a look.  The problem is
a standard one.  Sometimes features stay already developed (waiting
for review) for a long time and other changes/features get approved
first.

Since some of those can touch the same files how can I make this a
little bit better (manageable)?

I am considering doing feature branches.   The customer requests to
add feature A I open a bug tracking issue and create a branch 1276
corresponding to the bug id.

In my simply view I'd have a master/live branch and every time I need
to create a new branch I do it from here.  When the developer is happy
he merges his branch with a beta branch where the Q&A/customer review
is done.

When this review gets an OK he merges his feature branch with the live
one, redo the tests and publish.

I'd really appreciate feedback for this specially for the weak points
and known problems of my approach with alternatives :)

Regards.
