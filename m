From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] merge: default to @{upstream}
Date: Sun, 30 Jan 2011 15:51:05 -0600
Message-ID: <20110130215105.GA11332@burratino>
References: <1296231457-18780-1-git-send-email-felipe.contreras@gmail.com>
 <1296233099.12855.14.camel@drew-northup.unet.maine.edu>
 <20110128175609.GA27118@burratino>
 <AANLkTi=iMJv+Jtj8YdYhQ_sxu+jBht5YqvSnkS2LUerz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Drew Northup <drew.northup@maine.edu>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 30 22:51:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PjfB8-0006Ep-Qb
	for gcvg-git-2@lo.gmane.org; Sun, 30 Jan 2011 22:51:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754877Ab1A3VvV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Jan 2011 16:51:21 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:48740 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754697Ab1A3VvU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Jan 2011 16:51:20 -0500
Received: by gxk9 with SMTP id 9so1749887gxk.19
        for <git@vger.kernel.org>; Sun, 30 Jan 2011 13:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=ZgVNuivESy16ltcF7cP+Do9SuJMzmwHl620ded4hiAI=;
        b=cZgbhuKANmABqCyPyXKKzbpc+VuO+KbS0P8NvrqusnbJsu2Dpqe/fhuPqwnz9HmdaC
         SNwrylkfOWJbIHoK1fzR5HoFqAwdMtW6kikQx6+DD38958/8amd5qTvmT92o0fQCbzCQ
         tPLBRpv2GcsTbgbS+RNPc9EyDHzBvINf+UH0s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ojLqKWMKTquiB52z7KTKzBaTZClaSmt4iHXtq6xXuWrJ3HdTHdiDevcTIJITmlFIsY
         gyYZ+Yh55V537z/9N/kDrQfEh5fuHNNiW8pUKBSwOY7OybleTRbwsiVKfPIL/8DtEURs
         9v1DBSRpRSEZfiZ5KELiGekF3B0EgxEZsTDWE=
Received: by 10.150.58.2 with SMTP id g2mr2425821yba.397.1296424279673;
        Sun, 30 Jan 2011 13:51:19 -0800 (PST)
Received: from burratino (adsl-69-209-75-28.dsl.chcgil.ameritech.net [69.209.75.28])
        by mx.google.com with ESMTPS id u10sm1483685yba.13.2011.01.30.13.51.17
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 30 Jan 2011 13:51:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTi=iMJv+Jtj8YdYhQ_sxu+jBht5YqvSnkS2LUerz@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165705>

Hi again,

Felipe Contreras wrote:
[out of order for convenience]

> Anyway, I don't think we can set argv[1] to NULL, because it's
> possible that this is "char *argv[1]", so that would crash.

The original argc is at least 1 (to include "merge" as argv[0]) before
the args are shifted by parse_options_end.  But probably that is too
tricky to rely on.

> Sure, I need to add documentation and tests. I should probably have
> sent this as 'RFC'.

No problem.  Thanks for keeping the topic alive.
