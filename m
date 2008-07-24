From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Git Documentation
Date: Thu, 24 Jul 2008 02:31:05 +0200
Message-ID: <20080724003105.GA16873@diana.vm.bytemark.co.uk>
References: <d411cc4a0807212035v68c2ed95m93b77c1e61cfec9e@mail.gmail.com> <EDFF27AB-9B74-4868-A0BF-61AC8ED75037@simplicidade.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Scott Chacon <schacon@gmail.com>, git@vger.kernel.org
To: Pedro Melo <melo@simplicidade.org>
X-From: git-owner@vger.kernel.org Thu Jul 24 02:10:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLoPZ-0007Rl-5X
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 02:10:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754353AbYGXAJW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jul 2008 20:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753778AbYGXAJW
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 20:09:22 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3112 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753976AbYGXAJW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 20:09:22 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KLojZ-00053c-00; Thu, 24 Jul 2008 01:31:05 +0100
Content-Disposition: inline
In-Reply-To: <EDFF27AB-9B74-4868-A0BF-61AC8ED75037@simplicidade.org>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89816>

On 2008-07-22 11:15:40 +0100, Pedro Melo wrote:

> I also point them to Tommi Virtanen "Git for Computer
> Scientists":http://eagain.net/articles/git-for-computer-scientists/.
> It was that article that made it all "click" for me regarding git.

Me too.

I've found that starting off by explaining how git represents history
with blobs, trees, and commits (no need to mention tags or other
objects just yet), and how branches and merging just fall out
naturally from the commit DAG, is a good way to get people to
appreciate just how simple git's data model is. After that five-minute
introduction, they have a reasonable mental model of what the git
commands operate on -- then they just need to fill in the details,
like what commands there are and how they work.

(I've never taught git to anyone who didn't already know what a DAG or
a cryptographic hash is -- presumably, that would make it take more
than five minutes.)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
