From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: current git kernel has strange problems during bisect
Date: Mon, 12 Jan 2009 06:03:03 +0100
Message-ID: <200901120603.03977.chriscool@tuxfamily.org>
References: <200901111602.53082.borntraeger@de.ibm.com> <20090111230240.GA27489@artemis.corp> <200901120551.56791.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Pierre Habouzit <madcoder@debian.org>,
	Alexey Zaytsev <alexey.zaytsev@gmail.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
X-From: git-owner@vger.kernel.org Mon Jan 12 06:03:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMExq-00029Y-Qr
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 06:03:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbZALFC0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 00:02:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbZALFC0
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 00:02:26 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:43346 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750695AbZALFCZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 00:02:25 -0500
X-Greylist: delayed 665 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Jan 2009 00:02:24 EST
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 79E39818049;
	Mon, 12 Jan 2009 06:02:13 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 928A281806B;
	Mon, 12 Jan 2009 06:02:11 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <200901120551.56791.chriscool@tuxfamily.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105290>

I wrote:
>
> Anyway it looks to me that this kind of problem could be avoided if one
> could "replace" some commits only when bisecting. In this case what could
> be done is that one could "replace" the commit where btrfs is merged with
> one commit that cuts off the btrfs history.

By the way, it possible right now to cut off the btrfs history in one's own 
repository using a graft. One don't need to wait for me to finish the 
replace stuff I am slowly working on. But on the other hand it will have 
all the restrictions of the current graft mechanism.

Regards,
Christian.
