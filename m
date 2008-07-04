From: Jonathan Nieder <jrnieder@uchicago.edu>
Subject: Re: Puzzled by gitk patch representation for merge commits
Date: Fri, 4 Jul 2008 12:51:22 -0500 (CDT)
Message-ID: <Pine.GSO.4.62.0807041240110.19792@harper.uchicago.edu>
References: <g4kpmu$9ga$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-851401618-1215193882=:19792"
Cc: git@vger.kernel.org
To: Jerome Lovy <t2a2e9z8ncbs9qg@brefemail.com>
X-From: git-owner@vger.kernel.org Fri Jul 04 19:52:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEpSL-0001oM-UN
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 19:52:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbYGDRv1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jul 2008 13:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbYGDRv1
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jul 2008 13:51:27 -0400
Received: from smtp00.uchicago.edu ([128.135.12.76]:50567 "EHLO
	smtp00.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750879AbYGDRv1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jul 2008 13:51:27 -0400
Received: from harper.uchicago.edu (harper.uchicago.edu [128.135.12.7])
	by smtp00.uchicago.edu (8.13.8/8.13.8) with ESMTP id m64HpUsr019423;
	Fri, 4 Jul 2008 12:51:30 -0500
Received: from localhost (jrnieder@localhost)
	by harper.uchicago.edu (8.12.10/8.12.10) with ESMTP id m64HpMnb020017;
	Fri, 4 Jul 2008 12:51:23 -0500 (CDT)
X-Authentication-Warning: harper.uchicago.edu: jrnieder owned process doing -bs
In-Reply-To: <g4kpmu$9ga$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87405>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---559023410-851401618-1215193882=:19792
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi J=C3=A9r=C3=B4me,

Jerome Lovy wrote:

> I don't understand the graphical scheme that gitk uses when displaying
> patches for merge commits. I would like to be able to explain this to the
> people I'm trying to evangelize to git, because they are also puzzled whe=
n
> they try to check with gitk what a merge has done to a given file.
>=20
> I can see that at least three graphical hints seem to be involved:
> - font: regular/bold
> - color: red/blue
> (maybe there are more colors when the commit has more than two parents?)
> - column for displaying the '+' or '-'

All of the information is there in the text; the color and font are just
supposed to make it easier to see.  As for the diff text itself, I
didn't remember what it meant myself, so I looked it up.

It seems the diff format shown is that produced by 'git-diff --cc',
which makes a "compact combined diff".  It only shows conflicting
changes.  Each column on the left represents the changes from a
different parent.

Hope that helps,
Jonathan
---559023410-851401618-1215193882=:19792--
