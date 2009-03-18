From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH 00/12] Improve test coverage in revwalk
Date: Wed, 18 Mar 2009 07:34:59 +0100
Message-ID: <200903180734.59435.robin.rosenberg.lists@dewire.com>
References: <1237340451-31562-1-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Mar 18 07:36:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjpOE-00032d-Dp
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 07:36:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755499AbZCRGfF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 02:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755247AbZCRGfE
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 02:35:04 -0400
Received: from mail.dewire.com ([83.140.172.130]:20965 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755230AbZCRGfD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 02:35:03 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id EFED2802AAD;
	Wed, 18 Mar 2009 07:35:00 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N3o0mb-qNPYj; Wed, 18 Mar 2009 07:35:00 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 77E56802A9A;
	Wed, 18 Mar 2009 07:35:00 +0100 (CET)
User-Agent: KMail/1.11.1 (Linux/2.6.27-12-generic; KDE/4.2.1; i686; ; )
In-Reply-To: <1237340451-31562-1-git-send-email-spearce@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113587>

onsdag 18 mars 2009 02:40:39 skrev "Shawn O. Pearce" <spearce@spearce.org>:
> Most of these patches are to improve the test coverage within the
> revwalk package.
> 
> 
> The last commit points out what I feared, which is that a RevWalk
> with a PathFilter applied doesn't produce the same results that
> git-core would produce in the same situation.  We're either missing
> some functions necessary to implement it, or we flat out produce
> a wrong graph in some cases.
> 
> The tests are commented out because JUnit doesn't have a notion of
> "known broken".  But I did leave in TODO comments.  I'd like to
> apply the test, and then work later to improve it, but I'm open
> to suggestions.

If we'd switch to JUnit4/TestNG we could abuse the expected exception
annotation.

-- robin
