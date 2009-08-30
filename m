From: Sean Estabrooks <seanlkml@sympatico.ca>
Subject: Re: how to add an empty initial commit
Date: Sat, 29 Aug 2009 18:39:27 -0700
Message-ID: <BLU0-SMTP13B5A682834BA2E926F610AEF30@phx.gbl>
References: <20090830005224.GC10952@debian.b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: bill lam <cbill.lam@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 30 03:39:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MhZOM-0006Mn-HE
	for gcvg-git-2@lo.gmane.org; Sun, 30 Aug 2009 03:39:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753154AbZH3Bja (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Aug 2009 21:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753136AbZH3Bj3
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Aug 2009 21:39:29 -0400
Received: from blu0-omc3-s13.blu0.hotmail.com ([65.55.116.88]:15859 "EHLO
	blu0-omc3-s13.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753127AbZH3Bj3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Aug 2009 21:39:29 -0400
Received: from BLU0-SMTP13 ([65.55.116.72]) by blu0-omc3-s13.blu0.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 29 Aug 2009 18:39:30 -0700
X-Originating-IP: [96.49.109.68]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from hobo ([96.49.109.68]) by BLU0-SMTP13.blu0.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 29 Aug 2009 18:39:30 -0700
In-Reply-To: <20090830005224.GC10952@debian.b2j>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.16.5; i586-redhat-linux-gnu)
X-OriginalArrivalTime: 30 Aug 2009 01:39:30.0298 (UTC) FILETIME=[B7C82DA0:01CA2912]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127390>

On Sun, 30 Aug 2009 08:52:24 +0800
bill lam <cbill.lam@gmail.com> wrote:

> I want to insert an empty initial commit so that I can rebase and edit
> files in the real initial commit. There is a --root option in
> git-rebase but I can not find example of how to use it. 

Bill,

This sounds like a hard way to go about things.  Instead, you can edit
the files as you wish, "git add" the new edits, and then use
"git commit --amend" to alter the initial commit.   Don't think rebase
would help in the situation you describe.

Sean
