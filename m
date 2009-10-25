From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: What's cooking in git.git (Oct 2009, #04; Wed, 21)
Date: Sun, 25 Oct 2009 17:02:13 +0100
Message-ID: <20091025160213.GA8532@localhost>
References: <7veiovly35.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 25 17:02:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N25Xs-0008Ed-F3
	for gcvg-git-2@lo.gmane.org; Sun, 25 Oct 2009 17:02:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753572AbZJYQCF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Oct 2009 12:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753521AbZJYQCF
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Oct 2009 12:02:05 -0400
Received: from mail-bw0-f227.google.com ([209.85.218.227]:43004 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753393AbZJYQCE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Oct 2009 12:02:04 -0400
Received: by bwz27 with SMTP id 27so1657586bwz.21
        for <git@vger.kernel.org>; Sun, 25 Oct 2009 09:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=DxwUOpK8BvnrWA2BZ9Y+lIqfkAYelh6b+qxx24kqmmk=;
        b=T8+RHhuNRQ7Uztk50oBkg4UuS6T8SkuFHXxUW/JgZfuxuHD8Er7zfI7JSp5TBBouGE
         R1O0KzrED9pDA2KiVNMkZvC0WkHBpPLTk0NhB05PGVuTi87sO7S5brCDJfWeXF3r2Nfr
         e8JVM7TPpg3qUuHklKIZj8d7S4z0942EI4T5s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=YQKNorMh3LCChkenYCFmMZo1tLJKJLslUTt9ee/jODMRz/MqOFHKfyj2V20zvUwZAX
         hxz00FwGXDeGw6J1SaE3JsSoZqSkZyiyfPBCoEyptM+A6dZHOuhLTMeWgz8EgSajTwGq
         ZHo9QzZ9tdTPGl5jXuU5R7gz2Zc8cvZhwpJJ0=
Received: by 10.204.32.204 with SMTP id e12mr1773290bkd.51.1256486527400;
        Sun, 25 Oct 2009 09:02:07 -0700 (PDT)
Received: from darc.lan (p549A3880.dip.t-dialin.net [84.154.56.128])
        by mx.google.com with ESMTPS id 26sm7453616fxm.23.2009.10.25.09.02.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 Oct 2009 09:02:07 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1N25Xp-0002e3-Kc; Sun, 25 Oct 2009 17:02:13 +0100
Content-Disposition: inline
In-Reply-To: <7veiovly35.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131219>

On Wed, Oct 21, 2009 at 11:52:30PM -0700, Junio C Hamano wrote:

> * ks/precompute-completion (2009-10-05) 1 commit.
>   (merged to 'next' on 2009-10-14 at adf722a)
>  + Speedup bash completion loading
> 
> Are people happy with this?

I'm looking forward to this on Windows, where loading the completion script
can take about 10 seconds.

Clemens
