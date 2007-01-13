From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Reencode committer info to utf-8 before formatting mail header
Date: Sat, 13 Jan 2007 09:54:40 -0800
Message-ID: <7vd55ilsm7.fsf@assigned-by-dhcp.cox.net>
References: <871wm08kcu.fsf@morpheus.local>
	<7vr6tzogp4.fsf@assigned-by-dhcp.cox.net>
	<7vmz4nog5b.fsf@assigned-by-dhcp.cox.net>
	<200701131323.53121.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 13 18:55:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5n5j-0002PR-Q0
	for gcvg-git@gmane.org; Sat, 13 Jan 2007 18:54:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422739AbXAMRyn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 13 Jan 2007 12:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422738AbXAMRyn
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jan 2007 12:54:43 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:33600 "EHLO
	fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422737AbXAMRym convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Jan 2007 12:54:42 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070113175441.LAMQ19398.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>;
          Sat, 13 Jan 2007 12:54:41 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Ahux1W00X1kojtg0000000; Sat, 13 Jan 2007 12:54:58 -0500
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
In-Reply-To: <200701131323.53121.robin.rosenberg.lists@dewire.com> (Robin
	Rosenberg's message of "Sat, 13 Jan 2007 13:23:52 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36761>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> writes:

> l=F6rdag 13 januari 2007 02:43 skrev Junio C Hamano:
>> Side note.  The previous patch does not help if your commit were
>> made in non UTF-8 with not too recent git; the code assumes that
>> commit messages without the new "encoding" headers are in UTF-8.
>
> Wasn't there a repository option, "commitencoding"?  I can't see it b=
eing
> used here.

commitencoding is about what encoding the commit newly created
in this repository right now should claim to have -- in other
words what is fed to commit-tree.

We are talking about examining existing commit that might have
come from another repository or created some time ago when the
repository configuration was set differently.
