From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Can I remove stg sync --undo ?
Date: Wed, 2 Jul 2008 09:25:24 +0200
Message-ID: <20080702072524.GA26805@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 02 09:39:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDwwE-0007v2-EH
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 09:39:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760540AbYGBHik convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jul 2008 03:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760214AbYGBHik
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 03:38:40 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4467 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759970AbYGBHik (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 03:38:40 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KDwiS-0007D6-00; Wed, 02 Jul 2008 08:25:24 +0100
Content-Disposition: inline
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87092>

I'm preparing a patch that removes all the old --undo flags, and
discovered that stg sync has an --undo flag backed by
stack.undo_refresh().

Is it OK if I remove it? "stg undo" will allow you to undo the whole
command, or, in case of conflicts, either the whole command or just
the last conflicting push. But it does not allow for undoing the last
refresh (whether it succeeded or not). I don't know how refresh is
used, so I can't really tell if "stg undo" is currently insufficient.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
