From: John Keeping <john@keeping.me.uk>
Subject: Re: intend-to-edit flag
Date: Thu, 4 Jul 2013 19:19:11 +0100
Message-ID: <20130704181911.GJ9161@serenity.lan>
References: <2240842.MQEMCLPV8Z@x121e>
 <CACBZZX5tj0EpV7rv6FymSJunPY-Hs1fJrAmmAOnbEb9WKykmYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: thomas@koch.ro, git@vger.kernel.org
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 04 20:19:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uuo7o-0002ZL-Dk
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jul 2013 20:19:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756920Ab3GDSTU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Jul 2013 14:19:20 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:55258 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756833Ab3GDSTU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jul 2013 14:19:20 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 8C08C60650D;
	Thu,  4 Jul 2013 19:19:19 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -10.999
X-Spam-Level: 
X-Spam-Status: No, score=-10.999 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dwPIPhZyQC55; Thu,  4 Jul 2013 19:19:18 +0100 (BST)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id C9301606519;
	Thu,  4 Jul 2013 19:19:13 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CACBZZX5tj0EpV7rv6FymSJunPY-Hs1fJrAmmAOnbEb9WKykmYg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229605>

On Thu, Jul 04, 2013 at 08:10:07PM +0200, =C6var Arnfj=F6r=F0 Bjarmason=
 wrote:
> On Thu, Jul 4, 2013 at 7:56 PM, Thomas Koch <thomas@koch.ro> wrote:
> > we're evaluating Git to be used in our companies Tool. But a hard r=
equirement
> > is the possibility to set an "intend-to-edit" flag on a file (bette=
r path).
> > Notice that I did not use the word "lock"! :-)
> >
> > One easy implementation might be a special branch "XYZ-locks" that =
contains an
> > empty blob for every flagged file. So our tool just needs to check,=
 whether a
> > blob exists for the path that's intended to edit, tries to push a c=
ommit that
> > touches the file and only allows editing if the push succeeds.
>=20
> In my experience everyone who thinks this is a hard requirement is
> wrong.

I completely agree with this.

Having said that, if you're looking at using Gitolite (which you should
if you're hosing your own repositories and not using some other hosting
solution), there is a "lock" command [1].  Note that this cannot stop
you committing changes to "locked" files locally but it does stop you
pushing changes to the central repository that touch locked files.

[1] http://gitolite.com/gitolite/locking.html
