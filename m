From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [BUG] git-svn dcommit fails (connection closed unexpectedly)
Date: Sun, 13 May 2007 20:24:05 +0200
Message-ID: <20070513182405.GA13618@diana.vm.bytemark.co.uk>
References: <vpq7irfengj.fsf@bauges.imag.fr> <20070513171707.GA14024@muzzle> <200705131949.38051.list-receive@mneisen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Eric Wong <normalperson@yhbt.net>,
	Matthieu.Moy@imag.fr
To: Martin Eisenhardt <martin.eisenhardt@mneisen.org>
X-From: git-owner@vger.kernel.org Sun May 13 20:24:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnIk8-0006XD-BP
	for gcvg-git@gmane.org; Sun, 13 May 2007 20:24:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757411AbXEMSYX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 13 May 2007 14:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757542AbXEMSYX
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 14:24:23 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3995 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757411AbXEMSYX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2007 14:24:23 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HnIjl-0003eS-00; Sun, 13 May 2007 19:24:05 +0100
Content-Disposition: inline
In-Reply-To: <200705131949.38051.list-receive@mneisen.org>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47159>

On 2007-05-13 19:49:34 +0200, Martin Eisenhardt wrote:

> Another case where I stumbled upon said error message was when I
> added an empty (sub)directory to a project in subversion and then
> used git to track that project. Since git cannot track an empty
> directory, it did not appear in my git working copy. When I mkdir'd
> the directory locally (in my git wc) and then tried to add files
> within that repository, I got exactly the same error as Matthieu.

It might be a net win to let git-svn handle empty directories by
creating an empty .git-svn-empty-dir file in them, instead of
pretending they don't exist.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
