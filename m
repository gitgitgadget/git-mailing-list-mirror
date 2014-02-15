From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 0/4] Good bye fnmatch
Date: Sat, 15 Feb 2014 09:23:24 +0100
Message-ID: <8761og3htv.fsf@fencepost.gnu.org>
References: <1392429709-9237-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 15 09:24:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEaXd-00071S-7D
	for gcvg-git-2@plane.gmane.org; Sat, 15 Feb 2014 09:24:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752286AbaBOIYA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Feb 2014 03:24:00 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:49091 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751884AbaBOIX7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Feb 2014 03:23:59 -0500
Received: from localhost ([127.0.0.1]:48133 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WEaXW-0008BB-Pv; Sat, 15 Feb 2014 03:23:59 -0500
Received: by lola (Postfix, from userid 1000)
	id 6CF0BE40F5; Sat, 15 Feb 2014 09:23:24 +0100 (CET)
In-Reply-To: <1392429709-9237-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 15
 Feb 2014 09:01:45 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242178>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> Long story short, we wanted globbing wildcard "**" so I ripped
> wildmatch library from rsync to do it.

Since version 3.0.0, rsync is GPLv3
<URL:https://rsync.samba.org/GPL.html>.  So be sure to take an older
version.

> And it opened a possibility to replace fnmatch completely, which woul=
d
> provide consistent behavior across platforms (native fnmatch behaves
> differently on many corner cases), and some performance gains. I
> started fnmatch replacement with 4917e1e (Makefile: promote wildmatch
> to be the default fnmatch implementation - 2013-05-30). This is the
> final step.

Sounds like I'm, uh, somewhat late in the game.  More likely than not
you've taken care of that aspect long ago.  Just thought I'd mention it=
=2E

--=20
David Kastrup
