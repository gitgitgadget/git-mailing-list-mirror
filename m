From: Jay Soffian <jaysoffian@gmail.com>
Subject: Merge commit subjects git.git
Date: Sun, 18 Jul 2010 04:22:25 -0400
Message-ID: <AANLkTikavL0DH8FgFxBw7hbGLtj2tqxnP-BT77zo5FJT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 18 10:22:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OaP8r-0001yg-DB
	for gcvg-git-2@lo.gmane.org; Sun, 18 Jul 2010 10:22:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752312Ab0GRIW2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jul 2010 04:22:28 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37246 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751998Ab0GRIW1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jul 2010 04:22:27 -0400
Received: by iwn7 with SMTP id 7so3550645iwn.19
        for <git@vger.kernel.org>; Sun, 18 Jul 2010 01:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:cc:content-type;
        bh=OtIrlTj3QLDYfynHvRPYYBThENnt6bfqqegsYpwnOTg=;
        b=aBd5aEqPpHcJldA9QGkh9KWkTgVqPTnzrNDKEaPJEF2v7RtSL9ZgewzCCi39SiQ11f
         I+FGZShDC6QqRE7KhK6Q1XK4sP18yj89BkXZ7TXu+CmUiQZjwvsxlBmAeO6/cpRxR4pK
         WTiTM7YMth5IQ/aoY0Xegfpfr2Z7+lVEtrYsg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=adjSXWfak3w5niHEBqxeMuu3DH+/B20QJ2BXZDMa+sTWuHAixKlCqXs42V7r2rr9aZ
         a1Op84rHFlwGWeFeagJzTahU8I+dapK2KCPeKV8c3e2M3mllUM20LhW/Vu4aILDeHJBB
         FHzfJy86/KEMrWzhNjBajbsLOLxgsfLkRf90E=
Received: by 10.231.183.200 with SMTP id ch8mr3711361ibb.124.1279441345882; 
	Sun, 18 Jul 2010 01:22:25 -0700 (PDT)
Received: by 10.231.152.133 with HTTP; Sun, 18 Jul 2010 01:22:25 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151203>

Color me curious, but why do the merge commit message in git.git
sometimes look like this:

  Merge branch 'jn/paginate-fix'

And other times like this:

  Merge remote branch 'ko/master' into jc/read-tree-cache-tree-fix

I don't really see any rhyme or reason about when the "into ..." is
there and when it's not.

Also, the "Sync with 1.7.1.1" merges are I guess are from something like:

  git merge -s ours -m "Sync with 1.7.1.1" maint

?

j.
