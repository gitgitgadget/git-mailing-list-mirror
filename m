From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: Pull request for sub-tree merge into /contrib/gitstats
Date: Mon, 3 Nov 2008 00:07:46 -0700
Message-ID: <ee77f5c20811022307r59dc4d09m20551a339a2993ea@mail.gmail.com>
References: <bd6139dc0810291606o2efe4254me378335b76861340@mail.gmail.com>
	 <7vljw5evj5.fsf@gitster.siamese.dyndns.org>
	 <bd6139dc0811021124q5ba22d6bm6655f735aaeb379b@mail.gmail.com>
	 <alpine.DEB.1.00.0811030729071.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, sverre@rabbelier.nl,
	git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 03 08:09:04 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwtYd-0003RY-LY
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 08:09:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752067AbYKCHHt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 02:07:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752162AbYKCHHt
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 02:07:49 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:32752 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751751AbYKCHHs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 02:07:48 -0500
Received: by nf-out-0910.google.com with SMTP id d3so902216nfc.21
        for <git@vger.kernel.org>; Sun, 02 Nov 2008 23:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=4lBDdz6Z0jIK38XkBhBgFU2rfytODh8hNdQf7JsBXuY=;
        b=kI7Oc+gD9EowFPRYFNGqzAQkxW4iVW4Qu9H5hvmHXgh8IZ5qNcvis0T6c3IV9icoyi
         BxZKjq+jPsvtUQ7Irq7SVP65JD5Vm5cl5r6/rB7W33YfaAUh3kKr7eVrUgplZ3XiIZIo
         TCzUTdgmTVmBKwqh2st4VHdfmf0V5FLLUaL/A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=pM+uAIGfGrlWar/XfIGtYAm4ziCIt8inCb2sk69B+Bci4XLALg+XDfapYveQHUgHEA
         AVLQq1qbvp62xJnIjSSfcevKA19U2hcw6uh7bb2YDu/hd7k8b3WzZ0c827gF3PRc46QB
         zZdWHPeiJcmmNreP3OMyiydhcD2kwbYiqFmcg=
Received: by 10.210.65.2 with SMTP id n2mr5408794eba.65.1225696066414;
        Sun, 02 Nov 2008 23:07:46 -0800 (PST)
Received: by 10.210.51.7 with HTTP; Sun, 2 Nov 2008 23:07:46 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0811030729071.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99909>

On Sun, Nov 2, 2008 at 11:33 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:

> Actually, I suggested that the end result be submitted as a single patch
> against contrib/, but dsymonds objected that that would lose all history,
> and I concurred that it would be nice to have all changes with the design
> decisions recorded as commit messages, too.

I chatted to Sverre separately, and I think we concluded that we could
probably just do a single patch (no history, no changelogs, etc.), and
just point to the complete git-stats.git repo for folk who want the
detail.


Dave.
