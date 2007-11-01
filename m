From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: Importing svn branch
Date: Thu, 1 Nov 2007 12:23:16 -0500 (EST)
Message-ID: <BAYC1-PASMTP1474D8094F6C5F2CCF2B6CAE8C0@CEZ.ICE>
References: <4729F58C.3090706@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: "LCID Fire" <lcid-fire@gmx.net>
X-From: git-owner@vger.kernel.org Thu Nov 01 18:23:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IndlZ-0006qd-5z
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 18:23:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752770AbXKARXX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 13:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752524AbXKARXX
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 13:23:23 -0400
Received: from bay0-omc2-s36.bay0.hotmail.com ([65.54.246.172]:16042 "EHLO
	bay0-omc2-s36.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752451AbXKARXW (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Nov 2007 13:23:22 -0400
Received: from BAYC1-PASMTP14 ([65.54.191.187]) by bay0-omc2-s36.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 1 Nov 2007 10:23:21 -0700
X-Originating-IP: [74.15.76.104]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([74.15.76.104]) by BAYC1-PASMTP14.CEZ.ICE over TLS secured channel with Microsoft SMTPSVC(6.0.3790.2668);
	 Thu, 1 Nov 2007 10:26:19 -0700
Received: from apache by linux1.attic.local with local (Exim 4.43)
	id 1IndlE-0000Qp-Fq; Thu, 01 Nov 2007 12:23:16 -0500
Received: from 10.10.10.29
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Thu, 1 Nov 2007 12:23:16 -0500 (EST)
In-Reply-To: <4729F58C.3090706@gmx.net>
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 01 Nov 2007 17:26:19.0500 (UTC) FILETIME=[50C37AC0:01C81CAC]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62981>

On Thu, November 1, 2007 10:49 am, LCID Fire said:
> Could anyone give me an example how to import this branch:
> svn.gnome.org/svn/banshee/branches/banshee/stable
>
> I tried git-svnimport -v -T banshee/stable/ -o master
> http://svn.gnome.org/svn/banshee
> and he imports a lot - but not the branch I want. Seems like I'm missing
> something :(

On Thu, November 1, 2007 10:49 am, LCID Fire said:
> Could anyone give me an example how to import this branch:
> svn.gnome.org/svn/banshee/branches/banshee/stable
>
> I tried git-svnimport -v -T banshee/stable/ -o master
> http://svn.gnome.org/svn/banshee
> and he imports a lot - but not the branch I want. Seems like I'm missing
> something :(
>
>

git-svnimport should probably be officially deprecated; you're not the
first person to struggle with it.  Fortunately there's another option
provided with Git which will likely give you what you're looking for:

   git svn clone http://svn.gnome.org/svn/banshee/branches/banshee/stable

Good luck,
Sean
