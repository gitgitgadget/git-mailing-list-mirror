From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: git 1.8.0.rc0.18.gf84667d trouble with "git commit -p file"
Date: Fri, 05 Oct 2012 11:20:45 -0300
Message-ID: <201210051420.q95EKjj3008300@netbook1.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 05 16:31:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TK8va-0004lb-1K
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 16:30:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756048Ab2JEOas (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2012 10:30:48 -0400
Received: from zimbra.inf.utfsm.cl ([200.1.19.17]:33004 "EHLO
	zimbra.inf.utfsm.cl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754709Ab2JEOar (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2012 10:30:47 -0400
X-Greylist: delayed 600 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Oct 2012 10:30:47 EDT
Received: from localhost (localhost [127.0.0.1])
	by zimbra.inf.utfsm.cl (Postfix) with ESMTP id 4A4B01813A9;
	Fri,  5 Oct 2012 11:20:46 -0300 (CLST)
X-Virus-Scanned: amavisd-new at zimbra.inf.utfsm.cl
Received: from zimbra.inf.utfsm.cl ([127.0.0.1])
	by localhost (zimbra.inf.utfsm.cl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ptqf8JmfLg7s; Fri,  5 Oct 2012 11:20:46 -0300 (CLST)
Received: from quelen.inf.utfsm.cl (unknown [IPv6:2800:270:c:0:201:29ff:fefc:bb25])
	by zimbra.inf.utfsm.cl (Postfix) with ESMTPS id 3833118138C;
	Fri,  5 Oct 2012 11:20:46 -0300 (CLST)
Received: from netbook1.inf.utfsm.cl (ip64.4.priv.inf.utfsm.cl [10.10.4.64])
	by quelen.inf.utfsm.cl (8.14.5/8.14.5) with ESMTP id q95EKjJp026888;
	Fri, 5 Oct 2012 11:20:45 -0300
Received: from netbook1.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by netbook1.inf.utfsm.cl (8.14.5/8.14.5) with ESMTP id q95EKjj3008300;
	Fri, 5 Oct 2012 11:20:45 -0300
Content-ID: <8298.1349446845.1@netbook1.inf.utfsm.cl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207108>

What I did:

- New file images/coins.asy ~~-> 'git add images/coins.asy'
- Started adding new stuff to fg.tex
- Noticed a old bug in fg.tex, fixed that one
- Did 'git -pm "Some message"' and selected just the bugfix

But git created a commit _including_ the new file. Tried to go back:

- 'git reset HEAD^'

Now the new file isn't staged anymore


What I expected to happen:

- Only the explicitly selected chunks commited
- No "losing staged changes"
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile 2340000       Fax:  +56 32 2797513
