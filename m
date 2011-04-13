From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] revert: Hide '-r' option in default usage
Date: Wed, 13 Apr 2011 18:51:49 +0530
Message-ID: <20110413132146.GB26760@kytes>
References: <1302449954-15353-1-git-send-email-artagnon@gmail.com>
 <7vhba4v6p8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 15:22:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QA01u-000649-E3
	for gcvg-git-2@lo.gmane.org; Wed, 13 Apr 2011 15:22:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753858Ab1DMNWm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2011 09:22:42 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:49853 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752901Ab1DMNWl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2011 09:22:41 -0400
Received: by iyb14 with SMTP id 14so579909iyb.19
        for <git@vger.kernel.org>; Wed, 13 Apr 2011 06:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=pS77hpOWYuccxNtPHzBHj+qxQvJnhb7PETo10sccPZk=;
        b=ekt590xCwvKdYr8PZ1zI/haXHHjMa/gbMi4qIr9viiWWRbPiq3EEqkx6l2niGJLBVT
         vUoYDDBGLQ+ktnnnw2Q/jvmVNo/rgmz/7gEmpthdzZzbjsCB3e/Bh4AM10D3QHmftJkA
         aDyItRv1DnI14yPE1GBvaC4/6OrSTHSt6iRAk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=OLWHhqX1sDiIc+VSXTBZiTVjBArgpygAUbuBO/w3Az7pOi9POi06DfswSkk8vDmvIY
         sc847w0UeduvfIlSBc6YDmOehIJb+axsw0my04QNF8udr+zXrBKwZaKVSTxeBKJQYMCh
         NOW7HFjo3XjvwmYWed/BE+HHu1noqNstsqfn0=
Received: by 10.43.54.133 with SMTP id vu5mr1442018icb.36.1302700960817;
        Wed, 13 Apr 2011 06:22:40 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id o3sm439541ibd.44.2011.04.13.06.22.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 13 Apr 2011 06:22:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vhba4v6p8.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171456>

Hi Junio,

Junio C Hamano writes:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
> 
> > Since the '-r' command-line option is a no-op provided only for
> > backward compatiblity, don't advertise it in the default usage.
> >
> > Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> > ---
> 
> Thanks.
> 
> It would have saved me a lot of time if you wrote that this option has
> been a no-op since abd6970 (cherry-pick: make -r the default, 2006-10-05),
> but the commit didn't remove it from the usage string, and it somehow
> survived 9509af6 (Make git-revert & git-cherry-pick a builtin, 2007-03-01)
> and later f810379 (Make builtin-revert.c use parse_options, 2007-10-07),
> and it is about time to stop advertising it.

Thanks.  I didn't realize there was so much history to write about.
Has you queued this somewhere?

-- Ram
