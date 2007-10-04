From: David Brown <git@davidb.org>
Subject: Re: stgit: lost all my patches again
Date: Thu, 4 Oct 2007 08:45:08 -0700
Message-ID: <20071004154508.GA15424@old.davidb.org>
References: <9e4733910710032229m38fb4e47k5aa0b2b2e0eb2251@mail.gmail.com> <20071004083304.GB17778@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Oct 04 17:45:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdStA-0003hm-K3
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 17:45:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755585AbXJDPpM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Oct 2007 11:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756129AbXJDPpM
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 11:45:12 -0400
Received: from mail.davidb.org ([66.93.32.219]:33904 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755100AbXJDPpL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 11:45:11 -0400
Received: from davidb by mail.davidb.org with local (Exim 4.67 #1 (Debian))
	id 1IdSsu-0004JB-AS; Thu, 04 Oct 2007 08:45:08 -0700
Mail-Followup-To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20071004083304.GB17778@diana.vm.bytemark.co.uk>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59967>

On Thu, Oct 04, 2007 at 10:33:04AM +0200, Karl Hasselstr=F6m wrote:

>> I did the 'stg refresh' from a directory that was not being tracked
>> by git. It is in the .gitignore list. This appears to be the root of
>> the problem.
>
>Mmmph. This is not the only StGit command that's apparently not safe
>to run from a subdirectory. See e.g. https://gna.org/bugs/?9986.

I get an "Error: This item is private" from that page, so I'm not sure =
what
that is.

Just yesterday, I had 'stg push' empty out my patches when I ran it fro=
m a
subdirectory.  Fortunately, in this case, the old versions were in the =
log,
but I can imagine someone less familiar with what git and stgit are doi=
ng
not knowing how to recover this.

David
