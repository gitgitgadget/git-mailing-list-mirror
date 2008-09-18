From: David Brown <git@davidb.org>
Subject: Re: Help breaking up a large merge.
Date: Thu, 18 Sep 2008 09:25:07 -0700
Message-ID: <20080918162507.GA878@linode.davidb.org>
References: <20080918152154.GA27019@linode.davidb.org> <adf1fd3d0809180855l42af4fb6l67275daef0d2a529@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Santi =?iso-8859-1?Q?B=E9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Thu Sep 18 18:27:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgMKr-0007DH-On
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 18:26:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754235AbYIRQZJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Sep 2008 12:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754390AbYIRQZJ
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 12:25:09 -0400
Received: from linode.davidb.org ([72.14.176.16]:44903 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753523AbYIRQZI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 12:25:08 -0400
Received: from davidb by mail.davidb.org with local (Exim 4.69 #1 (Debian))
	id 1KgMJX-0000OY-8M; Thu, 18 Sep 2008 09:25:07 -0700
Content-Disposition: inline
In-Reply-To: <adf1fd3d0809180855l42af4fb6l67275daef0d2a529@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96212>

On Thu, Sep 18, 2008 at 05:55:34PM +0200, Santi B=E9jar wrote:

>If the two (or at least one) branches have sufficient isolated commits
>you can recreate the merges that could have happened, as is explained
>(for monotone) in:
>
>http://www.venge.net/mtn-wiki/ZipperMerge
>
>Another option is to rebase one branch onto the other.

Either of these is likely to result in more work.  Both branches have
intermediate results, and there has been some communication between
the developers of each branch, so some things are closer at the two
tips than they would be at intermediate stages.

I started with this approach, and started realizing that I was
resolving similar conflicts repeatedly (not the same, or rerere could
have helped).

Basically, I'm looking for a way to break the merge effort up by
groups of files/directories.

Thanks,
David
