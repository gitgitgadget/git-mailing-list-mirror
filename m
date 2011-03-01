From: Robert Buck <buck.robert.j@gmail.com>
Subject: got myself into trouble; now what? - how to revert once you've pushed
Date: Tue, 1 Mar 2011 14:37:19 -0500
Message-ID: <AANLkTi=RGhGMcoDEL4q2pnnZ97tdswYG7OkjNS3wF7jn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "git@vger.kernel.org List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 01 20:42:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuVSg-0002xO-7y
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 20:42:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757272Ab1CATmK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 14:42:10 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:62896 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757200Ab1CAThU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 14:37:20 -0500
Received: by yxs7 with SMTP id 7so2097623yxs.19
        for <git@vger.kernel.org>; Tue, 01 Mar 2011 11:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=/piR/DdnnQkOAXn+MBMXhm3JtgZ/AeoJrmNYJ/QBfc4=;
        b=vYm3ZOgTehFjNQjR2Mx4VO+U23WGoOx3K0NId0uij0Xka3PIj97FqWKpvGiOc1Mxb1
         9ghWMrwQ1VjjMY2n6/Bvq1LvhvLu5uj5YvAJ5TuqskCuYgHfU0ldv2muY9P+vk37uArt
         BDgL/i3/xg0k64bEMCxsrzzIEDGhC7m7AKLnw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=vW8jh582EGbi8v1MCXCbbd+LboHPZqQT9Jje289W3ukg0aXPtCh/xAJQpzsYgq5PR+
         CLtjRRxZeRmvMjlY6qfj1GdJSF2aEdZryHJcV/IKbTYdDodgN3/aUD6l/esIXvExfVjj
         JwWgq6tiZpC34HUUSFQXfAUreAvyUFoBZcNa8=
Received: by 10.236.185.162 with SMTP id u22mr6930375yhm.23.1299008239137;
 Tue, 01 Mar 2011 11:37:19 -0800 (PST)
Received: by 10.236.108.33 with HTTP; Tue, 1 Mar 2011 11:37:19 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168245>

I have a problem where a unexpected merge occurred and got pushed to
our Gitolite repository.

We have two branches: master, feature/wixinstall

Apparently a merge happened from the branch to master (and I am pretty
sure I never typed `git merge...`). But alas, a merge somehow happened
and got pushed.

Then I followed the Git Pro documentation, which said to do this...

    git revert -m 1 [sha_of_C8]

Now I am left with a bigger mess. When I merge master to the branch,
all the newly added files on the branch got deleted (not what I
wanted). Somehow git is interpreting the revert literally as a
sequence of deletes which it incorrectly then applies to the work on
the branch.

What I really wanted the revert to do is restore the history of the
world immediately prior to the merge. But now I have a branch I can't
merge into at all without losing a weeks work.

How can I get out of this mess?

Bob
