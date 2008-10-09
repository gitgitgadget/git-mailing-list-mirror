From: "Balasubramaniam, Arunan" <Arunan.Balasubramaniam@misys.com>
Subject: Implementing commit signing
Date: Thu, 9 Oct 2008 15:03:10 +0100
Message-ID: <E74D836C8B2CEF4A89F47E8ACECEEF9B748C75@maildub1.misys.global.ad>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 09 16:57:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnwvK-0003EE-EL
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 16:55:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753472AbYJIOyT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 10:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753336AbYJIOyT
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 10:54:19 -0400
Received: from cluster-a.mailcontrol.com ([80.69.8.190]:54538 "EHLO
	cluster-a.mailcontrol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753393AbYJIOyS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Oct 2008 10:54:18 -0400
X-Greylist: delayed 3042 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Oct 2008 10:54:18 EDT
Received: from MailDub1.misys.global.ad ([193.120.150.89])
	by rly21a.srv.mailcontrol.com (MailControl) with SMTP id m99E39LJ028413
	for <git@vger.kernel.org>; Thu, 9 Oct 2008 15:03:33 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Implementing commit signing
Thread-Index: AckqF8L5UViGlOztSC6+CcqWaBeYVg==
X-Scanned-By: MailControl A-08-50-15 (www.mailcontrol.com) on 10.65.0.131
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97856>


Hello,

I am looking at using Git within our organisation, and verifying the
source of
commits has been raised as a concern. GPG signing individual commits has
been
discussed at least once on this list [1]. I got the impression from that
thread
that if a patch to implement it were submitted then it would probably
get
accepted. I have a few questions:

  1) Is that actually the case at present? I ask to avoid doing the work
and
     having it rejected.

  2) If it were accepted into Git, would an equivalent patch be accepted
into
     jgit? Would patches for UI to use it be accepted into egit?

I can not promise that we will actually write this patch as I am going
to
present it internally as one option and using hooks scripts as another,
but it
would be more likely to happen if there were positive answers to those
questions. 

Thanks,
Arunan Bala

[1] http://kerneltrap.org/mailarchive/git/2007/1/15/235839/thread


"Misys" is the trade name for Misys plc (registered in England and Wales). Registration Number: 01360027. Registered office: One Kingdom Street, London W2 6BL, United Kingdom. For a list of Misys group operating companies please go to http://www.misys.com/html/about_us/group_operating_companies/. This email and any attachments have been scanned for known viruses using multiple scanners. This email message is intended for the named recipient only. It may be privileged and/or confidential. If you are not the named recipient of this email please notify us immediately and do not copy it or use it for any purpose, nor disclose its contents to any other person. This email does not constitute the commencement of legal relations between you and Misys plc. Please refer to the executed contract betw
 een you and the relevant member of the Misys group for the identity of the contracting party with which you are dealing. 
