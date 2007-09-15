From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 00/13] Eliminate 'top' and 'bottom' files
Date: Sun, 16 Sep 2007 01:42:44 +0200
Message-ID: <20070915234244.GD25507@diana.vm.bytemark.co.uk>
References: <20070914222819.7001.55921.stgit@morpheus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, catalin.marinas@gmail.com
To: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Sun Sep 16 01:42:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWhHo-0000a7-Pq
	for gcvg-git-2@gmane.org; Sun, 16 Sep 2007 01:42:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753283AbXIOXmt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Sep 2007 19:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753306AbXIOXmt
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Sep 2007 19:42:49 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4607 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753084AbXIOXms (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2007 19:42:48 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IWhHg-0006kf-00; Sun, 16 Sep 2007 00:42:44 +0100
Content-Disposition: inline
In-Reply-To: <20070914222819.7001.55921.stgit@morpheus.local>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58282>

On 2007-09-15 00:31:09 +0200, David K=E5gedal wrote:

> The following series removes the 'bottom' and 'top' files for each
> patch, and instead uses the commit objects to keep track of the
> patches.

Wonderful! Does this ensure that there's a bijection between patches
and commits at _all_ times, or am I missing something?

> The last two patches do the final cleansing. Obviously, this changes
> the format, and the format version should be increased and and
> update function be written. So it's not really ready to go in yet.

It's a trivial format update, though: just delete those two files and
increase the number from 2 to 3.

Hmm, wait, no. Right. We also have to create commits for those patches
that don't have exactly one commit object. Not that there'll be many
of them, but better not make assumptions ...

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
