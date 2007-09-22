From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] git-svn: handle changed svn command-line syntax
Date: Sat, 22 Sep 2007 11:06:17 +0200
Message-ID: <20070922090617.GA6817@diana.vm.bytemark.co.uk>
References: <1190340155146-git-send-email-sam.vilain@catalyst.net.nz> <11903401551014-git-send-email-sam.vilain@catalyst.net.nz> <11903401551812-git-send-email-sam.vilain@catalyst.net.nz> <11903401552164-git-send-email-sam.vilain@catalyst.net.nz> <46F33734.3080408@vilain.net> <46F33A05.2000906@vilain.net> <20070921082348.GA5152@mayonaise>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sam Vilain <sam@vilain.net>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Sep 22 11:06:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZ0wm-0001b8-RO
	for gcvg-git-2@gmane.org; Sat, 22 Sep 2007 11:06:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752109AbXIVJGi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 Sep 2007 05:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751584AbXIVJGi
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Sep 2007 05:06:38 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2796 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974AbXIVJGh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Sep 2007 05:06:37 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IZ0wL-0001sD-00; Sat, 22 Sep 2007 10:06:17 +0100
Content-Disposition: inline
In-Reply-To: <20070921082348.GA5152@mayonaise>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58928>

On 2007-09-21 01:23:48 -0700, Eric Wong wrote:

> The @REV and -rREV distinction/ambiguity has always confused me in sv=
n,
> too.  It always seems that it needed to be one way sometimes, the oth=
er
> way at other times, and even _both_ at other times...

-rREV specifies the operative revision, and @REV specifies the peg
revision. See the clear but dreadfully long explanation here:

  http://svnbook.red-bean.com/en/1.4/svn.advanced.pegrevs.html

In short, it's a way to manage the complexity that comes from
considering files (and directories!) to have an identity that is
preserved across copies and renames.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
