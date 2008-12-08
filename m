From: "Ren LingYan-E5949C" <E5949C@motorola.com>
Subject: How to config git-daemon?
Date: Mon, 8 Dec 2008 14:27:39 +0800
Message-ID: <D13CA5792E8D5140A50EEDB89972CDCB053E21AA@zmy16exm63.ds.mot.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Dec 08 07:29:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9Zc5-0004wB-OW
	for gcvg-git-2@gmane.org; Mon, 08 Dec 2008 07:29:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752495AbYLHG1p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2008 01:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752135AbYLHG1p
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Dec 2008 01:27:45 -0500
Received: from mail119.messagelabs.com ([216.82.241.195]:43038 "HELO
	mail119.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751461AbYLHG1o convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Dec 2008 01:27:44 -0500
X-VirusChecked: Checked
X-Env-Sender: E5949C@motorola.com
X-Msg-Ref: server-8.tower-119.messagelabs.com!1228717663!32115807!1
X-StarScan-Version: 5.5.12.14.2; banners=-,-,-
X-Originating-IP: [136.182.1.12]
Received: (qmail 30982 invoked from network); 8 Dec 2008 06:27:43 -0000
Received: from unknown (HELO motgate2.mot.com) (136.182.1.12)
  by server-8.tower-119.messagelabs.com with SMTP; 8 Dec 2008 06:27:43 -0000
Received: from il27exr02.cig.mot.com (il27exr02.mot.com [10.17.196.71])
	by motgate2.mot.com (8.12.11/Motorola) with ESMTP id mB86RhFs029861
	for <git@vger.kernel.org>; Sun, 7 Dec 2008 23:27:43 -0700 (MST)
Received: from il27vts02.mot.com (il27vts02.cig.mot.com [10.17.196.86])
	by il27exr02.cig.mot.com (8.13.1/Vontu) with SMTP id mB86RgvV015644
	for <git@vger.kernel.org>; Mon, 8 Dec 2008 00:27:42 -0600 (CST)
Received: from zmy16exm63.ds.mot.com (zmy16exm63.ap.mot.com [10.179.4.34])
	by il27exr02.cig.mot.com (8.13.1/8.13.0) with ESMTP id mB86Rf61015623
	for <git@vger.kernel.org>; Mon, 8 Dec 2008 00:27:42 -0600 (CST)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: How to config git-daemon?
thread-index: AclY+oYsciOdQQ3YQ2KaJCjLwo2w2AAADwQgAADQqWA=
X-CFilter-Loop: Reflected
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102530>

Hello,
 
I want to public my repository testproject, which can be accessed by git
protocol. 
 
My steps are as below:
 
On Server machine (for example 10.194.66.71) 1. Created testproject
under /home/e5949c/repositories 2. Created a file "git-daemon-export-ok"
under testproject/ .git directory.
3. Run command "git daemon --verbose --export-all"
 
On test machine
1. Run command "git clone
git://10.194.66.71/home/e5949c/repositories/testproject.git". Error as
below :
 
Initialized empty Git repository in
/export/home/e5949c/repositories/test/testproject/.git/
fatal: The remote end hung up unexpectedly
 
Can anyone help me on this error? What did I miss ? 

Your help will be highly appreciated !
 
Thanks,
Emily 
