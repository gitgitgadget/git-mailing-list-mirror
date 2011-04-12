From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git-svn dying unceremoniously
Date: Mon, 11 Apr 2011 21:12:24 -0500
Message-ID: <20110412021202.GA17114@elie>
References: <m2fwpov47e.wl%dave@boostpro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dave Abrahams <dave@boostpro.com>
X-From: git-owner@vger.kernel.org Tue Apr 12 04:12:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9T5o-0004UL-Tu
	for gcvg-git-2@lo.gmane.org; Tue, 12 Apr 2011 04:12:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755991Ab1DLCMb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2011 22:12:31 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:39159 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754153Ab1DLCMb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2011 22:12:31 -0400
Received: by gxk21 with SMTP id 21so2389014gxk.19
        for <git@vger.kernel.org>; Mon, 11 Apr 2011 19:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=mcTMXGR8/i0SkGljrW9uLEhjo8vaQbTGbihRYncAWpM=;
        b=RWc91QWkuiZGYj/3e3lirx+bhznQODEi1wjCJHlyK15BRNXgvWas9vyYOLwj0puXMz
         /u+0r01nZlGY5vZ1+ihjbMbbRYnIKit97aPEGtNVXdGljtiuRTjqvD9OaYD4SFqrobH3
         Wzf8F/G4yHOWjedlv/nIuOlSIT7WqP7MV+Xeo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=bt2iVgrDkq8QUb4uj7twCnGjF1KQsHnocv4wEBNe1fh6flFtyeIwYOxYFeIUBuBebU
         +zoPm/uDp9GAOcqiw4CQQ+zxCrFUcQFH98WMjW2GCYGCxr2kjBeABhn2UITuCCL30Dja
         6nG7tfDdSFKRUE2AErT3Hk1TV1MdnaaBKLTzc=
Received: by 10.236.180.200 with SMTP id j48mr268685yhm.14.1302574350443;
        Mon, 11 Apr 2011 19:12:30 -0700 (PDT)
Received: from elie (adsl-69-209-51-92.dsl.chcgil.sbcglobal.net [69.209.51.92])
        by mx.google.com with ESMTPS id i10sm2842870yhd.10.2011.04.11.19.12.28
        (version=SSLv3 cipher=OTHER);
        Mon, 11 Apr 2011 19:12:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <m2fwpov47e.wl%dave@boostpro.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171368>

Hi Dave,

Dave Abrahams wrote:

> Does anyone know a cure for this?
> 
> % git svn fetch
>         A       boost/boost/graph/uniform_cost_search.hpp
>         A       boost/boost/graph/properties.hpp
>         A       boost/boost/graph/smallest_last_vertex_ordering.hpp
>         A       boost/boost/graph/johnson_all_pairs_shortest_paths.hpp
>         .
>         .
>         .
>         A       boost/libs/graph/docs/MutableGraph.html
> r7701 = c2434d3062416adac72b370ce3b993a9857e2029 (refs/remotes/trunk)
> error: git-svn died of signal 13

Very old bug, not well understood.  No cure, only workarounds.

See http://thread.gmane.org/gmane.comp.version-control.git/134936/focus=134940
and the surrounding thread for hints.

Hope that helps,
Jonathan
