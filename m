From: "Zorba" <cr@altmore.co.uk>
Subject: Re: for newbs = little exercise / tutorial / warmup for windows and other non-sophisticated new Git users :-)
Date: Tue, 30 Dec 2008 17:44:20 -0000
Message-ID: <gjdmm6$9oj$4@ger.gmane.org>
References: <gj68a0$u56$3@ger.gmane.org> <gj6kqq$nvh$4@ger.gmane.org> <3ab397d0812291505v77824e6fvdecebc80f38a5f89@mail.gmail.com> <gjdh0r$n3c$4@ger.gmane.org> <gjdlcl$5no$4@ger.gmane.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 30 18:46:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHifU-0000kk-5w
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 18:46:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752007AbYL3Rov (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 12:44:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751813AbYL3Rou
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 12:44:50 -0500
Received: from main.gmane.org ([80.91.229.2]:51338 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751446AbYL3Rou (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2008 12:44:50 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LHie7-0003to-R3
	for git@vger.kernel.org; Tue, 30 Dec 2008 17:44:47 +0000
Received: from 81.135.227.136 ([81.135.227.136])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 30 Dec 2008 17:44:47 +0000
Received: from cr by 81.135.227.136 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 30 Dec 2008 17:44:47 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 81.135.227.136
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5512
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5512
X-RFC2646: Format=Flowed; Response
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
X-Spam-Report: 5.2 points;
 *  0.0 RCVD_BY_IP Received by mail server with no name
 *  4.0 RCVD_NUMERIC_HELO Received: contains an IP address used for HELO
 *  1.2 PRIORITY_NO_NAME Message has priority, but no X-Mailer/User-Agent
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104196>

So I deleted the repo and the working tree, restarted the git bash (i.e. 
wiped the slate clean) and started my little warm up workflow again, getting 
as far as just created and tagged versionD.

So lets do some checking out

$ rm *.*
$ git checkout versionA .

gives ABC.txt, AC.txt = correct
however...

$ rm *.*
$ git checkout versionB .

gives ABC.txt, AC.txt, BC.txt
which is wrong

running gitk confirms that AC.txt should not be in versionB

!!!! 
