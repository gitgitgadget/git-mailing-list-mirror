From: "Zorba" <cr@altmore.co.uk>
Subject: turn off "LF will be replaced by CRLF" thingy
Date: Mon, 29 Dec 2008 15:38:04 -0000
Message-ID: <gjaqta$tg7$4@ger.gmane.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 29 16:40:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHKDh-0000YZ-8p
	for gcvg-git-2@gmane.org; Mon, 29 Dec 2008 16:39:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581AbYL2Pi2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2008 10:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbYL2Pi2
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 10:38:28 -0500
Received: from main.gmane.org ([80.91.229.2]:42351 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751509AbYL2Pi1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2008 10:38:27 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LHKCH-0006Kl-UF
	for git@vger.kernel.org; Mon, 29 Dec 2008 15:38:26 +0000
Received: from 81.135.227.136 ([81.135.227.136])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 29 Dec 2008 15:38:25 +0000
Received: from cr by 81.135.227.136 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 29 Dec 2008 15:38:25 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 81.135.227.136
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5512
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5512
X-RFC2646: Format=Flowed; Original
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
X-Spam-Report: 5.2 points;
 *  0.0 RCVD_BY_IP Received by mail server with no name
 *  4.0 RCVD_NUMERIC_HELO Received: contains an IP address used for HELO
 *  1.2 PRIORITY_NO_NAME Message has priority, but no X-Mailer/User-Agent
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104104>

Dear All,

I was just in the process of creating our first live version on git (5k+ 
files), when I noticed this in the output of

$ git add .

being "Warning: LF will be replaced by CRLF in <filename>"
about 500 times !!

I'd rather not let git change any files, many of which are PHP that run on 
Apache
I think I remember reading that this is a config option that gets swithced 
on by default on windows (which we are running git on)

how do I switch it off ?

thanks 
