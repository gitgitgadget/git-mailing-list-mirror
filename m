From: "Sparks, Sam" <SSparks@twacs.com>
Subject: Git'ing a non-labeled set of sources
Date: Wed, 8 Aug 2007 13:59:38 -0500
Message-ID: <CF7E46FCFF66AD478BB72724345289EC170CE4@twx-exch01.twacs.local>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 08 21:00:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIqlT-00077N-9k
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 21:00:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760087AbXHHTAF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 15:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760056AbXHHTAF
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 15:00:05 -0400
Received: from outbound-cpk.frontbridge.com ([207.46.163.16]:53665 "EHLO
	outbound3-cpk-R.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757533AbXHHTAB convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Aug 2007 15:00:01 -0400
Received: from outbound3-cpk.bigfish.com (localhost [127.0.0.1])
	by outbound3-cpk-R.bigfish.com (Postfix) with ESMTP id 76F8F9956D9
	for <git@vger.kernel.org>; Wed,  8 Aug 2007 19:00:00 +0000 (UTC)
Received: from mail131-cpk-R.bigfish.com (unknown [10.2.40.3])
	by outbound3-cpk.bigfish.com (Postfix) with ESMTP id 7541680004E
	for <git@vger.kernel.org>; Wed,  8 Aug 2007 19:00:00 +0000 (UTC)
Received: from mail131-cpk (localhost.localdomain [127.0.0.1])
	by mail131-cpk-R.bigfish.com (Postfix) with ESMTP id F10C72F830C
	for <git@vger.kernel.org>; Wed,  8 Aug 2007 18:59:59 +0000 (UTC)
X-BigFish: VP
X-MS-Exchange-Organization-Antispam-Report: OrigIP: 68.89.149.4;Service: EHS
Received: by mail131-cpk (MessageSwitch) id 1186599599312150_11907; Wed,  8 Aug 2007 18:59:59 +0000 (UCT)
Received: from mail.twacs.com (unknown [68.89.149.4])
	by mail131-cpk.bigfish.com (Postfix) with ESMTP id E98EE3F8081
	for <git@vger.kernel.org>; Wed,  8 Aug 2007 18:59:58 +0000 (UTC)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Git'ing a non-labeled set of sources
Thread-Index: AcfZ7kRLuTV7AFzKQfagIUfTE2slVQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55337>

Hello All,

Please excuse me if this is an ignorant question; I'm new to git and my
have overlooked something in the documentation.

I'm attempting to obtain a snapshot of source code from an unlabeled git
branch in a public repository. I've found in the documentation that a
timestamp cannot be used to specify a particular version of source code,
but I believe I can work with the commit value as returned by 'git
show'.

However, I have been unsuccessful in my attempts to use this identifier
to clone or checkout the associated source tree. Has anyone been
successful in using git to successfully replicate an unlabeled version
of sources in a repository?

Here is my latest attempt:
/dir_i_want_to_replicate $ git show --pretty=short
commit 5b1313fb2758ffce8b624457f777d8cc6709608d
Author: ....

/replication_dir $ git clone git://www.denx.de/git/u-boot.git
u-boot-mpc83xx
Blah blah blah..
 100% (4378/4378) done
/replication_dir/u-boot-mpc83xx/ $ git checkout
5b1313fb2758ffce8b624457f777d8cc6709608d
error: pathspec '5b1313fb2758ffce8b624457f777d8cc6709608d' did not match
any. 

Any suggestions would be greatly appreciated.
Thanks in advance,
Sam Sparks
