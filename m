From: Sean <seanlkml@sympatico.ca>
Subject: Re: Samba NTFS error "Could not rename the lock file?"
Date: Tue, 15 Jan 2008 23:32:59 -0500
Message-ID: <BAYC1-PASMTP13F08E2183200D4BDF089FAE400@CEZ.ICE>
References: <478D765B.90905@talkingspider.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Mike <fromlists@talkingspider.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 05:33:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEzy1-0005X4-KB
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 05:33:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753175AbYAPEdG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 23:33:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753229AbYAPEdF
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 23:33:05 -0500
Received: from bay0-omc2-s32.bay0.hotmail.com ([65.54.246.168]:5009 "EHLO
	bay0-omc2-s32.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753065AbYAPEdE (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jan 2008 23:33:04 -0500
Received: from BAYC1-PASMTP13 ([65.54.191.186]) by bay0-omc2-s32.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 15 Jan 2008 20:33:02 -0800
X-Originating-IP: [74.15.76.104]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([74.15.76.104]) by BAYC1-PASMTP13.CEZ.ICE over TLS secured channel with Microsoft SMTPSVC(6.0.3790.2668);
	 Tue, 15 Jan 2008 20:33:02 -0800
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with smtp (Exim 4.43)
	id 1JEzxM-0002bb-Hk; Tue, 15 Jan 2008 23:32:52 -0500
In-Reply-To: <478D765B.90905@talkingspider.com>
X-Mailer: Sylpheed 2.4.7 (GTK+ 2.12.5; i686-pc-linux-gnu)
X-OriginalArrivalTime: 16 Jan 2008 04:33:02.0623 (UTC) FILETIME=[E176E2F0:01C857F8]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70628>

On Tue, 15 Jan 2008 22:13:31 -0500
Mike <fromlists@talkingspider.com> wrote:

> git version 1.5.2.1
> 
> I have my repository on a linux server and I'm trying to create a "git 
> clone" on an NTFS samba mount. So for example:

Mike,

You may be running into an issue due to filename case insensitivity when
using NTFS over Samba.  Either way, it would be helpful if you could test
with the latest stable Git (v1.5.3.8) since the error you're hitting has
been removed and the code replaced with different logic.

Sean.
