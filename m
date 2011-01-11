From: =?iso-8859-1?Q?=22Martin_Kr=FCger=22?= <martin.krueger@gmx.com>
Subject: Re: Re[2]: Merge two different repositories (v2.4 + v2.5) into the one
 (v2.4 -> v2.5). Possible?
Date: Tue, 11 Jan 2011 13:47:12 +0100
Message-ID: <20110111124712.40910@gmx.net>
References: <746745466.20110111134101@mail.ru> <20110111114943.40890@gmx.net>
 <76067992.20110111153329@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: =?iso-8859-1?B?ItCQ0LvQtdC60YHQtdC5INCo0YPQvNC60LjQvSI=?= 
	<zapped@mail.ru>
X-From: git-owner@vger.kernel.org Tue Jan 11 13:47:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcddA-0004pl-2s
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 13:47:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133Ab1AKMrS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 07:47:18 -0500
Received: from mailout-de.gmx.net ([213.165.64.22]:46214 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1756029Ab1AKMrO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 07:47:14 -0500
Received: (qmail 8801 invoked by uid 0); 11 Jan 2011 12:47:12 -0000
Received: from 213.39.246.106 by www049.gmx.net with HTTP;
 Tue, 11 Jan 2011 13:47:12 +0100 (CET)
In-Reply-To: <76067992.20110111153329@mail.ru>
X-Authenticated: #34047341
X-Flags: 0001
X-Mailer: WWW-Mail 6100 (Global Message Exchange)
X-Priority: 3
X-Provags-ID: V01U2FsdGVkX18gT1IIb2Ugd8FWtTani/RbXT8MNzNODpHSngJoRJ
 dR1Aa6M3PLYQa0q2BLAMswoFUeDEz4WShD4A== 
X-GMX-UID: NDhJDJV7fW47QlffcGdoFTludmllcoXY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164937>


> Thank you for the answer, but it's not what I want ))
> Applying patches is the same as rebasing, I guess.
> But I do not want to change v2.5-repo (let's call it so) that much.
> I'd like to know is there any method (low-level I suppose, as far as Git
> manages tree-objects as files) to make v2.4 LAST commit to be the
> parent of v2.5 FIRST commit?
> 
This is impossible.
The commit-id is calculated from the history of the whole repository.
So you  must rebase in the sense of dependency on another history. 
My  method  enables to rebase on the same content of the repository.
