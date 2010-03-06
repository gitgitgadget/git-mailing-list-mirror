From: Tait <git.git@t41t.com>
Subject: Re: using gvim as editor on Windows
Date: Fri, 5 Mar 2010 23:37:29 -0800
Message-ID: <20100306073729.GN2480@ece.pdx.edu>
References: <20100306070628.GM2480@ece.pdx.edu> <8c9a061003052322v446acddbm5792038af450d0b9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jacob Helwig <jacob.helwig@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 06 08:37:48 2010
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nnoa3-00060m-Kq
	for gcvg-git-2@lo.gmane.org; Sat, 06 Mar 2010 08:37:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752059Ab0CFHhc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Mar 2010 02:37:32 -0500
Received: from rcpt.cat.pdx.edu ([131.252.208.107]:34412 "EHLO
	rcpt.cat.pdx.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381Ab0CFHhc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Mar 2010 02:37:32 -0500
Received: from nemo.ece.pdx.edu (root@nemo.ece.pdx.edu [131.252.209.162])
	by rcpt.cat.pdx.edu (8.14.2/8.14.2/Debian-2build1) with ESMTP id o267bTnG010094
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 5 Mar 2010 23:37:29 -0800
Received: from nemo.ece.pdx.edu (tait@localhost [127.0.0.1])
	by nemo.ece.pdx.edu (8.13.6/8.13.1) with ESMTP id o267bTkW026788;
	Fri, 5 Mar 2010 23:37:29 -0800 (PST)
Received: (from tait@localhost)
	by nemo.ece.pdx.edu (8.13.6/8.12.6/Submit) id o267bT2o026787;
	Fri, 5 Mar 2010 23:37:29 -0800 (PST)
X-Authentication-Warning: nemo.ece.pdx.edu: tait set sender to git.git@t41t.com using -f
Content-Disposition: inline
In-Reply-To: <8c9a061003052322v446acddbm5792038af450d0b9@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (rcpt.cat.pdx.edu [131.252.208.107]); Fri, 05 Mar 2010 23:37:29 -0800 (PST)
X-Spam-Status: No, score=0.0 required=6.0 tests=none autolearn=failed
	version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on rcpt.cat.pdx.edu
X-Virus-Scanned: clamav-milter 0.95.2 at rcpt.cat.pdx.edu
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141609>

> > I'd prefer to use gvim as an editor on Windows XP instead of vim...
> >     start "dummy" /b /wait "C:\Program Files\Vim\vim72\gvim.exe" %*
>
> Use the -f (stay in the foreground) flag.  I haven't tried this in
> Windows, but that's how I've used it in Linux.
>
> [core]
>     editor = gvim -f

On Windows, gvim -f is basically a shortcut for the start invocation I
pasted above. It works well enough for commit, but not for rebase (or
alternately, for rebase -- so long as it doesn't open an editor for git
commit -- but not commit).

Tait
