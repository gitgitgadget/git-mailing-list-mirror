From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: packs and trees
Date: Tue, 20 Jun 2006 18:13:21 +1200
Message-ID: <46a038f90606192313l16b16132r1523f5e05ae1566a@mail.gmail.com>
References: <9e4733910606192257y1516e966t848a3b1e29e5667f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 20 08:13:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsZUM-0005Fa-M2
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 08:13:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965074AbWFTGNX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Jun 2006 02:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965075AbWFTGNX
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jun 2006 02:13:23 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:12416 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965074AbWFTGNW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jun 2006 02:13:22 -0400
Received: by ug-out-1314.google.com with SMTP id a2so2117598ugf
        for <git@vger.kernel.org>; Mon, 19 Jun 2006 23:13:21 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KC/lC/v2sSfV0c9sp22SIbM5mH/f8K360FiYoSxvEdV402spLCRw2aKpMIe0JXWJcVzDMosZ+V+oM48ChBkhD5giTiZ3m7FeXgc8AKg8Zdjnwt1cnvKv/Yp55DrNQHPFrbCPivHzE6Z2slM44fmNJKVP17n1TWpab11/oYkqBBE=
Received: by 10.78.52.17 with SMTP id z17mr2507126huz;
        Mon, 19 Jun 2006 23:13:21 -0700 (PDT)
Received: by 10.78.117.11 with HTTP; Mon, 19 Jun 2006 23:13:20 -0700 (PDT)
To: "Jon Smirl" <jonsmirl@gmail.com>
In-Reply-To: <9e4733910606192257y1516e966t848a3b1e29e5667f@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22168>

On 6/20/06, Jon Smirl <jonsmirl@gmail.com> wrote:
> The plan is to modify rcs2git from parsecvs to create all of the git
> objects for the tree.

Sounds like a good plan. Have you seen recent discussions about it
being impossible to repack usefully when you don't have trees (and
resulting performance problems on ext3).

> cvs2svn seems to do a good job at generating the trees.

No doubt. Gut the last stage, and use all the data in the intermediate
DBs to run a git import. It's a great plan, and if you can understand
that Python code... all yours ;-)

> exactly sure how the changeset detection algorithms in the three apps
> compare, but cvs2svn is not having any trouble building changesets for
> Mozilla. The other two apps have some issues, cvsps throws away some
> of the branches and parsecvs can't complete the analysis.

Have you tried a recent parsecvs from Keith's tree? There's been quite
a bit of activity there too. And Keith's interested in sorting out
incremental imports too, which you need for a reasonable Moz
transition plan as well.

cheers,



martin
