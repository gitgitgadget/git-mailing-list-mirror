From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: fsck --full is Ok, but clones are not, "missing commits"?!
Date: Wed, 16 Apr 2008 21:15:47 +0400
Message-ID: <20080416171547.GE3133@dpotapov.dyndns.org>
References: <200804161626.44174.brian.foster@innova-card.com> <a537dd660804160804t252d2900j33e30a01dc58979c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Brian Foster <brian.foster@innova-card.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 19:27:45 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmBFa-0003Jo-3i
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 19:16:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755631AbYDPRQF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2008 13:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755812AbYDPRQE
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 13:16:04 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:54458 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755631AbYDPRQB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 13:16:01 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1352514ywb.1
        for <git@vger.kernel.org>; Wed, 16 Apr 2008 10:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=32484UggnGDOxrHXS6/8Au7Y81sLTFRlk9ER6YUrib4=;
        b=gv4k4W77T4SXbu09jMwzvyH5AqeWvFj1/+uGwDS1oPbi44JWqvglfj16cqN+sr8VJhgMkzGvn8dUEBSr0bCE82Nepy7NRt47tY9C4rDUAIRciLvEfEJhXlFh+ju9eIzDm/3kkANGNNCaeXJGB3JiP+Z2q+uprPhOn1z1iiLk/9c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=NEuXCa3FlZEOr0OUMhVgp48LseSN1fOTmtq/cEqgQJqQqv4lI3E9rJwZeo+9AXNzZtJJSVG8dXnabeTQlPpArizfihu9Pnoi4nK04dx3sdZJYJm6WZ87MS6VgwwfvlsK6avLLU76nx8Ja8TZNAr9j+fTPJBPllfeaScSdGdENic=
Received: by 10.150.201.13 with SMTP id y13mr431982ybf.100.1208366156148;
        Wed, 16 Apr 2008 10:15:56 -0700 (PDT)
Received: from localhost ( [85.141.188.158])
        by mx.google.com with ESMTPS id 7sm778511nfv.18.2008.04.16.10.15.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 Apr 2008 10:15:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <a537dd660804160804t252d2900j33e30a01dc58979c@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79720>

On Wed, Apr 16, 2008 at 05:04:56PM +0200, Brian Foster wrote:
> 
>  in the later case, the  info/grafts  still existed at the end,
>  and `fsck --full' was happy.  (I suppose this isn't surprising
>  since the filter-branch was not happy.)   moving  info/grafts
>  out of the way caused the same complaints from `fsck --full'.

Do not remove info/grafts. Just clone this repository after
filter-branch and then the _newly_ cloned repository should
be fine.

Dmitry
