From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] builtin-clone: Implement git clone as a builtin command.
Date: Tue, 11 Dec 2007 15:59:13 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0712111549490.5349@iabervon.org>
References: <20071211195712.GA3865@bitplanet.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1547844168-1092064470-1197406753=:5349"
Cc: git@vger.kernel.org
To: Kristian =?utf-8?B?SMO4Z3NiZXJn?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 21:59:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2CCW-0002AI-Rh
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 21:59:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952AbXLKU7P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 15:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbXLKU7P
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 15:59:15 -0500
Received: from iabervon.org ([66.92.72.58]:39801 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750920AbXLKU7O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 15:59:14 -0500
Received: (qmail 21458 invoked by uid 1000); 11 Dec 2007 20:59:13 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 11 Dec 2007 20:59:13 -0000
In-Reply-To: <20071211195712.GA3865@bitplanet.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67939>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1547844168-1092064470-1197406753=:5349
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 11 Dec 2007, Kristian H=C3=B8gsberg wrote:

> Ok, don't flame me, I know this isn't appropriate at the moment with
> stabilization for 1.5.4 going on, but I just wanted to post a heads up
> on this work to avoid duplicate effort.  It's one big patch at this point
> and I haven't even run the test suite yet, but that will change.

Is that why you misspelled Junio's email address? :)=20

Also as a heads-up, I've got a builtin-checkout that I've got passing all=
=20
the tests (plus a few to test stuff I originally hadn't implemented). This=
=20
mostly involved correcting the "interesting" states that unpack_trees()=20
can leave the index in memory when it returns and figuring out how the=20
merge code works. I can send it off for review and testing to people who=20
are interested and don't have other things they should be doing instead.

=09-Daniel
*This .sig left intentionally blank*
--1547844168-1092064470-1197406753=:5349--
