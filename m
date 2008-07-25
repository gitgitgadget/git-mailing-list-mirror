From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT] Supported Eclipse version
Date: Fri, 25 Jul 2008 11:16:52 -0500
Message-ID: <20080725161652.GA21117@spearce.org>
References: <48888A2E.4030302@gmail.com> <89D1384A-403C-4E6E-816C-204AE0AAC30C@yahoo.ca> <4889DF49.3000903@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jean-Frannnois Veillette <jean_francois_veillette@yahoo.ca>,
	git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 18:18:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMPzO-0005Vp-8p
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 18:17:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbYGYQQy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jul 2008 12:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbYGYQQx
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 12:16:53 -0400
Received: from george.spearce.org ([209.20.77.23]:50533 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751247AbYGYQQx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 12:16:53 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id CB600383A5; Fri, 25 Jul 2008 16:16:52 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4889DF49.3000903@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90062>

Marek Zawirski <marek.zawirski@gmail.com> wrote:
> Jean-Fran=C3=A7ois Veillette wrote:
>>> Maybe some users (or developers) from mailing list can tell us abou=
t =20
>>> their opinion?
>>
>> I think keeping comptability for one version behind the 'current' =20
>> (still compatible 3.3 while 3.4 is the current) is a reasonable goal=
=2E
>> 3.2 is relatively far behind, tools vendor had time to get up to dat=
e =20
>> by now.
>
> Robin, Shawn, would you accept next patches using 3.3 API?

Yes, we should be dropping support for 3.2 now and supporting only
3.3 and 3.4 going forward.  3.2 is ancient and anyone who is serious
aboug using Git with Eclipse really should be on a more current
version of the tools.

Same argument that Junio gave about not supporting Debian users who
are still installing git 1.4.4.4 and hope it works; we suggest they
install the 1.5.x based backport as soon as possible.

Commercial Eclipse distributions that are still based upon 3.2
should be upgrading themselves to 3.3 real soon, and if not, their
users should be forching them to do it.

--=20
Shawn.
