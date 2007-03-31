From: Tom Prince <tom.prince@ualberta.net>
Subject: Re: git-add has gone lstat() mad
Date: Sat, 31 Mar 2007 23:28:37 +0400
Message-ID: <20070331192835.GA25016@hermes>
References: <200703302055.13619.andyparkins@gmail.com> <7vslbmxkcv.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0703302020510.6730@woody.linux-foundation.org> <200703311119.10581.andyparkins@gmail.com> <86lkhdqx8y.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Sat Mar 31 21:28:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXjFQ-0008PT-64
	for gcvg-git@gmane.org; Sat, 31 Mar 2007 21:28:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753258AbXCaT2V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 31 Mar 2007 15:28:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753265AbXCaT2V
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Mar 2007 15:28:21 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:37557 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753258AbXCaT2U (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Mar 2007 15:28:20 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1143528uga
        for <git@vger.kernel.org>; Sat, 31 Mar 2007 12:28:18 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=E+kA1zsGcjHLwBFWighitd/pKaWXzSvMWC4uqGp6BbHWCKIHVwgCZR80aWHxx0rVrDxUf5zWJZioqDD9qhkOLWfgrJ6rlBQJA0xVUpLau1mQC2vHZiUS0ZgFGCEJbmgsPQ0YgCmJjdWEr6g0KJZz/6bx6GoSsWbxj6wK2OQW9t8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=lsRbGKySbFeRncniwLLHyq/0zGbsg2nOUiwryDNvxkNbDDyRJNHAnd9BiguutjvBu5CmD56ZkJCDTvwQms6vB/HqZYOGV6ujN51L4ldLjix50IqsQMQBmA3B7IxshjKGdEDWD1wRTB7JOuDIbqFM2zuUnlnU9fxsJmYfIdeWhkE=
Received: by 10.67.119.13 with SMTP id w13mr3211002ugm.1175369298583;
        Sat, 31 Mar 2007 12:28:18 -0700 (PDT)
Received: from hermes ( [80.240.215.209])
        by mx.google.com with ESMTP id 20sm3708332uga.2007.03.31.12.28.17;
        Sat, 31 Mar 2007 12:28:17 -0700 (PDT)
Received: by hermes (nbSMTP-1.00) for uid 500
	(using TLSv1/SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
	Tom; Sat, 31 Mar 2007 23:28:38 +0400 (MSD)
Mail-Followup-To: "Randal L. Schwartz" <merlyn@stonehenge.com>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <86lkhdqx8y.fsf@blue.stonehenge.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43567>

On Sat, Mar 31, 2007 at 07:54:37AM -0700, Randal L. Schwartz wrote:
> Given that git currently doesn't maintain any metadata other than +x/-x, how
> are you maintaining the metadata for your homedir items?  I know some
> schemes
> were discussed here in the past, but I'm curious as to what you settled on.
> For example, your .netrc file needs to be 600, but git won't track that.

I personally just don't track files that have sensitive data. I tend to have
copies of my home dir on somewhat public servers, so I don't want that data
copied around anyway.

  Tom
