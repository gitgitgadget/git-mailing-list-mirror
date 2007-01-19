From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: git ls-files -o under .git/ prints all repository files
Date: Fri, 19 Jan 2007 09:01:47 +0100
Message-ID: <81b0412b0701190001n10b84df8icb98ee65c05351e8@mail.gmail.com>
References: <87r6trsu7n.wl@mail2.atmark-techno.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 19 09:02:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7ohG-0004Qb-IL
	for gcvg-git@gmane.org; Fri, 19 Jan 2007 09:02:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964932AbXASIBu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 03:01:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964930AbXASIBu
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 03:01:50 -0500
Received: from hu-out-0506.google.com ([72.14.214.236]:51398 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964933AbXASIBt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 03:01:49 -0500
Received: by hu-out-0506.google.com with SMTP id 36so385695hui
        for <git@vger.kernel.org>; Fri, 19 Jan 2007 00:01:48 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ojw29CQz21kdzduaATf7hJ1lUYs7UDEeis5SepiF7rl/DMPSv/jCa8TuVE5CFHZNN/yTN4pw6HEDWgCb/2YmINzZxCaLWRnbe/WXs/uqqm5QcEnwGoic8p31OTRdFS9g0sWh32kHY3ZODURmijMEcmWhVsJqpgWcQTyClMqpLRg=
Received: by 10.78.18.3 with SMTP id 3mr1742328hur.1169193707758;
        Fri, 19 Jan 2007 00:01:47 -0800 (PST)
Received: by 10.78.135.3 with HTTP; Fri, 19 Jan 2007 00:01:47 -0800 (PST)
To: "Yasushi SHOJI" <yashi@atmark-techno.com>
In-Reply-To: <87r6trsu7n.wl@mail2.atmark-techno.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37159>

On 1/19/07, Yasushi SHOJI <yashi@atmark-techno.com> wrote:
> sure in UNIX env., you can easily shoot yourself in the foot. but it'd
> might be nice to help newbies.

It's is not just Unix. Humans are known for shooting themselves
in feet, heads and other parts of their bodies. It's a popular way
of taking life in own hands.

Seriously, though, git-clean can just refuse cleaning $GIT_DIR.
