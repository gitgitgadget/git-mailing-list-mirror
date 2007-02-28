From: "Raimund Bauer" <ray@softwarelandschaft.com>
Subject: RE: Problems with git cvsimport
Date: Wed, 28 Feb 2007 14:27:29 +0100
Organization: Softwarelandschaft
Message-ID: <000c01c75b3c$31f91000$0b0aa8c0@abf.local>
References: <Pine.LNX.4.63.0702271700300.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 28 14:27:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMOqD-0003CW-L0
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 14:27:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbXB1N1b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 08:27:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbXB1N1b
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 08:27:31 -0500
Received: from s15211414.onlinehome-server.info ([87.106.16.196]:45432 "EHLO
	s15211414.onlinehome-server.info" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932272AbXB1N1a convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 08:27:30 -0500
Received: (qmail 19651 invoked from network); 28 Feb 2007 14:32:44 +0100
Received: from host-62-245-155-90.customer.m-online.net (HELO swl011) (62.245.155.90)
  by s15211414.onlinehome-server.info with SMTP; 28 Feb 2007 14:32:44 +0100
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <Pine.LNX.4.63.0702271700300.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40921>

> Sorry to have missed that earlier. AFAIR cvsimport _needs_ 
> cvsps 2.1. You 
> have version 2.0rc1, which is not sufficient...

OK, thanks a lot, now that I'm using cvsps especially for git from
http://ydirson.free.fr/en/software/scm/cvsps.html things are looking
a bit better.

There are some modules I can import with relative little noise. Not sure why
I needed to do 'checkout -f' to get all the files in the working directory,
but I got no problem with that.

For some other modules it doesn't work at all.
I.e. trying

$ git cvsimport -d :pserver:ray007@cvs.drupal.org:/cvs/drupal-contrib -C
localizer -a contributions/modules/localizer
Initialized empty Git repository in /home/ray/drupal/modules/localizer/.git/
file 'CHANGELOG.txt; pre_rev:INITIAL; post_rev:1.1; dead:0; branch_point:0
' not found in hash
fatal: refs/heads/origin: not a valid SHA1
fatal: master: not a valid SHA1
warning: You appear to be on a branch yet to be born.
warning: Forcing checkout of HEAD.
fatal: just how do you expect me to merge 0 trees?
checkout failed: 256

Any hint what I have done wrong?

Doing a normal cvs checkout works, trying to do a git-cvsimport in the
checked-out directory fails with the same error again.

For trying out, username=anonymous, password=anonymous should work.
Or to just see what's in the repo, you can have a look at
http://cvs.drupal.org/viewcvs/drupal/contributions/modules/localizer/
to see the repo I tried in the example above.

My perl knowledge is _very_ limited, but I'll have a look at the script too
...

-- 
best regards

  Ray
