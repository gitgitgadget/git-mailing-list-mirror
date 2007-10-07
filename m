From: "Elijah Newren" <newren@gmail.com>
Subject: Re: Trying to use git-filter-branch to compress history by removing large, obsolete binary files
Date: Sun, 7 Oct 2007 17:24:07 -0600
Message-ID: <51419b2c0710071624v79dc02d2g35a265add50dd46d@mail.gmail.com>
References: <51419b2c0710071423y1b194f22gb6ccaa57303029d1@mail.gmail.com>
	 <20071007213817.GJ31659@planck.djpig.de>
	 <51419b2c0710071500x318ee734n9db6ca9e6daa3196@mail.gmail.com>
	 <Pine.LNX.4.64.0710080018270.4174@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Frank Lichtenheld" <frank@lichtenheld.de>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 08 01:24:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IefTy-0004FG-4h
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 01:24:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755884AbXJGXYK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 19:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755819AbXJGXYI
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 19:24:08 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:35841 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755884AbXJGXYH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 19:24:07 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1458078wah
        for <git@vger.kernel.org>; Sun, 07 Oct 2007 16:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=o2YIKVVHveDwBuJnmLoAmNZ+EqpHs2iNfmEHkdFl0UU=;
        b=ftdfv87PwnlNRtk7zI5lBWtt2WON1pynnzIUylcsVKXB3ekuhR1/FxgD+VSdRZrw/UWMfsrqim0/enBwhORktr6QI1D3z3FX/8CGZ4KMTcxpeg0bpzeQkLrY2Tns6GqSMzeX1iSOxiVtAEkLgxh/yqAvCkeI67SLZHr+FvwuLmo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=g7v+BxFHr6pdaL5tKcZ4QjQpOFEMpcjdRlswWUHb17f5teLg67EveJP2b/zXHzbOrF6KoTsiLdvYHuxQnKxCvuLtr/Iq/JrChcU9swRuWYsP4EJW1l82PMIsphaSIKPmZNT17oWZT3gNoHS4LbP74oUjznu5RwzLyTmZAM6yOps=
Received: by 10.114.75.1 with SMTP id x1mr9108282waa.1191799447065;
        Sun, 07 Oct 2007 16:24:07 -0700 (PDT)
Received: by 10.114.211.8 with HTTP; Sun, 7 Oct 2007 16:24:07 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0710080018270.4174@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60249>

On 10/7/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Sun, 7 Oct 2007, Elijah Newren wrote:
>
> > So...how do I fix the reflog, and then repack to have a pack under 11MB
> > in size?
>
> Just clone it.  The clone will be much smaller.

$ git clone test test2
<snip>
$ du -hs test
11M     test
$ du -hs test2
11M     test2

Any other ideas?
