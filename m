From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [JGIT PATCH 1/2] Switch usage of AnyObjectId.toString() to new
	AnyObjectId.name()
Date: Wed, 3 Sep 2008 23:31:14 +0200
Message-ID: <20080903213114.GA6316@diku.dk>
References: <20080903090157.GB23406@diku.dk> <20080903170438.GA28315@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Sep 03 23:32:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kazxg-0001lU-MA
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 23:32:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752457AbYICVbS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 17:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752441AbYICVbS
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 17:31:18 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:36911 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751769AbYICVbR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 17:31:17 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 747D652C3A2;
	Wed,  3 Sep 2008 23:31:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JvSkxQYCP57R; Wed,  3 Sep 2008 23:31:14 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 58C2D52C394;
	Wed,  3 Sep 2008 23:31:14 +0200 (CEST)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP
	id D24DC6DF84F; Wed,  3 Sep 2008 23:31:13 +0200 (CEST)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id 414A81DE5DC; Wed,  3 Sep 2008 23:31:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080903170438.GA28315@spearce.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94857>

Shawn O. Pearce <spearce@spearce.org> wrote Wed, Sep 03, 2008:
> Hmm.  I had to squash this into it just to fix most of the code and
> make it pass tests, let alone fix the fetch and push implementations.
> Most of the library plain up and broke with this toString change.
>
> Missing T0001_ObjectId suggests to me that your method of running
> the tests isn't working right.

I can see that I am off to a good start leaving everything in a nice
broken mess. My only excuse is that while writing the patch I was still
trying to set up the tests to run properly. After applying your fix
and rerunning the tests pass here also.

And, lessons learnt: also run the jgit programs to get wider coverage.
(Uh, sounds like wiki material ... :)

> And this is only JGit.  I haven't even started to look into EGit.
> Though I don't expect you to fix EGit since you are working on
> NetBeans.  :-)

It is clearly a bigger tasks than I had expected and maybe not a good
starting point for contributing to JGit. However, in the longer run this
interface change will remove some unpleasant surprises.

-- 
Jonas Fonseca
