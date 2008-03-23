From: Xavier Maillard <xma@gnu.org>
Subject: Re: [PATCH 1/2] help: use man viewer path from "man.<tool>.path" config var
Date: Sun, 23 Mar 2008 02:00:04 +0100
Organization: GNU's Not UNIX!
Message-ID: <200803230100.m2N104Gb025279@localhost.localdomain>
References: <20080318062236.7b5e515f.chriscool@tuxfamily.org> <200803200849.14664.chriscool@tuxfamily.org> <7vtzj1wd7u.fsf@gitster.siamese.dyndns.org> <200803210823.47899.chriscool@tuxfamily.org>
Reply-To: Xavier Maillard <xma@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, pascal@obry.net, nanako3@bluebottle.com,
	git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun Mar 23 02:39:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdFBF-0005Iw-Nt
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 02:39:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755650AbYCWBio convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 Mar 2008 21:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755630AbYCWBio
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Mar 2008 21:38:44 -0400
Received: from master.uucpssh.org ([193.218.105.66]:35347 "EHLO
	master.uucpssh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755529AbYCWBim (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2008 21:38:42 -0400
Received: by master.uucpssh.org (Postfix, from userid 10)
	id D1C02D5B22; Sun, 23 Mar 2008 02:35:52 +0100 (CET)
Received: from localhost.localdomain (IDENT:1000@localhost [127.0.0.1])
	by localhost.localdomain (8.14.1/8.13.8) with ESMTP id m2N104gd025306;
	Sun, 23 Mar 2008 02:00:04 +0100
Received: (from xma@localhost)
	by localhost.localdomain (8.14.1/8.13.8/Submit) id m2N104Gb025279;
	Sun, 23 Mar 2008 02:00:04 +0100
In-reply-to: <200803210823.47899.chriscool@tuxfamily.org> (message from
	Christian Couder on Fri, 21 Mar 2008 08:23:47 +0100)
User-Agent: Rmail in GNU Emacs 23.0.60.3 on GNU/Linux
Jabber-ID: xma01@jabber.fr
X-uucpssh: Found to be clean
X-uucpssh-SpamCheck: not spam, SpamAssassin (not cached, score=-4.305,
	required 4.6, autolearn=not spam, ALL_TRUSTED -1.80, AWL -0.06,
	BAYES_00 -2.60, SPF_HELO_PASS -0.00, TW_FM 0.08, TW_KF 0.08)
X-uucpssh-From: xma@gnu.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77863>


   Le jeudi 20 mars 2008, Junio C Hamano a =E9crit :
   > Christian Couder <chriscool@tuxfamily.org> writes:
   > > Yes, but if the user just wants to use a konq that is not in the=
 path,
   > > then the konq specified with "man.konqueror.path" should behave =
the
   > > same as when using the konq in the path. That means that we shou=
ld also
   > > try to open a new tab on an existing konq, and this will not be =
the
   > > case if we use "/path/konqueror URL" instead of "/path/kfmclient=
 newTab
   > > URL".
   >
   > If that inconsistency bothers you, you probably should rename the
   > built-in konqueror support to "kfmclient", which is more honest ap=
proach,
   > I would think.

   It's perhaps more honest, but kfmclient is not as well known as konq=
ueror.

I am not a KDE user at all and it is true that outside from here,
konqueror is a well known program whereas kfmlient is not (by the
way what is exactly kfmclient ?).

   Isn't a documentation patch like this enough:

   ------8<---------

   diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
   index 4c6cb21..0ece412 100644
   --- a/Documentation/git-help.txt
   +++ b/Documentation/git-help.txt
   @@ -87,7 +87,8 @@ is chosen. Only the following values are currently=
=20
   supported:
    * "man": use the 'man' program as usual,
    * "woman": use 'emacsclient' to launch the "woman" mode in emacs
    (this only works starting with emacsclient versions 22),
   -* "konqueror": use a man KIO slave in konqueror.
   +* "konqueror": use kfmclient to open the man page in a new konquero=
r
   +tab.

I find this clearer at user point of view than the older entry.

Regards,

	Xavier
--=20
http://www.gnu.org
http://www.april.org
http://www.lolica.org
