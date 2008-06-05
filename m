From: Brian Swetland <swetland@google.com>
Subject: recognizing multiple authors for a patch?
Date: Thu, 5 Jun 2008 01:27:08 -0700
Organization: Google, Inc.
Message-ID: <20080605082708.GA28166@bulgaria.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 05 10:30:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4ArL-00054U-6D
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 10:30:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754043AbYFEI3D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 04:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752713AbYFEI2z
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 04:28:55 -0400
Received: from smtp-out.google.com ([216.239.33.17]:16058 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721AbYFEI2x (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 04:28:53 -0400
Received: from spaceape24.eur.corp.google.com (spaceape24.eur.corp.google.com [172.28.16.76])
	by smtp-out.google.com with ESMTP id m558SlQu005796
	for <git@vger.kernel.org>; Thu, 5 Jun 2008 09:28:47 +0100
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
	t=1212654527; bh=sgf+OYnhhlikz9oNq2ZCEqL+LBw=;
	h=DomainKey-Signature:Date:From:To:Subject:Message-ID:MIME-Version:
	 Content-Type:Content-Disposition:Organization:User-Agent; b=MJGeWp
	EANuDQy8tEGUDOwkePXfOhbOs0CN4+gZXVZ/H1OfOdGtscfSDCIzYbYZGBu95/KWTYK
	bv3hObIyr/o/w==
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:to:subject:message-id:mime-version:
	content-type:content-disposition:organization:user-agent;
	b=M+DRBWRgSb+6li/koUYSXRp9swVvZxhAhoiIq5BqXIsA3TzrQebw5TmJMBVlBKgla
	WN1/kIesireOAckoZX9+A==
Received: from bulgaria (bulgaria.corp.google.com [172.18.102.38])
	by spaceape24.eur.corp.google.com with ESMTP id m558Skht030215
	for <git@vger.kernel.org>; Thu, 5 Jun 2008 09:28:46 +0100
Received: by bulgaria (Postfix, from userid 1000)
	id 242791224FF; Thu,  5 Jun 2008 01:27:07 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83880>


Nicolas Pitre said, in the thread on the "preserve the committer" patch:
> I think this is against the purpose of the committer field to preserve
> it from a commit that was not made by you.  What really really has to be
> preserved is the author field of course.  But attributing commit action
> to someone else than yourself when you are the one reorganizing commits
> is misrepresentation.

Which reminds me of a longstanding question I have -- how best to
represent patches which have multiple authors?

I'm submitted patches to the linux arm kernel list on behalf of a
team of kernel engineers -- drivers that are developed internally
are typically squashed down to a single patch for initial submission
and review (which seems to be the desired way to handle these things),
but in some cases they're the work of multiple people.  Is there a
better solution than to have one of the authors as the Author: and
mentioning the other contributors in the patch description?

Brian
