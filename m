From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH] Fixed default install location
Date: Thu, 24 Jul 2008 21:45:48 +0200
Message-ID: <20080724194548.GA15665@diana.vm.bytemark.co.uk>
References: <20080724202031.55dec8e8@whitehouse.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: Daniel White <daniel@whitehouse.id.au>
X-From: git-owner@vger.kernel.org Thu Jul 24 21:24:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM6Qj-0003va-Fr
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 21:24:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753638AbYGXTXs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jul 2008 15:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754791AbYGXTXr
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 15:23:47 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4973 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754789AbYGXTXq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 15:23:46 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KM6l2-0004EY-00; Thu, 24 Jul 2008 20:45:48 +0100
Content-Disposition: inline
In-Reply-To: <20080724202031.55dec8e8@whitehouse.id.au>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89948>

On 2008-07-24 20:20:31 +1000, Daniel White wrote:

> Originally broken by addition of Debian package support.
>
> Signed-off-by: Daniel White <daniel@whitehouse.id.au>
> ---
>
> The default installation direction is actually /usr at present
> despite what 'INSTALL' says.
>
> The 'debian/rules' makefile specifies the prefix as /usr so doesn't
> seem to depend on this. I've tested the resulting debian package and
> everything is still installed correctly under /usr.

Looks correct to me; I'll queue it up in kha/stable. Catalin, do you
have any issues with it?

Those extra comments should have been part of the commit message,
though. I'll fix that.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
