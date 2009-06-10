From: Mark Lodato <lodatom@gmail.com>
Subject: Re: EasyGit Integration
Date: Tue, 9 Jun 2009 20:40:17 -0400
Message-ID: <ca433830906091740m76f74951j170608c9d9757272@mail.gmail.com>
References: <d411cc4a0906091159r51e7d16t4d66c6225322fb60@mail.gmail.com>
	 <alpine.LFD.2.01.0906091512350.6847@localhost.localdomain>
	 <51419b2c0906091530t3dfa5267s2262f979f1e9982a@mail.gmail.com>
	 <alpine.LFD.2.01.0906091535410.6847@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Elijah Newren <newren@gmail.com>, Scott Chacon <schacon@gmail.com>,
	git list <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jun 10 02:40:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEBrh-0003Z6-27
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 02:40:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753453AbZFJAkT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2009 20:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753156AbZFJAkS
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 20:40:18 -0400
Received: from mail-fx0-f213.google.com ([209.85.220.213]:49742 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753035AbZFJAkR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2009 20:40:17 -0400
Received: by fxm9 with SMTP id 9so409701fxm.37
        for <git@vger.kernel.org>; Tue, 09 Jun 2009 17:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=C3o0LfEhwBwYNkgr8BzBjk6adpB6zHdsV+FK3+W2m+M=;
        b=akQq5WSbSACbxbiMZm+Ddhqs0fRnYvY0NsvkNDeyxID1Un/uCkL3bUszGeIAbKbS/R
         xjRliz7i83BAZt9CvVTOfK6yc5WSQJw8y3wLy46zmm6ukEHJ1qeOLxmIlZemrlNA1lIx
         4TFs+OEbJeZArQE3lKDT+Sw0zItK+IGm8Y1MI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=LhU8d2L45NFmzLDqflVXRbtXH19gOYDVpRwW7KK2xavvahoiG86utyWSMKCSoZcbfj
         CkkmrNzmS+bLhWXQ991TgLJ0WwB8nHAN4R8jUYCJn352AGOAxRKfoQa0OI1Ppt5cPGYw
         02f6DytKHafPOBGgQ2SfQKTi7eCzNQlqLVRuY=
Received: by 10.223.111.71 with SMTP id r7mr703148fap.59.1244594418336; Tue, 
	09 Jun 2009 17:40:18 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.01.0906091535410.6847@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121239>

I too would like to see some of the improved UI aspects of EasyGit
merged into git.


On Tue, Jun 9, 2009 at 6:40 PM, Linus
Torvalds<torvalds@linux-foundation.org> wrote:
> So it's not that I object to "git revert" as a name. I just object to
> changing existing (and sane) semantics just for some silly person who
> thinks that git is just "SVN done right".
>
> Git is _soo_ much more than just that. People need to live with the fact
> that it's not just a SVN clone.

I do not think "revert" to mean "checkout --" is just an SVN idiom.  I
have heard similar suggestions by people first learning git who have
never used SVN or CVS before.  To me, "revert" is a very natural name
for a command to undo changes in the working directory.  "Checkout,"
on the other hand, usually means to switch branches, which is
logically distinct from undoing changes in the working tree.  In fact,
if one tries to use "checkout" to switch a branch while there are
local changes, git will refuse!

At the same time, "revert" also is a fine name for making an inverse
commit, as revert currently does.  So perhaps overloading revert as
you suggest is a good idea.  It is wise, as you suggest, to keep
backwards compatibility for existing users.



Mark
