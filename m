From: Junio C Hamano <junkio@cox.net>
Subject: Re: Porcelain specific metadata under .git?
Date: Wed, 14 Jun 2006 06:30:01 -0700
Message-ID: <7vpshbeug6.fsf@assigned-by-dhcp.cox.net>
References: <20060614062240.GA13886@spearce.org> <448FEED7.30701@op5.se>
	<e6os3v$r5g$1@sea.gmane.org> <44900A2F.7050704@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jun 14 15:30:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqVRz-0007i9-KI
	for gcvg-git@gmane.org; Wed, 14 Jun 2006 15:30:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964907AbWFNNaH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Jun 2006 09:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964920AbWFNNaH
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jun 2006 09:30:07 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:41132 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S964918AbWFNNaC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jun 2006 09:30:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060614133002.WGJA18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 14 Jun 2006 09:30:02 -0400
To: git@vger.kernel.org
In-Reply-To: <44900A2F.7050704@op5.se> (Andreas Ericsson's message of "Wed, 14
	Jun 2006 15:07:59 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21845>

Andreas Ericsson <ae@op5.se> writes:

> Yes, but I understood him to mean "it's a tree-sha" instead of a
> branch/head thing, which would mean it doesn't fit the .git/refs
> definition of ref.

I am not sure what you meant by "it's a tree-sha", but if you
have an impression that .git/refs define "ref" as committish,
you are mistaken.  Linus has .git/refs/tags/v2.6.11-tree which
tags a tree object.  I even have a .git/refs/tags/junio-gpg-pub
which tags a blob (blobish ;-> ?).
