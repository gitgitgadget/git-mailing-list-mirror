From: nisse@lysator.liu.se (Niels =?iso-8859-1?Q?M=F6ller?=)
Subject: Wishlist: git commit --no-edit
Date: Fri, 02 Nov 2012 10:26:22 +0100
Message-ID: <nntxt8ice9.fsf@stalhein.lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 02 10:36:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUDfs-0007gW-RK
	for gcvg-git-2@plane.gmane.org; Fri, 02 Nov 2012 10:36:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932637Ab2KBJgM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Nov 2012 05:36:12 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:47766 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757555Ab2KBJgK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2012 05:36:10 -0400
X-Greylist: delayed 583 seconds by postgrey-1.27 at vger.kernel.org; Fri, 02 Nov 2012 05:36:10 EDT
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 2A12A4002E
	for <git@vger.kernel.org>; Fri,  2 Nov 2012 10:26:24 +0100 (CET)
Received: from stalhein.lysator.liu.se (stalhein.lysator.liu.se [IPv6:2001:6b0:17:f0a0::cc])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTPS id 1C5B440012
	for <git@vger.kernel.org>; Fri,  2 Nov 2012 10:26:24 +0100 (CET)
Received: from stalhein.lysator.liu.se (localhost [127.0.0.1])
	by stalhein.lysator.liu.se (8.14.4+Sun/8.14.4) with ESMTP id qA29QNQH013944
	for <git@vger.kernel.org>; Fri, 2 Nov 2012 10:26:23 +0100 (MET)
Received: (from nisse@localhost)
	by stalhein.lysator.liu.se (8.14.4+Sun/8.14.4/Submit) id qA29QMrm013943;
	Fri, 2 Nov 2012 10:26:22 +0100 (MET)
X-Authentication-Warning: stalhein.lysator.liu.se: nisse set sender to nisse@lysator.liu.se using -f
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (usg-unix-v)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208911>

I'd like to have a git commit option which is the opposite of --edit, t=
o
use the selected commit message as is, without invoking any editor.

Main use case I see would be

  git commit --amend --no-edit

(say you fix a typo in the previous commit which doesn't affect the
commit message). Today, one can get the same effect more clumsily as

  EDITOR=3Dtouch git commit --amend

Or maybe as

  git commit --amend -C HEAD

But I'd really prefer a --no-edit option over those alternatives. And i=
t
might be useful also in combination with other options, e.g., it would
make the -C option equivalent to -c --no-edit, if I understand it
correctly.

Regards,
/Niels

--=20
Niels M=F6ller. PGP-encrypted email is preferred. Keyid C0B98E26.
Internet email is subject to wholesale government surveillance.
