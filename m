From: Wincent Colaiuta <win@wincent.com>
Subject: Re: Stashing untracked files
Date: Sun, 30 Sep 2007 15:18:17 +0200
Message-ID: <115E3AB7-BE23-472B-9321-641901054A6A@wincent.com>
References: <46FE9924.7080006@theory.org> <Pine.LNX.4.64.0709292201400.28395@racer.site> <EEE8F630-AE62-4425-96A0-239D54724DF4@lrde.epita.fr> <46FEC799.30803@theory.org> <Pine.LNX.4.64.0709292259070.28395@racer.site> <46FF1F1E.2050000@theory.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Neil Macneale <mac4-git@theory.org>
X-From: git-owner@vger.kernel.org Sun Sep 30 15:18:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ibygz-0000tP-U1
	for gcvg-git-2@gmane.org; Sun, 30 Sep 2007 15:18:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755118AbXI3NSb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Sep 2007 09:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755216AbXI3NSb
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Sep 2007 09:18:31 -0400
Received: from wincent.com ([72.3.236.74]:37407 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755030AbXI3NSa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Sep 2007 09:18:30 -0400
Received: from [192.168.0.129] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l8UDIOjE029516;
	Sun, 30 Sep 2007 08:18:26 -0500
In-Reply-To: <46FF1F1E.2050000@theory.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59539>

El 30/9/2007, a las 5:59, Neil Macneale escribi=F3:

> $ git stash -u   # stash everything, even untracked files. I never
>                  # suggesting modifying the default behavior.

Provided it's not the default behaviour, and provided that it doesn't =20
add ignored files, this sounds perfectly reasonable and potentially =20
quite useful.

I say *potentially* only because I've yet to find a situation wherein =20
I can't just do the following:

<hack>                # lots of untracked files floating around
$ git stash           # untracked files stay exactly where they were
<orthogonal hacking>  # untracked files still there
$ git stash apply     # still there...
<hack>                # still there...

If the content of the untracked files is both, (a) important and (b) =20
being modified over time, then perhaps it should be being tracked.

Wincent
