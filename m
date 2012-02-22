From: Sean Gies <Sean.Gies@imgtec.com>
Subject: Bug report: "git-merge --ff" should fail if branches have diverged
Date: Wed, 22 Feb 2012 21:51:05 +0000
Message-ID: <DB0837FD-0963-4BF9-BD7B-B243F580CC1C@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 22 23:06:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0KKM-0002wo-6l
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 23:06:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755583Ab2BVWGR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Feb 2012 17:06:17 -0500
Received: from multi.imgtec.com ([194.200.65.239]:47804 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755387Ab2BVWGQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Feb 2012 17:06:16 -0500
X-Greylist: delayed 906 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Feb 2012 17:06:16 EST
Thread-Topic: Bug report: "git-merge --ff" should fail if branches have
 diverged
Thread-Index: AQHM8awT1+W7k8rhRkKD9h+Ytudtbg==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.101.253]
Content-ID: <FB7EE43F9076EF41A1138EFA4879D07D@imgtec.com>
X-SEF-Processed: 7_3_0_01181__2012_02_22_21_51_08
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191294>

Git developers, I have a small bug report:

When I specify the "--ff" option to git-merge, I expect it to perform a fast-forward merge or none at all. If the branches have diverged and a fast-forward cannot be done, I expect the command to fail. With git 1.7.6, if "git-merge -ff" cannot fast-forward, it falls back to creating the merge commit I did not want.

Thank you,
-Sean
