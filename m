From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] git.__remotes_from_dir() should only return lists
Date: Thu, 6 Sep 2007 13:26:45 +0200
Message-ID: <20070906112645.GA31888@diana.vm.bytemark.co.uk>
References: <20070905165722.17744.56584.stgit@dv.roinet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
X-From: git-owner@vger.kernel.org Thu Sep 06 13:27:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITFVv-0001lO-DI
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 13:27:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753201AbXIFL1G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 6 Sep 2007 07:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754152AbXIFL1F
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 07:27:05 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2128 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751813AbXIFL1E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 07:27:04 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1ITFVV-0008Nt-00; Thu, 06 Sep 2007 12:26:45 +0100
Content-Disposition: inline
In-Reply-To: <20070905165722.17744.56584.stgit@dv.roinet.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57870>

On 2007-09-05 12:57:22 -0400, Pavel Roskin wrote:

> If there are no remotes, return empty list, not None. The later
> doesn't work with builtin set().

Thanks. But I guess an even nicer fix would be to make this function
return a set in the first place.

> This fixes t1001-branch-rename.sh

Hmm. I don't believe I saw t1001 break without this patch (I run the
test suite before I push, but I might have made a mistake of course).
Does the user's environment leak into the test sandbox?

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
