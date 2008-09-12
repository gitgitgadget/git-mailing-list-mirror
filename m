From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH] add option to import series directly from a tar archive
Date: Fri, 12 Sep 2008 15:07:03 +0200
Message-ID: <20080912130703.GA31240@diana.vm.bytemark.co.uk>
References: <48C34EC7.9040102@gmail.com> <20080908180317.GA6123@diana.vm.bytemark.co.uk> <48C56AD9.6040007@gmail.com> <2008-09-12-14-21-13+trackit+sam@rfc1149.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Clark Williams <clark.williams@gmail.com>, git@vger.kernel.org
To: Samuel Tardieu <sam@rfc1149.net>
X-From: git-owner@vger.kernel.org Fri Sep 12 14:46:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ke82Z-0006LJ-Cj
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 14:46:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753212AbYILMpP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Sep 2008 08:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753056AbYILMpP
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 08:45:15 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1147 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752812AbYILMpO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 08:45:14 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Ke8MZ-00088e-00; Fri, 12 Sep 2008 14:07:03 +0100
Content-Disposition: inline
In-Reply-To: <2008-09-12-14-21-13+trackit+sam@rfc1149.net>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95719>

On 2008-09-12 14:21:13 +0200, Samuel Tardieu wrote:

> Two things that would be great would be:
>
>   - to be able to import patches with "-p0" (people not using git
>     often sends such patches)

This should be trivial to implement, since git-apply (pardon the dash)
has a -p flag with precisely this meaning.

>   - to be able to find where the patch should be applied; I
>     sometimes receive patches for GCC directory "gcc/ada/", diffed
>     from there, and if StGit could see that the patch only makes
>     sense there and not at the top-level it would be great as well

I don't believe git-apply can do this (please correct me if I'm
wrong), and the right way to teach StGit to do it would arguably be to
teach it to git-apply and then make StGit use it. It'd be _possible_
to do it directly in StGit, but it wouldn't be quite the right level,
and git users wouldn't benefit.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
