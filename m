From: =?ISO-8859-1?Q?Tor_Arne_Vestb=F8?= <torarnv@gmail.com>
Subject: Re: [EGIT PATCH 00/11] Support customizable label decorations
Date: Thu, 05 Feb 2009 19:37:32 +0100
Message-ID: <498B31EC.2020006@gmail.com>
References: <1233795618-20249-1-git-send-email-torarnv@gmail.com> <20090205160625.GI26880@spearce.org> <200902051932.24600.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 19:39:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LV98S-0000uY-JD
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 19:39:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759618AbZBEShk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 13:37:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753522AbZBEShk
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 13:37:40 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:57869 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752417AbZBEShj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 13:37:39 -0500
Received: by ug-out-1314.google.com with SMTP id 39so180987ugf.37
        for <git@vger.kernel.org>; Thu, 05 Feb 2009 10:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=e6PImAuIhjNckGVKn6pOjkWj3x9pBavIGroVvE0jFx8=;
        b=scQzfCR20y/P8lzuF/1WPLh6U3WSYdxsQtIhwSsuWwpWWyHWWl+6+0Z2pHpB5E0Nys
         BqtpSRCQvPpSx5UitiQNu1fZbxzmVEKaMiD0idu1DlqPYcju0OcIoDv/bPV9C979/9Zq
         QFyA6NT2ByhshAZS5v7Y6fc7jbzqY27hezXQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=vmVjO39gcHeqlspuMBgFL+ucS3Y12iKK8KioeyWtJf+/rILKlILKHk13tbFvID+QHj
         SXKY293HP5vF4dF6odybjTHttp4u7QYqxRzYuZ2rnzbtRiBCZAQKnL03RDwQM++rbSQ9
         5zkNHL1mq7z1a9yryNElzbe0F/VIFBjG1jMrk=
Received: by 10.103.52.7 with SMTP id e7mr338314muk.52.1233859056972;
        Thu, 05 Feb 2009 10:37:36 -0800 (PST)
Received: from ?192.168.1.226? (212251244070.customer.cdi.no [212.251.244.70])
        by mx.google.com with ESMTPS id n10sm1549964mue.39.2009.02.05.10.37.35
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 05 Feb 2009 10:37:36 -0800 (PST)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <200902051932.24600.robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108599>

Robin Rosenberg wrote:
> It's our choice here. Generally, I think we should shift behavior here
> depending on layout. Java packages are not hierarchical in nature.
> 
> Currently it may look like this with flat package layout:
> 
> 	>org.spearce.jgit.treewalk
> 		CanonicalTreeParserTest.java
> 		EmptyTreeIteratorTest.java
> 		FileTreeIteratorTest.java
> 		NameConflictTreeWalkTest.java
> 		PostOrderTreeWalkTest.java
> 		TreeWalkBasicDiffTest.java
> 
> 	>org.spearce.jgit.treewalk.filter
> 		AlwaysCloneTreeFilter.java
> 		>NotTreeFilterTest.java
> 		TreeFilterTest.java
> 
> 
> Which is odd when looking at org.spearce.jgit.treewalk, because
> no files in that package have been changed.

Agreed. But, as the CVS plugin seems to handle this gracefully, without
any JDT specific code (from my brief investigations), it seems that this
is something we can get for free from the team plugins. I will look into
it as soon as this series is done cooking.

Tor Arne
