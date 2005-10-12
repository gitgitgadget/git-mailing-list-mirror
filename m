From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] gitk: Add "Refs" menu
Date: Wed, 12 Oct 2005 12:03:18 -0400
Message-ID: <1129132998.31997.32.camel@dv>
References: <20051012115559.6546.qmail@web26305.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 12 18:06:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPj4v-00085C-On
	for gcvg-git@gmane.org; Wed, 12 Oct 2005 18:03:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463AbVJLQDh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Oct 2005 12:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751473AbVJLQDh
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Oct 2005 12:03:37 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:64203 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1751463AbVJLQDg
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2005 12:03:36 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EPj4e-00074F-Nr
	for git@vger.kernel.org; Wed, 12 Oct 2005 12:03:31 -0400
Received: from proski by dv.roinet.com with local (Exim 4.54)
	id 1EPj4Y-0004gv-Vv; Wed, 12 Oct 2005 12:03:19 -0400
To: Marco Costalba <mcostalba@yahoo.it>
In-Reply-To: <20051012115559.6546.qmail@web26305.mail.ukl.yahoo.com>
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10040>

On Wed, 2005-10-12 at 04:55 -0700, Marco Costalba wrote:
>  > And making gitk cooperate with stgit would be a killer application not
> > just for gitk and stgit, but for git itself (i.e. it could be the reason
> > why git is chosen for development over e.g. Mercurial for new projects).
> > 
> 
> Not to advertise, but qgit (http://digilander.libero.it/mcostalba/) already offers 
> stgit integration, among other things.

Very nice.

But it doesn't show correctly in the qt theme I was using (which must be
the default theme in Fedora Core 4 because I never changed it):

http://red-bean.com/proski/qgit.png

The blame for the ugly default gray background should be on Qt or on
Fedora, but it seems to me that qgit is hardcoding white and light gray
(see ODD_LINE_COL and EVEN_LINE_COL in src/mainimpl.cpp).

The style selector in kcontrol has "Standard Background" and "Alternate
Background for Lists".  I don't know if it has an equivalent in qt.
Maybe you could use the standard background and a slightly darkened
version.

Also, please use months names on the homepage.  I thought qgit 0.94 was
released on October 9th.

-- 
Regards,
Pavel Roskin
