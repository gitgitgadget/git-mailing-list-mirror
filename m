From: Uri Okrent <uokrent@gmail.com>
Subject: Question: start mergetool with trivial differences already handled?
Date: Mon, 17 May 2010 13:47:23 -0700
Message-ID: <AANLkTinYq5LKcY8EDzfCGRoEYXftcd15Dviww749uBUC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: The Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 17 23:48:52 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OE8BA-0001Ko-5u
	for gcvg-git-2@lo.gmane.org; Mon, 17 May 2010 23:48:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754197Ab0EQVsq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 May 2010 17:48:46 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45106 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754035Ab0EQVsq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 May 2010 17:48:46 -0400
X-Greylist: delayed 3334 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 May 2010 17:48:45 EDT
Received: by iwn6 with SMTP id 6so773973iwn.19
        for <git@vger.kernel.org>; Mon, 17 May 2010 14:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type:content-transfer-encoding;
        bh=2+d7mjI30riCrMqg3XyGMdw4vTPbm7CU4OFrTQ6nUfI=;
        b=VpTYdck0Unu77w6mKS9Rmcwl6Y9rEkvN4n8wl6+hh6Xy/sL9VJPZbNLsrpSjzkJEWS
         cxTltGV07UC4n1jZUjLeiMwQ5KJTx0itcWSvXeIy58WMd/jho51kmdzSuhP7mPInb4gx
         ZRTl4WnJSqQ4E6wpWnVVL8JFIZyHUTpKGQSVA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=YTVCVUcY8B8gw6cJKOXKCXMBBTzdzYspq/IcFlaVHcgZ7XWpgrjrmQnbh3ZY5uimIF
         +PqQseAMEJWUCeyUMLOda/YiCmvkM+MPVga5RU++L3Xcc0MuZByMN+YjUWU+YoqBb3ji
         rexRZmywCJUwBdGkXx6gEpG8TlJDHl0mjeKiM=
Received: by 10.231.79.4 with SMTP id n4mr818950ibk.16.1274129243198; Mon, 17 
	May 2010 13:47:23 -0700 (PDT)
Received: by 10.231.200.198 with HTTP; Mon, 17 May 2010 13:47:23 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147259>

Hey all, just wondering if this is possible (as things stand, I don't
think it is).

Basically, I'd like to be able to fire up merge tool with all the trivi=
al
merges already taken care of (since git is better than I am at resolvin=
g the
trivial ones anyway).

The way I understand it, mergetool populates the merge tool with the ba=
se
file (file from the common ancestor), file from ours, and file from the=
irs.
So, when I pull up mergetool, I see all the differences in between ours=
 and
theirs, even if git knows how to resolve many of those.  What I always =
end up
doing instead is just running vi on the unmerged path in my repo since =
that
way I only see the actual conflicts (those marked with conflict markers=
).

The net effect is that I almost never use mergetool, even though I woul=
d
like to.

Do the various diff tools out there understand the conflict marker synt=
ax? It
would be nice to be able to just tell mergetool to visually display the
"unmerged" version of the path that git dumps in your working tree.  Id=
eally,
it would be able to show ours and theirs, with all the trivial differen=
ces
pre-selected as git itself would have resolved them, but that seems mor=
e pie-
in-the-sky, and a lot harder to do.

Thanks!
--
=C2=A0 Uri

Please consider the environment before printing this message.
http://www.panda.org/how_you_can_help/
