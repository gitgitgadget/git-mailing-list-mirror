From: Jonathan Nieder <jrnieder@gmail.com>
Subject: OT: mail-based interfaces and web-based interfaces (Re: Extract Git
 classes from git-svn (1/10))
Date: Wed, 25 Jul 2012 00:54:23 -0500
Message-ID: <20120725055422.GB4503@burratino>
References: <5004B772.3090806@pobox.com>
 <20120717174446.GA14244@burratino>
 <5005F139.8050205@pobox.com>
 <20120717233125.GF25325@burratino>
 <7vy5mhwrdl.fsf@alter.siamese.dyndns.org>
 <500F23E4.9090306@pobox.com>
 <20120725025507.GB13236@dcvr.yhbt.net>
 <500F860E.5010909@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	robbat2@gentoo.org, Ben Walton <bwalton@artsci.utoronto.ca>
To: Michael G Schwern <schwern@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 07:54:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StuYL-0003QB-Gl
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 07:54:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468Ab2GYFy2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 01:54:28 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:37954 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102Ab2GYFy2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 01:54:28 -0400
Received: by gglu4 with SMTP id u4so330269ggl.19
        for <git@vger.kernel.org>; Tue, 24 Jul 2012 22:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=XwbWP1iqtL/YFan44tb6Kt1Jif1HlUhnj0mIpuHg5rs=;
        b=bzhFg+lTuAfgTg1HNc43u3JCqRTgQnhLUcC+HHLGyd+mmgaE8XHrpMDVbwEM+SkJSA
         SR0vJ/aG6aV94RHzvJ22j0o/E42RDevi2eOIWkc4fC7mA9SpPqf4CrPV+JANt7GhAo4p
         VsojHLvEH7EC0+YeuIDhnjTPgUI39dBmXKuv/WKGNKzeh+7p0NQG20DnYV6woqPr4KpG
         ioCmfyCKxKsnjMXgZq2pMDHsssfK6bLlWWpzVKPzFYGHnZVRhr/eJWzX9NvJCKUPKlwe
         eyue3YkbuAx3c0yqzRwRC6zj4R9QCwVBBQj2NOPgovM1zD5932FgvEeZ9m9oLfcqKxQV
         z4ZQ==
Received: by 10.43.52.198 with SMTP id vn6mr21499170icb.42.1343195667356;
        Tue, 24 Jul 2012 22:54:27 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id a10sm943357igd.1.2012.07.24.22.54.25
        (version=SSLv3 cipher=OTHER);
        Tue, 24 Jul 2012 22:54:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <500F860E.5010909@pobox.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202123>

Michael G Schwern wrote:

> And again, it *does not have to be zero sum*.  It doesn't have to be email VS
> GUI.  You can have your cake and eat it too.

I assume you're talking about web-based interfaces that have gateways
to email, that produce inboxes like this:

 24 Jul 02:46	GitHub	[github] msysgit/msysgit was forked by peters
 23 Jul 10:27	GitHub	[msysgit/git] ce8ebc: vcs-svn: rename check_o
 23 Jul 10:01	GitHub	[github] Comment created on issue 44 (new git
 23 Jul 09:50	GitHub	[github] Comment created on issue 44 (new git
 23 Jul 09:33	GitHub	[github] Comment created on issue 44 (new git
 23 Jul 09:39	GitHub	[github] Comment created on issue 24 (Long fi
 23 Jul 09:31	GitHub	[github] Comment created on issue 44 (new git
 23 Jul 09:30	GitHub	[github] Comment created on issue 24 (Long fi
 22 Jul 23:57	GitHub	[github] Comment created on issue 44 (new git

I call that pretending to have my cake, rather than having it. :)

Maybe some day someone will prove me wrong and make a nice web-based
tool that I don't even need to know about that mines project mailing
lists.  If I have to tweak my subject lines a little to help it out,
that's fine with me.  I think patchwork is supposed to work this way.

But unless we're talking about splitting the mailing list into a bunch
of mini mailing lists (like some bug trackers do), it doesn't change
anything fundamental, so I'm not sure why we're discussing this.

Ciao,
Jonathan
