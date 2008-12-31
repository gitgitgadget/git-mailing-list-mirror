From: "Conor Rafferty" <conor.rafferty@altmore.co.uk>
Subject: RE: for newbs = little exercise / tutorial / warmup for windows and other non-sophisticated new Git users :-) [Scanned]
Date: Wed, 31 Dec 2008 11:10:08 -0000
Message-ID: <BB5F02FD3789B54E8964D38D6775E718242D38@ALTMORE-SVR.altmore.local>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "Jeff Whiteside" <jeff.m.whiteside@gmail.com>,
	"Daniel Barkalow" <barkalow@iabervon.org>, <git@vger.kernel.org>
To: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
X-From: git-owner@vger.kernel.org Wed Dec 31 12:11:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHyzD-0005Ow-Jd
	for gcvg-git-2@gmane.org; Wed, 31 Dec 2008 12:11:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755382AbYLaLKR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Dec 2008 06:10:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752963AbYLaLKR
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Dec 2008 06:10:17 -0500
Received: from sbs.altmore.co.uk ([217.39.150.193]:39445 "HELO
	sbs.altmore.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752832AbYLaLKQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 Dec 2008 06:10:16 -0500
X-PMWin-Version: 3.0.0.0, Antivirus-Engine: 2.82.1, Antivirus-Data: 4.37E
Content-Class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4133
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: for newbs = little exercise / tutorial / warmup for windows and other non-sophisticated new Git users :-) [Scanned]
thread-index: Aclq81TL04C822G0RBWljQlCzOm/jAARKVVA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104267>


And you would be wrong, IMHO.  Many people have untracked files or
directories in their working directory ('cause they are working there)
that they don't want deleted willy-nilly.  Build files, modifications
that should be on a different branch, etc.  There's another thread
active on the list complaining that git removes too much from the
working tree.

** An SCM should be able to cope with both use cases. In fact I make it
easy for the SCM by deleting EVERYTHING from the working directory,
before calling git-checkout.

Most users of SCMs do make active modifications to the files in the SCM.
It's not a system only for archiving static projects.

** Archiving static projects is not the ONLY thing I want to do with my
SCM, it just happens to be the FIRST thing.
