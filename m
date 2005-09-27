From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: Cogito: cg-clone doesn't like packed tag objects
Date: Tue, 27 Sep 2005 12:14:31 +0200
Message-ID: <200509271214.31933.Josef.Weidendorfer@gmx.de>
References: <7virwna2oi.fsf@assigned-by-dhcp.cox.net> <7v4q875bbj.fsf@assigned-by-dhcp.cox.net> <20050927094029.GA30889@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Sep 27 12:16:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKCU4-0002IW-Oa
	for gcvg-git@gmane.org; Tue, 27 Sep 2005 12:14:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964886AbVI0KOn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Sep 2005 06:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964888AbVI0KOn
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Sep 2005 06:14:43 -0400
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:40409 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S964886AbVI0KOm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2005 06:14:42 -0400
Received: from dhcp-3s-40.lrr.in.tum.de (dhcp-3s-40.lrr.in.tum.de [131.159.35.40])
	by mail.in.tum.de (Postfix) with ESMTP id 4F48526DD
	for <git@vger.kernel.org>; Tue, 27 Sep 2005 12:14:41 +0200 (MEST)
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
In-Reply-To: <20050927094029.GA30889@pasky.or.cz>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9388>

On Tuesday 27 September 2005 11:40, Petr Baudis wrote:
> Another thing I proposed back then (I think it was in June) was having
> the refs/tags directory further divised based on heads, so all tags for
> head A would be in refs/tags/A/, etc. I didn't pursue this idea now
> because it seemed that there would be way too many duplicate stuff in
> refs/tags/ since most tags are likely to be shared across heads, but
> perhaps it is the beast and cleanest solution after all.

The problem here is that currently there are no global, public branches.
And you should not mix private heads in refs/heads with global tags.
Perhaps interpret tag objects as global branch names, similar to
the "mixture" in .git/refs ?

Josef
