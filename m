From: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Subject: Re: most commonly used git commands?
Date: Mon, 25 Jun 2007 10:17:52 +0300
Message-ID: <20070625071752.GB15343@mellanox.co.il>
References: <20070625064017.GA2839@mellanox.co.il>
	<7vlke833wr.fsf@assigned-by-dhcp.pobox.com>
Reply-To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 25 09:17:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2ipa-00008N-JT
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 09:17:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbXFYHRt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 03:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbXFYHRs
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 03:17:48 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:44967 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750853AbXFYHRs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2007 03:17:48 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1229175ugf
        for <git@vger.kernel.org>; Mon, 25 Jun 2007 00:17:45 -0700 (PDT)
Received: by 10.67.98.9 with SMTP id a9mr4956034ugm.1182755865452;
        Mon, 25 Jun 2007 00:17:45 -0700 (PDT)
Received: from ?127.0.0.1? ( [194.90.237.34])
        by mx.google.com with ESMTP id l40sm4540563ugc.2007.06.25.00.17.41
        (version=SSLv3 cipher=OTHER);
        Mon, 25 Jun 2007 00:17:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vlke833wr.fsf@assigned-by-dhcp.pobox.com>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50869>

> Quoting Junio C Hamano <gitster@pobox.com>:
> Subject: Re: most commonly used git commands?
> 
> "Michael S. Tsirkin" <mst@dev.mellanox.co.il> writes:
> 
> > I did this by mistake:
> >
> > $git fet linux-2.6
> > git: 'fet' is not a git-command
> >
> > The most commonly used git commands are:
> >    add     Add file contents to the changeset to be committed next
> >    apply   Apply a patch on a git index file and a working tree
> > (use 'git help -a' to get a list of all installed git commands)
> >
> > why does git say that add and apply are most commonly used git commands?
> 
> Perhaps they are most commonly used by the person who came up
> with that list first ;-)?
> 
> I think "add" deserves to be there, I am not sure "apply" is.

git add is supposed to be rare, no?
That's why git commit lists file additions/removals ...

My list is typically
git checkout
git commit
git pull
git push
git rebase
git reset
git update-index

Maybe it makes sense to take the list from
"Main porcelain commands" section in git manual?

-- 
MST
