From: Luben Tuikov <ltuikov@yahoo.com>
Subject: [PATCH 0/3] gitweb: blame: print commit8 on the leading row of a commit-block
Date: Wed, 4 Oct 2006 00:10:41 -0700 (PDT)
Message-ID: <20061004071041.60663.qmail@web31807.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Wed Oct 04 09:10:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GV0tx-0005rl-Gi
	for gcvg-git@gmane.org; Wed, 04 Oct 2006 09:10:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030453AbWJDHKm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Oct 2006 03:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030456AbWJDHKm
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Oct 2006 03:10:42 -0400
Received: from web31807.mail.mud.yahoo.com ([68.142.207.70]:50621 "HELO
	web31807.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030453AbWJDHKl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Oct 2006 03:10:41 -0400
Received: (qmail 60665 invoked by uid 60001); 4 Oct 2006 07:10:41 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=QCmzib+MFg5hHvGsSrddkN4ncJi6o2zVlpOZnBJyxm7dVBvroHjWoJsWC77KvcC7xa1z8dnFoPNYQejHWI7s7X1aw5bgtm5eGAoPA0q9P2OWEeArkfMmVBPfYtrjVn/a2aYlq6a8F9rsHFvYukG3zrGi30RlNRFNCKLnVLPIrnY=  ;
Received: from [71.80.233.118] by web31807.mail.mud.yahoo.com via HTTP; Wed, 04 Oct 2006 00:10:41 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28316>

The following set of patches implements Junio's excellent
idea of printing the commit-8 only on the leading row of
a commit block, as well as implementing mouse-over title of
the author and the date of the commit.   Thus making the output
of git_blame2() less cluttered yet able to give more information
should the user mouse-over the commit.

The difference is that this implementations doesn't use a "stack-like"
chunk to represent each block-per-commit, thus eliminating the concern
of rare but present files with 100s of 1000s of lines with only an
initial commit.

     Luben
