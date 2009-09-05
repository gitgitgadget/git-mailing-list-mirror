From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT] Request for help
Date: Sat, 5 Sep 2009 18:25:49 +0200
Message-ID: <200909051825.49619.robin.rosenberg.lists@dewire.com>
References: <658028.86274.qm@web27804.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Douglas Campos <douglas@theros.info>,
	Jonas Fonseca <jonas.fonseca@gmail.com>, git@vger.kernel.org,
	Gabe McArthur <gabriel.mcarthur@gmail.com>
To: Mark Struberg <struberg@yahoo.de>
X-From: git-owner@vger.kernel.org Sat Sep 05 18:29:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mjy8W-0003Zf-At
	for gcvg-git-2@lo.gmane.org; Sat, 05 Sep 2009 18:29:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752525AbZIEQ3C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2009 12:29:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752518AbZIEQ3C
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Sep 2009 12:29:02 -0400
Received: from mail.dewire.com ([83.140.172.130]:11390 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752512AbZIEQ3B (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2009 12:29:01 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id B5D0A1493E00;
	Sat,  5 Sep 2009 18:29:01 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id psBhJrdRUhE4; Sat,  5 Sep 2009 18:29:01 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 23477802D5D;
	Sat,  5 Sep 2009 18:29:01 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <658028.86274.qm@web27804.mail.ukl.yahoo.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127819>

fredag 04 september 2009 19:28:39 skrev Mark Struberg <struberg@yahoo.de>:
> Hi!
> 
> Work has been done at 
> 
> http://github.com/sonatype/JGit/tree/mavenize
> 
> Please feel free to pull/fork and share your changes! I'd be happy to pull it in.
> 

Why does this new mvn test only execute 1024 tests here, while the old maven setup
does 1108 ones? It seems the classes that don't match *Test.java are omitted.

In both cases I invoke with "mvn clean test"

-- robin
