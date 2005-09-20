From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: cg-diff still broken on some BSDs
Date: Tue, 20 Sep 2005 16:15:28 +1200
Message-ID: <46a038f905091921154a70123f@mail.gmail.com>
Reply-To: martin.langhoff@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Tue Sep 20 06:15:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHZXY-00009w-Ra
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 06:15:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964874AbVITEPa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Sep 2005 00:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964875AbVITEPa
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Sep 2005 00:15:30 -0400
Received: from qproxy.gmail.com ([72.14.204.194]:55062 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964874AbVITEPa convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2005 00:15:30 -0400
Received: by qproxy.gmail.com with SMTP id o38so243485qbe
        for <git@vger.kernel.org>; Mon, 19 Sep 2005 21:15:28 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=RtnpDKAqx9noFuou7UpQ737ibTxc0q58XY1+ud2EcP49b4/f7qk3/mQzFlzIi9KI2Xm3DFeFgbSPu3Ab27gX/3LAnqDVbn5hjdrMJx61bCb4NIjq9jMO8lXFA7R3V8lp7BNJzfdlDYUBkx3cuLr2zLe8w0lXhXIvgTxsFJwb/mo=
Received: by 10.64.195.16 with SMTP id s16mr69260qbf;
        Mon, 19 Sep 2005 21:15:28 -0700 (PDT)
Received: by 10.64.232.18 with HTTP; Mon, 19 Sep 2005 21:15:28 -0700 (PDT)
To: Git Mailing List <git@vger.kernel.org>, Petr Baudis <pasky@ucw.cz>,
	kevin@catalyst.net.nz
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8970>

Petr,

We still have a bug in cg-diff when using the BSD xargs. I posted a
fix, and Junio posted an alternative approach. The original patches
are here http://marc.theaimsgroup.com/?l=git&m=112541165904627&w=2

For some strange reason, it is not showing up on my OSX box, but it is
definitely reproduceable in a proper FreeBSD box.

I am happy to rebase my patch (or Junio's) against current cogito if
needed, but I rather do only one of them ;)

cheers,


martin
