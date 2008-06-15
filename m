From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] Add SVN->Git conversion example to documentation
Date: Sun, 15 Jun 2008 15:17:42 +0200
Message-ID: <20080615131742.GA316@diana.vm.bytemark.co.uk>
References: <20080614180334.GA26359@zakalwe.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Heikki Orsila <heikki.orsila@iki.fi>
X-From: git-owner@vger.kernel.org Sun Jun 15 15:19:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7s8N-0003ri-1F
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 15:19:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757395AbYFONSJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Jun 2008 09:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754013AbYFONSH
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 09:18:07 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2751 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753461AbYFONSH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 09:18:07 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1K7s74-0000f2-00; Sun, 15 Jun 2008 14:17:42 +0100
Content-Disposition: inline
In-Reply-To: <20080614180334.GA26359@zakalwe.fi>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85088>

On 2008-06-14 21:03:34 +0300, Heikki Orsila wrote:

>  DESCRIPTION
>  -----------
> -git-svn is a simple conduit for changesets between Subversion and gi=
t.
> -It is not to be confused with linkgit:git-svnimport[1], which is
> -read-only.
> +git-svn is a simple bidirectional conduit for changesets between
> +Subversion and git. It is used to develop projects with Git tools,
> +but commit changes to a Subversion repository. It can also be used t=
o
> +convert a Subversion repository to a Git repository. It should not t=
o
> +be confused with linkgit:git-svnimport[1], which does Subversion to
> +Git conversion, but not the other direction.

I don't know if it's such a good idea to mention git-svnimport at all;
but if you do, please also mention that it's no longer supported. (But
really, since it is no longer supported, I doubt mentioning it is a
good idea.)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
