From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: git log --grep missing entries?
Date: Tue, 27 May 2008 22:36:51 +0200
Message-ID: <483C70E3.3060607@gmail.com>
References: <20080527202842.GA32252@foursquare.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Chris Frey <cdfrey@foursquare.net>
X-From: git-owner@vger.kernel.org Tue May 27 22:38:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K15vV-0008AU-9S
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 22:37:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758126AbYE0Ugx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2008 16:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758116AbYE0Ugx
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 16:36:53 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:16317 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758105AbYE0Ugx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 16:36:53 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1605650fgg.17
        for <git@vger.kernel.org>; Tue, 27 May 2008 13:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        bh=juzKY3XNcAUttok4g0YUgYVaSbFA+SZDW9V07uZiRD0=;
        b=lcsmtoegDnEr6REMJuLmdYQ3yeGrNeaH7rJmPPhnc5nVg8T27roTcVedyHY2ik4DnAjWKMDrGKLPVvYVJdEkRrgcFydxRPcCiQVDllRTEO30xIYW1hiBugLeircBSFje0bJzIKJ+cUGRtNror73YKoF+AbKBo7hJQoXkiw6C4p4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=M3FpU6ajzqVl1pRT6ntpiKSk1I8p90xuq922Weu2YJei2Iui1hREkbl0qQR2TI/tU2EaJWZZwBj06UT/f3ByTUGDgslKPymgG1Wn9NSeL1osbXYrFIwbmB0QKaoxu9gpTCepirj9aP6ZEdlqjFDMtRuH7yud/KmTTXx7nywwLz0=
Received: by 10.86.90.2 with SMTP id n2mr2400139fgb.51.1211920611365;
        Tue, 27 May 2008 13:36:51 -0700 (PDT)
Received: from ?192.168.23.50? ( [91.33.209.73])
        by mx.google.com with ESMTPS id e20sm15877205fga.7.2008.05.27.13.36.50
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 27 May 2008 13:36:51 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <20080527202842.GA32252@foursquare.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83045>

Chris Frey wrote:
> 	# nothing appears for these commands
> 	git log --grep="thadh@thad.corp.google.com"
> 	# this works
> 	git log --author="thadh@thad.corp.google.com"

According to the man page of git-log, --grep only greps the log message, 
not the author.  Does that help?

-- Lea
