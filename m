From: Pascal Obry <pascal@obry.net>
Subject: Re: Why doesn't git commit -a track new files
Date: Thu, 24 Feb 2011 15:09:55 +0100
Message-ID: <AANLkTinDT6jBxQZ5eukA6Fa=-xRMJsHTJ4pM+Hz4KER_@mail.gmail.com>
References: <20110224112246.3f811ac2@glyph>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Marco <netuse@lavabit.com>
X-From: git-owner@vger.kernel.org Thu Feb 24 15:10:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsbtN-0004bx-RJ
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 15:10:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755101Ab1BXOKA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Feb 2011 09:10:00 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:35363 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752565Ab1BXOJ7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Feb 2011 09:09:59 -0500
Received: by wwb39 with SMTP id 39so778136wwb.1
        for <git@vger.kernel.org>; Thu, 24 Feb 2011 06:09:58 -0800 (PST)
Received: by 10.227.147.16 with SMTP id j16mr824765wbv.125.1298556595990; Thu,
 24 Feb 2011 06:09:55 -0800 (PST)
Received: by 10.227.168.198 with HTTP; Thu, 24 Feb 2011 06:09:55 -0800 (PST)
In-Reply-To: <20110224112246.3f811ac2@glyph>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167807>

Marco,

> I don't understand why there's not switch (is there?) for commit to c=
ommit new
> and deleted files, like -A for git add? Is the only thing to do this =
sth like
>
> git add -A && git commit -m "Message"

Never had the need for this. The reason is maybe when you are trying to=
 have
a small set if incremental commits, you usually don't want to add every=
thing but
you review the change carefully with "git add -p". Now in some circumst=
ances
it could probably be useful.

Pascal.

--=20

--|------------------------------------------------------
--| Pascal Obry=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=A0 T=
eam-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|=A0 =A0 =A0 =A0 =A0 =A0 =A0 http://www.obry.net
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver wwwkeys.pgp.net --recv-key C1082595
