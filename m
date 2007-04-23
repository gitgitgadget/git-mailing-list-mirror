From: "Raimund Bauer" <raimund.bauer@abf-int.de>
Subject: cvsimport problem
Date: Mon, 23 Apr 2007 09:56:49 +0200
Organization: ABF
Message-ID: <000c01c7857c$f27b3c30$0b0aa8c0@abf.local>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
To: "'git'" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 23 10:29:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hftva-0004rl-JA
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 10:29:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753907AbXDWI3Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 04:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753916AbXDWI3Y
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 04:29:24 -0400
Received: from mo-p00-fb.rzone.de ([81.169.146.163]:27475 "EHLO
	mo-p00-fb.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753907AbXDWI3X (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 04:29:23 -0400
X-Greylist: delayed 1949 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Apr 2007 04:29:23 EDT
Received: from mo-p00-ob.rzone.de (fruni-mo-p00-ob.mail [192.168.63.71])
	by gibbsson-fb-07.store (RZmta 5.6) with ESMTP id 706158j3MLRAaI
	for <git@vger.kernel.org>; Mon, 23 Apr 2007 09:58:30 +0200 (MEST)
Received: from swl011
	(host-62-245-155-90.customer.m-online.net [62.245.155.90])
	by post.webmailer.de (fruni mo14) (RZmta 5.6)
	with ESMTP id B01574j3N3LIoS for <git@vger.kernel.org>;
	Mon, 23 Apr 2007 09:56:51 +0200 (MEST)
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3028
Importance: Normal
X-RZG-AUTH: kNIH/r7SAhEXlbuHENeoxMp5nrP0moCurup8PsNCm1PrpJODMJft
X-RZG-CLASS-ID: mo00
X-RZG-CLASS-ID: mo00
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45302>

I have already imported lots of cvs repositories into git repostitories on
our server, which I then clone from several client machines.
This weekend I ran into a module I couldn't clone:

$ cvs -d :pserver:anonymous@cvs.drupal.org:/cvs/drupal-contrib login
 enter passwort 'anonymous'
$ git cvsimport -d :pserver:anonymous@cvs.drupal.org:/cvs/drupal-contrib -v
-i contributions/modules/node_import
Initialized empty Git repository in
/home/ray/drupal/modules/node_import/.git/
Running cvsps...
connect error: Network is unreachable
cvs rlog: Logging contributions/modules/node_import
cvs rlog: Logging contributions/modules/node_import/docs
cvs rlog: Logging contributions/modules/node_import/supported
cvs rlog: Logging contributions/modules/node_import/supported/cck
cvs rlog: Logging contributions/modules/node_import/supported/ecommerce
cvs rlog: Logging contributions/modules/node_import/tests
Fetching README   v 1.1.2.1
Update README: 840 bytes
Fetching node_import.module   v 1.1.2.1
Update node_import.module: 1902 bytes
fatal: Not a valid object name DRUPAL-4-3
read-tree failed: 32768
$

A cvs checkout of branch "DRUPAL-4-3" works without problems.

Using git version 1.5.1.1.784.g95e2

-- 
best regards

  Ray
