From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: An interaction with ce_match_stat_basic() and autocrlf
Date: Tue, 8 Jan 2008 09:30:40 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801080927370.3148@woody.linux-foundation.org>
References: <7vfxx8tt1z.fsf@gitster.siamese.dyndns.org> <fm0au5$i65$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?P=C4=93teris_K=C4=BCavi=C5=86=C5=A1?= 
	<klavins@netspace.net.au>
X-From: git-owner@vger.kernel.org Tue Jan 08 18:31:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCIIt-0004cm-Pf
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 18:31:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756401AbYAHRb2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jan 2008 12:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756211AbYAHRb1
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 12:31:27 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:59015 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752546AbYAHRb0 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Jan 2008 12:31:26 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m08HUfac020914
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 8 Jan 2008 09:30:46 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m08HUeVE022838;
	Tue, 8 Jan 2008 09:30:40 -0800
In-Reply-To: <fm0au5$i65$1@ger.gmane.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.223 required=5 tests=AWL,BAYES_00,OSDL_HIGH_ASCII_4
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69897>



On Tue, 8 Jan 2008, P=C4=93teris K=C4=BCavi=C5=86=C5=A1 wrote:
>=20
> In summary, it irks me that autocrlf true mode is a second cousin of =
autocrlf
> false and I think that there *should* be an acceptable deterministic =
solution
> to this.

Well, I think the real issue is simply that most the main git developer=
s=20
do development on architectures where CRLF just isn't an issue.

So it's not that autocrlf is a "second cousin", it's that

 - CRLF is stupid to begin with, and slightly anathemical to the git=20
   worldview of trying to be as exact as possible.

 - ..and almost nobody in the git community is actually affected, so=20
   people don't even notice when it's an issue.

People who actually care and use crlf are probably best off sending in=20
test-cases for particular behaviour they notice.=20

		Linus
