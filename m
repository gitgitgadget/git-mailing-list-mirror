From: Kevin Menard <nirvdrum@gmail.com>
Subject: git fetch origin hanging in 1.7.0
Date: Mon, 15 Feb 2010 19:08:25 -0500
Message-ID: <7e3605161002151608t44bd320cgcd589796a9ec902b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 01:08:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhAzk-00032i-Tg
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 01:08:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311Ab0BPAIr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2010 19:08:47 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:42371 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932277Ab0BPAIq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 19:08:46 -0500
Received: by ywh6 with SMTP id 6so4066891ywh.4
        for <git@vger.kernel.org>; Mon, 15 Feb 2010 16:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type;
        bh=Zj3qDdrc7wRfeky7stWI0Z+3aUkpMthMuIOJwClaEVI=;
        b=MzgNvfzATbwNJ9JDBnBRMffRuyWO5tojMG7GqvUYyyogrDvpY4Ps3EZ5hIDAfNGMWD
         1ReSOD2w6Y1MritPT2iE6c12JUMoUAvaB0i8X+VwwpVHF2ZN9Ejs5Tg6nVj+cvxd0QOX
         DpreK6kLeojqr78XEJ35mmRlJqb5KE85fxi/Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=GFEcbj7vFNhkV37N6R8qSyrtYHCKnzqpO1Ag/enRtiF+vig53yD3cqt43JEdQ+gssU
         xRtthGC57SXkOUp5QEpHGt4HfUNnBoUp11CI6iNMunBgJKBE0c7fDbUwtuGaHs3XezY6
         hqODBycFIdbREIy9ZokCM2NHoPlnRaEhhV6v4=
Received: by 10.150.252.8 with SMTP id z8mr2580246ybh.232.1266278925193; Mon, 
	15 Feb 2010 16:08:45 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140050>

Hi,

I've run into an issue that doing a "git fetch origin" is hanging for
me in git 1.7.0.  The setup here may be wrong, so I don't want to call
it a bug.  But basically I have an empty repo created on the server
that a client then clones.  There's a job that fetches new updates to
the server periodically.  If nothing has been pushed to the server
yet, the client fetch hangs.

This worked fine in 1.6.6, so I'll just roll back my version for now.
But any help on how to do this different would be much appreciated.

-- 
Thanks,
Kevin
