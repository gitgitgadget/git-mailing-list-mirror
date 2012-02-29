From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Why Is There No Bug Tracker And Why Are Patches Sent Instead Of
 Pull Requests
Date: Wed, 29 Feb 2012 16:53:04 -0600
Message-ID: <20120229225304.GA9099@burratino>
References: <CAM=oOO2i-9zraF-YG5YzvZEmN1eXTnQfhJ-eMF04NP7HGtf41w@mail.gmail.com>
 <7vhay9tqs6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: opticyclic <opticyclic@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 29 23:53:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2sOf-0007X2-FT
	for gcvg-git-2@plane.gmane.org; Wed, 29 Feb 2012 23:53:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756416Ab2B2WxP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Feb 2012 17:53:15 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:53187 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756276Ab2B2WxN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Feb 2012 17:53:13 -0500
Received: by iagz16 with SMTP id z16so365956iag.19
        for <git@vger.kernel.org>; Wed, 29 Feb 2012 14:53:12 -0800 (PST)
Received-SPF: pass (google.com: domain of jrnieder@gmail.com designates 10.50.207.99 as permitted sender) client-ip=10.50.207.99;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jrnieder@gmail.com designates 10.50.207.99 as permitted sender) smtp.mail=jrnieder@gmail.com; dkim=pass header.i=jrnieder@gmail.com
Received: from mr.google.com ([10.50.207.99])
        by 10.50.207.99 with SMTP id lv3mr2477176igc.24.1330555992542 (num_hops = 1);
        Wed, 29 Feb 2012 14:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=4cQGr0QYNAdMFQ7aYH8jWS8EFh5S4JQhrQ20VR8JT2Y=;
        b=OuLidwgoNFmY/fXa8MOO3Hgy5JN64vYGnBCqeIfU8dMlm2ixjuxgReLJChGHsWZ3Ka
         F6hXtpmeTMfTFzKBnEtx3mlViN+DXYjB4JOrnj78OdwkytZNFyjvnFNV5g5MhucIRR62
         LBet3jsqPUYaqQKXtdnYlRHafdLW6FYi/KcyU=
Received: by 10.50.207.99 with SMTP id lv3mr2041998igc.24.1330555992481;
        Wed, 29 Feb 2012 14:53:12 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id eo1sm4894219igc.17.2012.02.29.14.53.11
        (version=SSLv3 cipher=OTHER);
        Wed, 29 Feb 2012 14:53:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vhay9tqs6.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191862>

Junio C Hamano wrote:
> opticyclic <opticyclic@gmail.com> writes:

>> Firstly, why is there no Bug Tracker such as JIRA for the git project?
>
> Probably because nobody volunteered to set-up, actively de-dupe, triage
> and maintain it in general.

By the way, my usual offer/shameless plug[*] still stands: anyone who
can stand the interface is welcome to file, triage, and work on bugs
in the bugtracker at <http://bugs.debian.org/src:git>, as long as it
seems possible that your bugs might also affect Debian.

"Work on" usually means "forward to the git mailing list", but maybe
having a bug number is a comfort to some people. ;-) See
<http://www.debian.org/Bugs/Reporting> for instructions.

All that said, that is still not The Bug Tracker for the git project.
I would not want it advertised on git-scm.com until we have had some
more practice dealing with outside bugs, and maybe more contributors
sorting through them.

It may be that others provide a similar service.

Hope that clarifies a little,
Jonathan

[*] http://thread.gmane.org/gmane.comp.version-control.git/181336/focus=181402
