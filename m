From: Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>
Subject: Re: [darcs-devel] Darcs and git: plan of action
Date: Wed, 20 Apr 2005 09:55:28 +0200
Message-ID: <7iy8bdswzz.fsf@lanthane.pps.jussieu.fr>
References: <20050419235832.56117.qmail@web51003.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Apr 20 09:52:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO9za-0000e3-9r
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 09:51:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261431AbVDTHzg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 03:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261465AbVDTHzg
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 03:55:36 -0400
Received: from shiva.jussieu.fr ([134.157.0.129]:38109 "EHLO shiva.jussieu.fr")
	by vger.kernel.org with ESMTP id S261431AbVDTHzb (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 03:55:31 -0400
Received: from hydrogene.pps.jussieu.fr (hydrogene.pps.jussieu.fr [134.157.168.1])
          by shiva.jussieu.fr (8.12.11/jtpda-5.4) with ESMTP id j3K7tT9c010932
          ; Wed, 20 Apr 2005 09:55:29 +0200 (CEST)
X-Ids: 166
Received: from lanthane.pps.jussieu.fr (lanthane.pps.jussieu.fr [134.157.168.57])
          by hydrogene.pps.jussieu.fr (8.13.3/jtpda-5.4) with ESMTP id j3K7tSps024061
          ; Wed, 20 Apr 2005 09:55:28 +0200
Received: from jch by lanthane.pps.jussieu.fr with local (Exim 4.34)
	id 1DOA3U-00021M-24; Wed, 20 Apr 2005 09:55:28 +0200
To: darcs-devel@abridgegame.org, git@vger.kernel.org
In-Reply-To: <20050419235832.56117.qmail@web51003.mail.yahoo.com> (Kannan
 Goundan's message of "Tue, 19 Apr 2005 16:58:32 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.2 (shiva.jussieu.fr [134.157.0.166]); Wed, 20 Apr 2005 09:55:29 +0200 (CEST)
X-Antivirus: scanned by sophie at shiva.jussieu.fr
X-Miltered: at shiva.jussieu.fr with ID 42660AF1.000 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> We're talking about interoperating with a Git repository here,
> right?  Even if we got the metadata in there, doesn't Git have to
> understand a replace patch for things to work out?

> 0. All three are in sync to begin with.

> 1. CC creates a token-replace patch, sends the changes in normal hunk
> format to AA.

> 2. BB makes changes, sends a normal hunk patch to AA and CC.  AA will
> apply the hunk normally.  For CC the token replace might apply here
> and so the result could be different.

3. when AA and CC try to sync, they will get spurious merge conflicts.

> Isn't this a potential problem?

It is.  In a heterogeneous environment they will get spurious merge
conflicts.

                                        Juliusz
