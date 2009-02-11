From: Anton Gyllenberg <anton@iki.fi>
Subject: Re: [PATCH] git-svn: fix broken symlink workaround when switching 
	branches
Date: Wed, 11 Feb 2009 19:44:09 +0200
Message-ID: <83dfc36c0902110944n57502fb6jc2ae5cf79bd4276b@mail.gmail.com>
References: <83dfc36c0902101438p7b7fbff8ja66b1fb021942cd8@mail.gmail.com>
	 <20090211101207.GA28840@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Feb 11 18:45:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXJ9Z-0007fH-A2
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 18:45:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755887AbZBKRoO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 12:44:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755199AbZBKRoO
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 12:44:14 -0500
Received: from mail-ew0-f21.google.com ([209.85.219.21]:45538 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755181AbZBKRoN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 12:44:13 -0500
Received: by ewy14 with SMTP id 14so262525ewy.13
        for <git@vger.kernel.org>; Wed, 11 Feb 2009 09:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=1aX+lNjValISi0jQ3HJN2kD/8OHcIVfgR7Fj/QQ6m1c=;
        b=kk/Hl0avT32RgXJ+6qVjJKsmoD0FLiEyrp+j+qx8mpWTop34JbEC01xp6QQldFQBPH
         qIvxUJmDYH3jVZ1keoBJopXskUI+1WNNdu9jZblUrcZS85Vyp8/eW436xh2bV8jopKnO
         zrf5EqEqRB3GlIRWqQw7bIPSMlGdcc/cwoHtk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=gJhJx0Cz+5xNSiFk9u5ZRi6CYQUwCCKwisTyGDEZrovKx+XXzO/iSChzKrcXVpyQO2
         aL89G3+Bk0konzhHcr2UiC9W4iDNfhHAERIzwEe9ZeHn8CpHdHKFxJBNmAbQ6RM6fhRk
         EGit/rhdwRUOJXD9A47xm1PK8qz/VWIYEP6WQ=
Received: by 10.210.70.14 with SMTP id s14mr5910374eba.86.1234374249283; Wed, 
	11 Feb 2009 09:44:09 -0800 (PST)
In-Reply-To: <20090211101207.GA28840@dcvr.yhbt.net>
X-Google-Sender-Auth: cf0669c1cbb68d5b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109455>

On Wed, Feb 11, 2009 at 12:12 PM, Eric Wong <normalperson@yhbt.net> wrote:
>  Thanks Anton, I've made the following patch along with your
>  testcase and pushed to git://git.bogomips.org/git-svn
>
>  Can you let me know if it works on a real repo (or breaks anything
>  else)?  It's once again way past my bed time...
>
>  git-svn.perl |   11 ++++++-----
>  1 files changed, 6 insertions(+), 5 deletions(-)

I checked out that version and it works perfectly on the real repo I
initially noticed the problem on. The end results are identical to
git-svn from v1.6.0.4 (predates the symlink scan) when fetching 2000+
revisions spanning the problematic branch messup. Works and did not
break anything for me.

Thank you for your work on git-svn!
Anton
