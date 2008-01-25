From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: stgit: managing signed-off-by lines
Date: Fri, 25 Jan 2008 16:40:27 +0100
Message-ID: <20080125154027.GA11526@diana.vm.bytemark.co.uk>
References: <9e4733910801241227n659a5b34x7f77f25101aa225f@mail.gmail.com> <20080125083853.GA5804@diana.vm.bytemark.co.uk> <9e4733910801250534s7ab11b15uff3c782165a8e2ea@mail.gmail.com> <20080125143026.GA10132@diana.vm.bytemark.co.uk> <9e4733910801250643u11819491i961d092deae7c5d7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 16:41:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIQfy-0003wo-5p
	for gcvg-git-2@gmane.org; Fri, 25 Jan 2008 16:41:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753539AbYAYPkg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jan 2008 10:40:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753490AbYAYPkf
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jan 2008 10:40:35 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1679 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752114AbYAYPkf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2008 10:40:35 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JIQfL-000313-00; Fri, 25 Jan 2008 15:40:27 +0000
Content-Disposition: inline
In-Reply-To: <9e4733910801250643u11819491i961d092deae7c5d7@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71714>

On 2008-01-25 09:43:51 -0500, Jon Smirl wrote:

> Longer term you may want to add a de-dupe check for the
> signed-off-by lines that gets called in all contexts.

Mmm. You mean some kind of sanity check filter that's applied after
the template? I guess we could do that, but it feels like that kind of
approach could easily get out of hand.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
