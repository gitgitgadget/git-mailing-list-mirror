From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: Weird shallow-tree conversion state, and branches of shallow trees
Date: Mon, 16 Apr 2007 10:23:26 +0700
Message-ID: <fcaeb9bf0704152023xaa119a4s8590452ff03befcf@mail.gmail.com>
References: <20070412005336.GA18378@curie-int.orbis-terrarum.net>
	 <fcaeb9bf0704142257x3761ef2cie3996420b3bcd24a@mail.gmail.com>
	 <Pine.LNX.4.64.0704151115270.5473@woody.linux-foundation.org>
	 <200704152051.35639.andyparkins@gmail.com>
	 <Pine.LNX.4.64.0704151317180.5473@woody.linux-foundation.org>
	 <20070416021729.GH2689@curie-int.orbis-terrarum.net>
	 <20070416030103.GB27533@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Andy Parkins" <andyparkins@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Robin H. Johnson" <robbat2@gentoo.org>
To: "Theodore Tso" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Mon Apr 16 05:23:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdHoR-0002HX-G1
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 05:23:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754391AbXDPDX2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 23:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754396AbXDPDX2
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 23:23:28 -0400
Received: from wr-out-0506.google.com ([64.233.184.237]:63523 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754391AbXDPDX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 23:23:27 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1394273wra
        for <git@vger.kernel.org>; Sun, 15 Apr 2007 20:23:27 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BdkMyZFps4/mTbacf3pZNo9oadNrr/NaOpWSaRSakMQyJjZW+OAhv+MbX0krP/5Ahil6JNHX8w5tDy16Xyr6HmBkBMPSxo0N3ugLqld+LnOeHyrx+awAAwNnfN9Ri/TPwAg7+3oM+hqhaY+bvNzEEMtAlZ1LkbOIaiuoCvxbfoQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SxnamCsXGZucBg3zkG3AORVjCjRqSPqF25v83rqYFIz+9Mv9woVkJtfrwbIdzoteupp2zEhtg9ZGiKL1a3QKIUiHTbDlKDIAZLMlLs8CoWQu+L6oeUfrrZyAL60iz2b3a/sppXEgtXcVZnKUaK55FSV18jmZHAvS5nMdsLL3QVE=
Received: by 10.114.60.19 with SMTP id i19mr1730775waa.1176693806605;
        Sun, 15 Apr 2007 20:23:26 -0700 (PDT)
Received: by 10.114.66.6 with HTTP; Sun, 15 Apr 2007 20:23:26 -0700 (PDT)
In-Reply-To: <20070416030103.GB27533@thunk.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44564>

On 4/16/07, Theodore Tso <tytso@mit.edu> wrote:
> Simple, the release engineer runs a script which exports the tree,
> expanding any keywords and updating the checksum file as necessary,
> and then the release engineer signs the checksum file!  As has already
> been stated, if this doesn't work, you probably don't have a well
> defined and formal release process.
>
> Just because a developer has signed a checksum doesn't mean that the
> tree is suitable for release; that's the job of the release engineer
> to confirm, probably after running a set of regression test suites.
> And in fact, with git, it's pointless for the developer to sign a
> checksum file and then commit it, since git is already maintaining
> checksums as an integral part of how revisions are named.

Changing Gentoo release process won't make Git the best choice while
other SCM candidates can provide the same functionalities that Gentoo
needs without changing the process.
-- 
Duy
