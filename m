From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: stgit: another way of storing patches
Date: Wed, 21 Nov 2007 12:24:59 +0100
Message-ID: <20071121112459.GA6592@diana.vm.bytemark.co.uk>
References: <9e4733910711200653g4d87c433gae2d48f3508940f5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 21 12:25:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iunhz-0005r1-IM
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 12:25:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755372AbXKULZO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Nov 2007 06:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755130AbXKULZO
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 06:25:14 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3126 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754819AbXKULZM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 06:25:12 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IunhT-00026O-00; Wed, 21 Nov 2007 11:24:59 +0000
Content-Disposition: inline
In-Reply-To: <9e4733910711200653g4d87c433gae2d48f3508940f5@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65630>

On 2007-11-20 09:53:55 -0500, Jon Smirl wrote:

> What about storing each stg git patch in a branch and then
> auto-merging them into the working copy?

You mean making a "patch" be a topic branch rather than just one
commit, with the successive commits on the topic branch reflecting the
changes to the patch over time?

How would you handle operations such as refreshing a non-topmost
patch, reordering patches, dropping patches, etc? It seems to me that
the operation you'd want then would look more like cherry-picking than
merging, at least sometimes.

It might work, but someone would have to sit down with pen and paper
and work out how all the common operations should work.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
