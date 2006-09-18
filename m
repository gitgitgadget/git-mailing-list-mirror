From: Paul Jakma <paul@clubi.ie>
Subject: Re: git and Solaris 8
Date: Mon, 18 Sep 2006 15:05:45 +0100 (IST)
Message-ID: <Pine.LNX.4.64.0609181452140.12833@sheen.jakma.org>
References: <20060918134100.GL1221MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Peter Eriksen <s022018@student.dtu.dk>,
	Junio C Hamano <junkio@cox.net>,
	Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 18 16:08:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPJmz-00034i-0J
	for gcvg-git@gmane.org; Mon, 18 Sep 2006 16:08:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965245AbWIROHj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Sep 2006 10:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965246AbWIROHj
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Sep 2006 10:07:39 -0400
Received: from hibernia.jakma.org ([212.17.55.49]:58773 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S965245AbWIROHi
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Sep 2006 10:07:38 -0400
Received: from sheen.jakma.org (IDENT:U2FsdGVkX19n/pUxlxpknlw6BAo65v1B1z8sUGioQfc@sheen.jakma.org [212.17.55.53])
	(authenticated bits=0)
	by hibernia.jakma.org (8.13.7/8.13.6) with ESMTP id k8IE5jAW023584
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 18 Sep 2006 15:05:58 +0100
X-X-Sender: paul@sheen.jakma.org
To: skimo@liacs.nl
In-Reply-To: <20060918134100.GL1221MdfPADPa@greensroom.kotnet.org>
Mail-Copies-To: paul@jakma.org
Mail-Followup-To: paul@jakma.org
X-NSA: al aqsar fluffy jihad cute musharef kittens jet-A1 ear avgas wax ammonium bad qran dog inshallah allah al-akbar martyr iraq hammas hisballah rabin ayatollah korea revolt pelvix mustard gas x-ray british airways washington peroxide cool
X-Virus-Scanned: ClamAV 0.88.3/1891/Sun Sep 17 22:16:53 2006 on hibernia.jakma.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27247>

On Mon, 18 Sep 2006, Sven Verdoolaege wrote:

> All I know is that I have a Solaris *8* machine here and that I 
> _don't_ need NEEDS_LIBICONV.  There is no -liconv on this machine. 
> (I'm CC'ing Uwe, because he apparently also has access to a Solaris 
> 8 machine).

I tested on S10, SNV (probably somewhere around SNV_14, can't quite 
remember) and S9 (whichever the latest update was). None need 
-liconv, it's a build error on S10 (which was the one I cared about).

I can dig into the Iconv situation further later in the week, or 
next. I am away from home at moment.

> So is the current setting correct on some versions of Solaris 8 and 
> if so, is there some way to change this setting from the command 
> line ?

I couldn't find an S8 machine to test on, so I left S8 alone - 
existing behaviour, I had no basis to judge it incorrect. S8 is 
/really/ old now btw. ;)

> Btw, like Uwe, I also don't have a "gtar" and "ginstall" on this machine.

S10, maybe S9 too (not sure), install these to /usr/sfw/bin, if you 
installed everything.

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
Interference from lunar radiation
