From: ib@wupperonline.de (Ingo Brueckl)
Subject: question concerning branches
Date: Wed, 19 Aug 2009 20:31:00 +0200
Message-ID: <4a8c4425@wupperonline.de>
References: <32541b130908191107v2ab6752awb43f521f805b5f1a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 19 20:50:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdqF6-0000DG-GB
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 20:50:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753073AbZHSSu1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 14:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753001AbZHSSuY
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 14:50:24 -0400
Received: from smtp.tal.de ([81.92.1.5]:59764 "EHLO smtp.tal.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753008AbZHSSuU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 14:50:20 -0400
Received: from ib (muedsl-82-207-218-062.citykom.de [82.207.218.62])
	by smtp.tal.de (Postfix) with SMTP id 4EC4EAC18DD;
	Wed, 19 Aug 2009 20:50:20 +0200 (CEST)
X-Mailer: blueMail 1.4 (SlipDoor 2.2)
In-Reply-To: <32541b130908191107v2ab6752awb43f521f805b5f1a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126572>

Avery Pennarun <apenwarr@gmail.com> writes:

> You seem to have forgotten the "git commit" step before switching back
> to master.

No, I passed over the commit in my example. I know that after the commit the
things are as they ought to be, but what if I can't do a commit because I am
in the middle of coding and have to have a break?

> You have a modified file in your repository; what did you *want* to happen
> when you switched branches?

I want an unchanged file in master if I switch there (because I worked in a
different branch) and a changed version in the test branch.

Why is the *master* different depending on whether my work in test in still
going on or committed?!

Actually, I cannot image how branches are practicable if I always have to
have in mind possibly still uncommitted work. Shouldn't it be git's work
to ensure that master will remain it was when branching?

Without git I'd make a copy for testing new features. With git, it seems that
I have to do the same (a clone). This is what I don't understand.

> (Many people find the current behaviour very convenient.)

I find it highly confusing. I understood a branch as something I can do in
whatever I want without affecting master. But now a learn that everything I
do in the branch will happen in master, too, until I commit. Strange. Very
strange.

> You might also want to look at the "git stash" command.

Yes, but isn't it annoying to leave the test branch always either with stash
or commit in order to have an unchanged master?!

Ingo
