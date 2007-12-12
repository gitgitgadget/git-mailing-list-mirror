From: Wincent Colaiuta <win@wincent.com>
Subject: [RFC PATCH 0/2] diff whitespace tweaks
Date: Wed, 12 Dec 2007 09:12:00 +0100
Message-ID: <1197447122-93416-1-git-send-email-win@wincent.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 12 09:13:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2MiZ-0004FF-AD
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 09:13:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754470AbXLLINB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 03:13:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754252AbXLLINB
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 03:13:01 -0500
Received: from wincent.com ([72.3.236.74]:43605 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753445AbXLLINA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 03:13:00 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lBC8C5bh014818;
	Wed, 12 Dec 2007 02:12:06 -0600
X-Mailer: git-send-email 1.5.3.7.1116.gf11de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68010>

[1/2] Use "whitespace" consistently

This one is a simple consistency fix that should go on top of "master".

[2/2] "diff --check" should affect exit status

This one is why I put "RFC" in the subject line. Basically, when I
discovered that "diff --check" didn't affect the exit status of the
command I thought it might be a bug, in which case this fix or one like
it should go in for 1.5.4. This patch also applies on top of "master".

But if you don't consider that to be a bug then I guess it's "next"
or even "pu" material and I can bring it back up after 1.5.4 is out.

Another reason why I label this as "RFC" is that the diff machinery
is fairly bulky and I was not familiar with it. So this patch is the
result of someone who has looked at the source for half an hour and
deduced enough to implement the desired behaviour; but somone who
truly groks the diff code may be able to think of a nicer
implementation.
