From: Don Slutz <Don.Slutz@SierraAtlantic.com>
Subject: Re: Tests in Cygwin
Date: Wed, 06 May 2009 15:34:36 -0400
Message-ID: <4A01E64C.7050703@SierraAtlantic.com>
References: <83prfbhasp.fsf@kalahari.s2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Hannu Koivisto <azure@iki.fi>
X-From: git-owner@vger.kernel.org Wed May 06 21:35:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1mtL-0004n3-HH
	for gcvg-git-2@gmane.org; Wed, 06 May 2009 21:34:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754685AbZEFTer (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 15:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754459AbZEFTer
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 15:34:47 -0400
Received: from mail51.messagelabs.com ([216.82.241.99]:63006 "HELO
	mail51.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752999AbZEFTeq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2009 15:34:46 -0400
X-VirusChecked: Checked
X-Env-Sender: Don.Slutz@SierraAtlantic.com
X-Msg-Ref: server-3.tower-51.messagelabs.com!1241638485!32600836!2
X-StarScan-Version: 6.0.0; banners=sierraatlantic.com,-,-
X-Originating-IP: [206.86.29.5]
Received: (qmail 31174 invoked from network); 6 May 2009 19:34:47 -0000
Received: from seng.sierraatl.com (HELO USFREEX1.us.corp.sa) (206.86.29.5)
  by server-3.tower-51.messagelabs.com with SMTP; 6 May 2009 19:34:47 -0000
Received: from usbosex1.us.corp.sa ([192.168.17.34]) by USFREEX1.us.corp.sa with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 6 May 2009 12:34:41 -0700
Received: from [127.0.0.1] ([208.37.241.146]) by usbosex1.us.corp.sa with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 6 May 2009 15:34:39 -0400
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <83prfbhasp.fsf@kalahari.s2.org>
X-OriginalArrivalTime: 06 May 2009 19:34:39.0535 (UTC) FILETIME=[B25D93F0:01C9CE81]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118375>

A lot of these failures are do to running as root (member of 
Administrators).  Using v1.6.3-rc4 (503f464...) I get:

make -i test
...
make aggregate-results
make[3]: Entering directory `/home/udslutz/BinMode/git/t'
'/bin/sh' ./aggregate-results.sh test-results/t*-*
fixed   3
success 4211
failed  5
broken  5
total   4272
make[3]: Leaving directory `/home/udslutz/BinMode/git/t'
...

  -Don Slutz



-------- Original Message --------
Subject: Tests in Cygwin
From: Hannu Koivisto <azure@iki.fi>
To: git@vger.kernel.org
Date: 4/17/2009 5:47 AM
> Greetings,
>
> I upgraded to the latest git.git as of yesterday
> (f800b65bea1504299747e7be03ee279508a74e1f) in Cygwin to see if it
> still has the rebase and bogus modified files problem(s) (reported
> earlier http://osdir.com/ml/git/2009-04/msg00619.html).  It does;
> I'll try to bisect it if I manage to make the test case automatic.
>
> I also thought I'd run all the tests just for the heck of it.  The
> result is about 240 failures which are available here (lines
> indicating passed tests removed):
>
> http://www.iki.fi/azure/tmp/git-test-results-cygwin-f800b65bea1504299747e7be03ee279508a74e1f.txt
>
> I wonder, since there seems to be some sort of mechanism to mark
> failures "known" (at least I got a couple of "still broken ..."
> lines), are all these unexpected, new problems, or is there perhaps
> some separate list of known failures on Cygwin?
>
>   



__________________________________________________________________________________________________________________
DISCLAIMER:"The information contained in this message and the attachments (if any) may be privileged and confidential and protected from disclosure. You are hereby notified that any unauthorized use, dissemination, distribution or copying of this communication, review, retransmission, or taking of any action based upon this information, by persons or entities other than the intended recipient, is strictly prohibited. If you are not the intended recipient or an employee or agent responsible for delivering this message, and have received this communication in error, please notify us immediately by replying to the message and kindly delete the original message, attachments, if any, and all its copies from your computer system. Thank you for your cooperation." 
________________________________________________________________________________________________________________
