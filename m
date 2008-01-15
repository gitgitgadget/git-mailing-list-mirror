From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Git Cygwin - unable to create any repository - help!
Date: Wed, 16 Jan 2008 00:02:49 +0100
Message-ID: <200801160002.51048.robin.rosenberg.lists@dewire.com>
References: <20080114202932.GA25130@steel.home> <20080115200437.GB3213@steel.home> <a5eb9c330801151212y30cf4f63r9c294ba33da2b8f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "Alex Riesen" <raa.lkml@gmail.com>, git@vger.kernel.org
To: "Paul Umbers" <paul.umbers@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 00:03:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEuoT-0001xU-Nf
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 00:03:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753215AbYAOXCx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 18:02:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752477AbYAOXCx
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 18:02:53 -0500
Received: from [83.140.172.130] ([83.140.172.130]:10853 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751238AbYAOXCw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 18:02:52 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 28C1714597C1;
	Wed, 16 Jan 2008 00:02:51 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id snknFdx5PHsb; Wed, 16 Jan 2008 00:02:50 +0100 (CET)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 9AF59802667;
	Wed, 16 Jan 2008 00:02:50 +0100 (CET)
User-Agent: KMail/1.9.6 (enterprise 0.20071123.740460)
In-Reply-To: <a5eb9c330801151212y30cf4f63r9c294ba33da2b8f@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70571>

tisdagen den 15 januari 2008 skrev Paul Umbers:
> git ls (see below) returns nothing - it looks like the object doesn't
> exist at all. I've attached a .zip of the entire test directory (one
> text file plus .git). This is after "git init" followed by "git add ."
> 
> What do you think?

Git comes with test suite. Try it using make test or

GIT_TEST_OPTS="--debug --verbose" make test

The extra options are there since we expect it to fail.

-- robin
