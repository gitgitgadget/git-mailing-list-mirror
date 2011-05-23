From: Tim Mazid <timmazid@hotmail.com>
Subject: RE: git branch
Date: Mon, 23 May 2011 22:36:28 +1000
Message-ID: <SNT124-W21FCFAE653C2B81DD980BFC4720@phx.gbl>
References: <BANLkTinzped82Njnw4ZUeHY6Qu4R4hKK-w@mail.gmail.com>,<20110523114633.GE7387@kennedy.acc.umu.se>,<BANLkTim_L0M2oFV383+5n7-X_KQTdd3BAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: <gbuday@gmail.com>, <mk@acc.umu.se>
X-From: git-owner@vger.kernel.org Mon May 23 14:36:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOUN8-0006rN-H4
	for gcvg-git-2@lo.gmane.org; Mon, 23 May 2011 14:36:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753859Ab1EWMg3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2011 08:36:29 -0400
Received: from snt0-omc1-s13.snt0.hotmail.com ([65.55.90.24]:44240 "EHLO
	snt0-omc1-s13.snt0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753007Ab1EWMg3 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2011 08:36:29 -0400
Received: from SNT124-W21 ([65.55.90.7]) by snt0-omc1-s13.snt0.hotmail.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Mon, 23 May 2011 05:36:28 -0700
X-Originating-IP: [114.77.220.50]
Importance: Normal
In-Reply-To: <BANLkTim_L0M2oFV383+5n7-X_KQTdd3BAg@mail.gmail.com>
X-OriginalArrivalTime: 23 May 2011 12:36:28.0867 (UTC) FILETIME=[09BCB930:01CC1946]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174241>


> From: gbuday@gmail.com
>
> > I'm not sure if I'm following you correctly, but with Git you need to
> > check out your branch after creating it. Run git checkout install_2.0
> > after you have created it.
>
> Yes, that sounds reasonable. I did not know it was necessary to "switch to it".
>
> - Gergely


Hi Gergely,

The way that git branches work is that they "point" at commits.
When you do a "git commit", git updates the branch to point at
the new commit you just created. In this way, you can have a
multitude of branches and be working on only one at a time.

N.B. If you want to create a branch and "switch" (checkout) to
it at once, you can pass the "-b" option to checkout, thus:
"git checkout -b new-branch-name"; this will create a new branch
named "new-branch-name" and immediately switch to it.


Tim.

() ascii ribbon campaign - against html e-mail
/\ www.asciiribbon.org - against proprietary attachments
 		 	   		  