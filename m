From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] Implement git-staged, an alias for 'git diff --cached'.
Date: Wed, 29 Oct 2008 17:16:44 +0100
Message-ID: <08FC4756-8890-449D-BB55-90E4761C9B93@wincent.com>
References: <20081029003931.GA7291@sigill.intra.peff.net> <1225241048-99267-1-git-send-email-dsymonds@gmail.com> <C0BD1E4B-130F-4A16-8865-8EEABE1431FD@wincent.com> <alpine.DEB.1.00.0810291604200.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Symonds <dsymonds@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, Jeff King <peff@peff.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 29 17:19:09 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvDl0-0003KS-Oa
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 17:18:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754650AbYJ2QRk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Oct 2008 12:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754632AbYJ2QRk
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 12:17:40 -0400
Received: from wincent1.inetu.net ([209.235.192.161]:58212 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753963AbYJ2QRj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Oct 2008 12:17:39 -0400
Received: from cuzco.lan (225.pool85-53-3.dynamic.orange.es [85.53.3.225])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id m9TGGjsB022272
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 29 Oct 2008 12:16:47 -0400
In-Reply-To: <alpine.DEB.1.00.0810291604200.22125@pacific.mpi-cbg.de.mpi-cbg.de>
X-Mailer: Apple Mail (2.929.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99377>

El 29/10/2008, a las 16:08, Johannes Schindelin escribi=F3:

> Hi,
>
> On Wed, 29 Oct 2008, Wincent Colaiuta wrote:
>
>> El 29/10/2008, a las 1:44, David Symonds escribi=F3:
>>
>>> +SCRIPT_SH +=3D git-staged.sh
>>
>> Isn't this exactly what aliases are for?
>>  git config --global alias.staged "diff --cached"
>> (Rather than adding yet another command...)
>
> The difference being, of course, that we do not ship default aliases =
=20
> (and
> neither do we plan to...).
>
> So saying "this is what aliases are for" you ask for _newbies_ to =20
> add it
> for themselves.  We are talking the same newbies who should be =20
> helped by
> that command, and typically do not know that there are Git aliases =20
> yet.
>
> Even worse, just sum the times it takes everybody to make that =20
> alias, and
> then compare with the time it would take to include something like =20
> David
> posted in git.git.  It should be obvious that the time balance is
> absolutely horrible.

Git already has too many commands. Adding more is not going to clear =20
up newbie confusion, and will only waste time because people will =20
complain about it and ask why there is this kind of duplication.

W
