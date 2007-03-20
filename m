From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: GIT v1.5.1-rc1
Date: Tue, 20 Mar 2007 09:37:38 +0000
Message-ID: <200703200937.39440.andyparkins@gmail.com>
References: <20070306063501.GA24355@spearce.org> <7v7itcd8mk.fsf@assigned-by-dhcp.cox.net> <20070320025539.GA28922@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>, Bill Lear <rael@zopyra.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 20 10:37:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTamv-0002st-AZ
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 10:37:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933454AbXCTJhp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Mar 2007 05:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933416AbXCTJhp
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Mar 2007 05:37:45 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:21288 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933454AbXCTJho (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2007 05:37:44 -0400
Received: by nf-out-0910.google.com with SMTP id o25so272999nfa
        for <git@vger.kernel.org>; Tue, 20 Mar 2007 02:37:43 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=GZuvKzPaxQwHkZOHtMeFSOQWVdcQC1qUtL4A66NvD0/8w6ahbjmUfRwdrI5amgC3LeAZ/Nst7dHCKKL2cQO7M0RyVhTghGyqrLld9V2iuN58FSv1dHrcyGmBQBlN10eChBFGt8eox9m3BgdKGgzIavvU8soL/1mbKDjfezg40Eo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=tHgU/aosq2VdC36wsCPAitW8sc7foTY08Ofm4hyInu9k0ujXgbN9Kw6/4SrHTiGB1HYp9a9GiNbLntJGyEw6ZbhZp6No4eMXsmTpPWA9M+whgYr7bvjhBWQZM+1Mi4oG0TRimutsGnObzk467JrXPvFkHefTI+IV30ZkUkeRk28=
Received: by 10.78.106.3 with SMTP id e3mr2925336huc.1174383462912;
        Tue, 20 Mar 2007 02:37:42 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id d2sm1307977nfe.2007.03.20.02.37.41;
        Tue, 20 Mar 2007 02:37:41 -0700 (PDT)
User-Agent: KMail/1.9.5
In-Reply-To: <20070320025539.GA28922@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42733>

On Tuesday 2007 March 20 02:55, Shawn O. Pearce wrote:

> I was hoping Andy or one of the other folks who have worked on
> that hook would pick up the ball and update the hook, but I

I'll be delighted to port the hook script - I've got some fixes that haven't 
been nicely stacked yet.  The problem I have for porting the hook is as you 
point out:

> think they are stuck on the fact that you cannot use:
>
> 	git log $new --not --all

> That almost needs a --all-except="refs/heads/a refs/heads/b" option
> to rev-list.  Grrrr.

I'm afraid so.  Would a --ignore list be more appropriate?  That way you could 
list any refs you wanted (i.e. not just --all) and then have that list 
finally filtered by --ignore.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
