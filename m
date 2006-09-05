From: Jakub Narebski <jnareb@gmail.com>
Subject: Test names
Date: Tue, 05 Sep 2006 02:10:59 +0200
Organization: At home
Message-ID: <edifa7$h29$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Sep 05 02:11:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKOWx-0004eh-NX
	for gcvg-git@gmane.org; Tue, 05 Sep 2006 02:11:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965056AbWIEAK7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Sep 2006 20:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965081AbWIEAK7
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Sep 2006 20:10:59 -0400
Received: from main.gmane.org ([80.91.229.2]:55526 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S965056AbWIEAK6 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Sep 2006 20:10:58 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GKOWj-0004d5-VB
	for git@vger.kernel.org; Tue, 05 Sep 2006 02:10:53 +0200
Received: from host-81-190-21-28.torun.mm.pl ([81.190.21.28])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 05 Sep 2006 02:10:53 +0200
Received: from jnareb by host-81-190-21-28.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 05 Sep 2006 02:10:53 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-28.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26458>

In t/README it is written:

> The test files are named as:
>
>         tNNNN-commandname-details.sh
>
> where N is a decimal digit.
>
> First digit tells the family:
>
>         0 - the absolute basics and global stuff
> [...]
>         7 - the porcelainish commands concerning the working tree

There are now some test which have 8 or 9 as first digit (e.g.
t8002-blame.sh, t9001-send-email.sh). What is the family for them?
What number for example gitweb test should have?

> Second digit tells the particular command we are testing.

Is there any naming rule, or just increment it by one when adding new test
in the same family?

> Third digit (optionally) tells the particular switch or group of switches
>  we are testing.

What tells the fourth digit?
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
