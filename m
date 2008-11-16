From: Mark Burton <markb@ordern.com>
Subject: Re: [PATCH] gitk: Highlight found text only for when search type is
 "containing".
Date: Sun, 16 Nov 2008 00:05:53 +0000
Organization: Order N Ltd.
Message-ID: <20081116000553.3d04b513@crow>
References: <1226790769-25019-1-git-send-email-markb@ordern.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 16 01:12:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1VFO-0005mb-Rh
	for gcvg-git-2@gmane.org; Sun, 16 Nov 2008 01:12:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752874AbYKPALA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2008 19:11:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752214AbYKPAK7
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Nov 2008 19:10:59 -0500
Received: from c2bthomr06.btconnect.com ([213.123.20.124]:23225 "EHLO
	c2bthomr06.btconnect.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751420AbYKPAK7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Nov 2008 19:10:59 -0500
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Sat, 15 Nov 2008 19:10:58 EST
Received: from crow.ordern.com (host86-128-20-200.range86-128.btcentralplus.com [86.128.20.200])
	by c2bthomr06.btconnect.com
	with ESMTP id CCO24187;
	Sun, 16 Nov 2008 00:05:53 GMT
Received: from crow (localhost [127.0.0.1])
	by crow.ordern.com (Postfix) with ESMTP id 8B83B190CA9
	for <git@vger.kernel.org>; Sun, 16 Nov 2008 00:05:53 +0000 (GMT)
In-Reply-To: <1226790769-25019-1-git-send-email-markb@ordern.com>
X-Mailer: Claws Mail 3.6.1 (GTK+ 2.12.9; x86_64-pc-linux-gnu)
X-Junkmail-Status: score=10/50, host=c2bthomr06.btconnect.com
X-Junkmail-SD-Raw: score=unknown,
	refid=str=0001.0A0B0201.491F63E2.013C,ss=1,fgs=0,
	ip=86.128.20.200,
	so=2007-10-30 19:00:17,
	dmn=5.7.1/2008-09-02
X-Junkmail-IWF: false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101102>


Hi,

The patch got sent without this blurb (not really sure how to send
patches to the list with leading blurb).

Anyway, I thought I would try and stop gitk from always highlighting
the text in the commit and comment panes that matches the text in the
search field. To me, it only makes sense to highlight the text when the
search type is "containing". For the other search types (definitely
for the touching paths type), I don't really see how having occurrences
of the search text highlighted helps.

I don't really understand how gitk operates but the patch does what I
want. I'm sure those in the know can improve on it if what it does is
useful.

Cheers,

Mark
