From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] Add subcommand "help" to the list of most commonly used subcommands
Date: Thu, 5 Jun 2008 20:42:40 +0200
Message-ID: <F9BB4443-EDCA-4941-9852-B84535DAD097@wincent.com>
References: <alpine.DEB.1.00.0806050747000.21190@racer> <20080605081911.GA5946@mithlond.arda.local> <7viqwn3g3r.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Teemu Likonen <tlikonen@iki.fi>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 05 20:47:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4KU7-0001QN-CV
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 20:46:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752329AbYFESp5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Jun 2008 14:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752517AbYFESp5
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 14:45:57 -0400
Received: from wincent1.inetu.net ([209.235.192.161]:33587 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752329AbYFESp4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Jun 2008 14:45:56 -0400
Received: from cuzco.lan (35.pool85-53-24.dynamic.orange.es [85.53.24.35])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id m55Igi88016785
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 5 Jun 2008 14:42:47 -0400
In-Reply-To: <7viqwn3g3r.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83955>


El 5/6/2008, a las 20:13, Junio C Hamano escribi=F3:

> It is reasonable to mention 'help' somewhere in the output, but if =20
> we are
> going to do this, we should make it stand out.  Perhaps like this.
>
> -- >8 --
> $ git
> usage: git [--version] ...
>
> The most commonly used git commands are:
>   add        Add file contents to the index
>   bisect     Find the change that introduced a bug by binary search
>   branch     List, create, or delete branches
>   ...
>   show       Show various types of objects
>   status     Show the working tree status
>   tag        Create, list, delete or verify a tag object signed with =
=20
> GPG
>
> See 'man git' and 'git help' for more information.
> -- 8< --

But if the user types "git help" they'll be presented with the exact =20
same list of common commands again, at which point they'll probably =20
wonder why Git suggested that.

=46unnily enough, if they type "git help help" then they'll get the "gi=
t-=20
help" man page. So, there is no command called "git-help" on the =20
system, but from the user's perspective it walks, talks and quacks =20
like all the "real" commands, and so they probably consider it to be =20
one. Whether or not the "help" subcommand corresponds to a real =20
executable or script is really just an implementation detail, I think.

Having said that, I think your suggestion is sound if it were reworded =
=20
as:

   See 'man git' and 'git help [command]' for more information.

Cheers,
Wincent
