From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Extract Git classes from git-svn (1/10) (was Re: Fix git-svn
 tests for SVN 1.7.5.)
Date: Tue, 17 Jul 2012 18:31:25 -0500
Message-ID: <20120717233125.GF25325@burratino>
References: <5004B772.3090806@pobox.com>
 <20120717174446.GA14244@burratino>
 <5005F139.8050205@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, robbat2@gentoo.org,
	Eric Wong <normalperson@yhbt.net>,
	Ben Walton <bwalton@artsci.utoronto.ca>
To: Michael G Schwern <schwern@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 18 01:31:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrHEu-0003hC-Q7
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jul 2012 01:31:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756963Ab2GQXbc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jul 2012 19:31:32 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:49074 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756940Ab2GQXba (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2012 19:31:30 -0400
Received: by gglu4 with SMTP id u4so1015532ggl.19
        for <git@vger.kernel.org>; Tue, 17 Jul 2012 16:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=pvNiJcobyZzgzycXzvPNSyTGfFTL6G8lO6/XUkAJUU4=;
        b=jfF4X6zeQcglzz/uJKZlzXVew0pDDCm5MPxdbimd27svA6qBjAFweV7oeTucY+KH8/
         xt7+H4WG4m9iYlj1Deq9N4VHsKOaL1DAAxEuSbaR/5Cz6FZ0rW7LCKc7TWY5prOsdaFE
         BevwpclqSoXkKaM7TMLgOxYkMG61rsn3h2khhN+N9y+1GoC7EIamQi6DSb77CF6GCceP
         RXrihY7nd6u7OHqiXbRRjJLBEZ2QsnM9YdHhpJb3Y9uA2acqGSQYj1nlc2R7ZgVKMQ/V
         MgapTH4iRc+NQEJkFBXqN8oCiGuRwXst0ADl1QD/zJ/094UddOvZRjwuDbPYb8J+vVK9
         Agzw==
Received: by 10.42.81.17 with SMTP id x17mr2630010ick.5.1342567889903;
        Tue, 17 Jul 2012 16:31:29 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id z3sm12857608igc.7.2012.07.17.16.31.28
        (version=SSLv3 cipher=OTHER);
        Tue, 17 Jul 2012 16:31:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5005F139.8050205@pobox.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201636>

Hi,

Michael G Schwern wrote:

> There's five classes, so this is ten patches.  Let me go on record again to
> state that this one-inline-patch-per-email is a lot of busy work for me.

Well, there's no need to protest and go along with it if it's a bad
idea.  It's just what we've found to be the easiest way in the past to
review and have a discussion about each patch, but if you know a
better way, I'm happy to hear for next time.

The mailing list archive at
http://news.gmane.org/gmane.comp.version-control.git might be useful
for seeing some examples of how it plays out in practice.

You mind find the "git send-email" tool to be helpful for automating
some of the tedious steps of sending a patch series out.  It also does
some other nice things, like setting the subject lines in a more
useful way. :)

Thanks,
Jonathan
