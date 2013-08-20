From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Should "git apply --check" imply verbose?
Date: Tue, 20 Aug 2013 11:51:27 -0700
Message-ID: <20130820185127.GG4110@google.com>
References: <5213873A.6010003@windriver.com>
 <xmqqioz06y9m.fsf@gitster.dls.corp.google.com>
 <5213B95D.3040409@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
X-From: git-owner@vger.kernel.org Tue Aug 20 20:51:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBr1j-0006eC-Fw
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 20:51:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751486Ab3HTSvb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 14:51:31 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:37946 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188Ab3HTSvb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 14:51:31 -0400
Received: by mail-pa0-f46.google.com with SMTP id fa1so1063489pad.33
        for <git@vger.kernel.org>; Tue, 20 Aug 2013 11:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=m9g6qP64kRMKf1KvPKDxAePieCkzz6lHumfAJ6GgWTQ=;
        b=jVcak5+oxpsZPx1RYy8n8ZfI/jfg9WOfHORBfRINv6+opYCgnLSg9QqLRnVyloUbJj
         Ej0dpngE8WwCYfUBzdHqt9c9NrQl1ESCtF9QyMQttepLGEj8kRsCAMXtTPqYDeAdZBbv
         7FHk0TVht9Xm9wa5I3ZJ2zsQ8dcfGYx+sD+Yksa2hdUCMIoCard+lXhq710E6mk0LvKv
         /uaKDYrfpSH+ct5gfLswJv0v4yFhCefRqYvEfYuhsfVpO9nOXBzaXZPj2F03v4WR7Thb
         VXYDw8cvgy+Xo7eRPnRbAbn7XDPDVetwocQHVlLi+qQmi1sYSV4nZUjWNmtLll//xpSW
         EBdQ==
X-Received: by 10.68.171.35 with SMTP id ar3mr3596776pbc.61.1377024690485;
        Tue, 20 Aug 2013 11:51:30 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id zq10sm5304645pab.6.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 20 Aug 2013 11:51:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5213B95D.3040409@windriver.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232629>

Hi Paul,

Paul Gortmaker wrote:

> OK, so given your feedback, how do you feel about a patch to the
> documentation that indicates to use "-v" in combination with the
> "--check" to get equivalent "patch --dry-run" behaviour?

Sounds like a good idea to me.

I assume you mean a note in the OPTIONS or EXAMPLES section of
Documentation/git-apply.txt?

Thanks,
Jonathan
