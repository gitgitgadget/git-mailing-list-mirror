From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: RE: Problems with git cvsimport
Date: Sat, 3 Mar 2007 01:30:29 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703030129220.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <000c01c75b3c$31f91000$0b0aa8c0@abf.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Raimund Bauer <ray@softwarelandschaft.com>
X-From: git-owner@vger.kernel.org Sat Mar 03 01:30:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNI8y-0000hP-9d
	for gcvg-git@gmane.org; Sat, 03 Mar 2007 01:30:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992794AbXCCAad (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 19:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992795AbXCCAad
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 19:30:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:38003 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S2992794AbXCCAad (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 19:30:33 -0500
Received: (qmail invoked by alias); 03 Mar 2007 00:30:31 -0000
X-Provags-ID: V01U2FsdGVkX19W/VlU8rZWERksjE6G35UNRybN7eeKU+11D91pAZ
	q6iLyECzECDDye
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <000c01c75b3c$31f91000$0b0aa8c0@abf.local>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41262>

Hi,

On Wed, 28 Feb 2007, Raimund Bauer wrote:

> $ git cvsimport -d :pserver:ray007@cvs.drupal.org:/cvs/drupal-contrib -C
> localizer -a contributions/modules/localizer
> Initialized empty Git repository in /home/ray/drupal/modules/localizer/.git/
> file 'CHANGELOG.txt; pre_rev:INITIAL; post_rev:1.1; dead:0; branch_point:0
> ' not found in hash
> fatal: refs/heads/origin: not a valid SHA1
> fatal: master: not a valid SHA1

This looks to me as if you did not cleanup after failed attempts. I would 
try this in a fresh directory. Actually, I did, and I think it worked, 
too... Latest commit is

commit 8fc1b3decbe961925e3d043f5e03b10e2093d72b
Author: robertogerola <robertogerola>
Date:   Tue Feb 13 13:22:53 2007 +0000

    Updated

Ciao,
Dscho
