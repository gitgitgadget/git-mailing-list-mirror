From: "LIU JIN-YU-KFQP84" <simon.liu@motorola.com>
Subject: RE: How to config git-daemon?
Date: Mon, 8 Dec 2008 15:36:40 +0800
Message-ID: <DFC883208F3ED446B46EEE1DBD54BA950633D137@zmy16exm62.ds.mot.com>
References: <D13CA5792E8D5140A50EEDB89972CDCB053E21AA@zmy16exm63.ds.mot.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
To: "Ren LingYan-E5949C" <E5949C@motorola.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Dec 08 08:38:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9agp-0005Ip-0o
	for gcvg-git-2@gmane.org; Mon, 08 Dec 2008 08:37:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbYLHHgm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2008 02:36:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbYLHHgm
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Dec 2008 02:36:42 -0500
Received: from mail153.messagelabs.com ([216.82.253.51]:44216 "HELO
	mail153.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751098AbYLHHgl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Dec 2008 02:36:41 -0500
X-VirusChecked: Checked
X-Env-Sender: simon.liu@motorola.com
X-Msg-Ref: server-2.tower-153.messagelabs.com!1228721800!16774162!1
X-StarScan-Version: 5.5.12.14.2; banners=-,-,-
X-Originating-IP: [136.182.1.14]
Received: (qmail 25240 invoked from network); 8 Dec 2008 07:36:40 -0000
Received: from unknown (HELO motgate4.mot.com) (136.182.1.14)
  by server-2.tower-153.messagelabs.com with SMTP; 8 Dec 2008 07:36:40 -0000
Received: from il27exr03.cig.mot.com (il27exr03.mot.com [10.17.196.72])
	by motgate4.mot.com (8.12.11/Motorola) with ESMTP id mB87aeN9016639
	for <git@vger.kernel.org>; Mon, 8 Dec 2008 00:36:40 -0700 (MST)
Received: from il27vts02.mot.com (il27vts02.cig.mot.com [10.17.196.86])
	by il27exr03.cig.mot.com (8.13.1/Vontu) with SMTP id mB87ae4h028849
	for <git@vger.kernel.org>; Mon, 8 Dec 2008 01:36:40 -0600 (CST)
Received: from zmy16exm62.ds.mot.com (zmy16exm62.ap.mot.com [10.179.4.33])
	by il27exr03.cig.mot.com (8.13.1/8.13.0) with ESMTP id mB87acLG028840
	for <git@vger.kernel.org>; Mon, 8 Dec 2008 01:36:39 -0600 (CST)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <D13CA5792E8D5140A50EEDB89972CDCB053E21AA@zmy16exm63.ds.mot.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: How to config git-daemon?
thread-index: AclY+oYsciOdQQ3YQ2KaJCjLwo2w2AAADwQgAADQqWAAAlz3kA==
X-CFilter-Loop: Reflected
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102533>

 
Hi,

Try to check if GIT_PROXY_COMMAND is set and your proxy can accept
internal address.

Regards
Simon Liu

-----Original Message-----
From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On
Behalf Of Ren LingYan-E5949C
Sent: Monday, December 08, 2008 2:28 PM
To: git@vger.kernel.org
Subject: How to config git-daemon?

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
