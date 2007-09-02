From: Sean <seanlkml@sympatico.ca>
Subject: Re: [ANNOUNCE] GIT 1.5.3
Date: Sun, 2 Sep 2007 13:38:03 -0400
Message-ID: <20070902133803.1b46f599.seanlkml@sympatico.ca>
References: <7vodglr32i.fsf@gitster.siamese.dyndns.org>
	<46DA5F33.2020005@zytor.com>
	<85odgltrtj.fsf@lola.goethe.zz>
	<46DA88EF.7080103@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: David Kastrup <dak@gnu.org>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, linux-kernel@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Sun Sep 02 19:38:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRtOn-00017Z-BH
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 19:38:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752194AbXIBRiI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 13:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbXIBRiI
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 13:38:08 -0400
Received: from bay0-omc1-s2.bay0.hotmail.com ([65.54.246.74]:15619 "EHLO
	bay0-omc1-s2.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750950AbXIBRiG (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Sep 2007 13:38:06 -0400
Received: from bayc1-pasmtp05.bayc1.hotmail.com ([65.54.191.165]) by bay0-omc1-s2.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 2 Sep 2007 10:38:06 -0700
X-Originating-IP: [64.231.205.174]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([64.231.205.174]) by bayc1-pasmtp05.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.2668);
	 Sun, 2 Sep 2007 10:38:05 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1 with smtp (Exim 4.43)
	id 1IRtOe-000350-9R; Sun, 02 Sep 2007 13:38:04 -0400
In-Reply-To: <46DA88EF.7080103@zytor.com>
X-Mailer: Sylpheed 2.4.2 (GTK+ 2.10.14; i686-pc-linux-gnu)
X-OriginalArrivalTime: 02 Sep 2007 17:38:05.0585 (UTC) FILETIME=[04D68010:01C7ED88]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57370>

On Sun, 02 Sep 2007 10:57:03 +0100
"H. Peter Anvin" <hpa@zytor.com> wrote:

>  From the looks of it, there is still a git-p4, it just moved to contrib 
> and uses fast-import, so removing its rpm package was probably broken in 
> the first place.

Hi Peter,

Items in contrib aren't officially supported, so it doesn't sound like
a good idea to offer installs for them.  Of course, it might be a good
idea to promote git-p4 up out of contrib and add it to the spec file.

As things stand now, do you get an error when trying to upgrade Git via
yum?   I'd have thought things would upgrade fine but leave the old git-p4
rpm hanging around.  Either way, the obsoletes line mentioned by David
sounds like the right solution.

As an aside, when I sent the patch removing git-p4import from the spec
file I mentioned that I had no way to test it and asked for testers.
Git needs a spec file maintainer so that issues like this can be caught
before release.  Without a maintainer, it should probably be demoted
to contrib itself.

Sean
