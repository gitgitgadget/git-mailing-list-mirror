From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: create easy to parse list of added / ,odified files
Date: Fri, 3 Sep 2010 01:39:17 -0500
Message-ID: <20100903063917.GA13519@burratino>
References: <i5q524$9fc$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gelonida <gelonida@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 03 08:41:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrPxn-0002OK-BI
	for gcvg-git-2@lo.gmane.org; Fri, 03 Sep 2010 08:41:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752823Ab0ICGlW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Sep 2010 02:41:22 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:37249 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752124Ab0ICGlW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Sep 2010 02:41:22 -0400
Received: by yxp4 with SMTP id 4so523623yxp.19
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 23:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=vETNBxZtgxf+bSEM8dc/luJza+xwotqXhBwyfnKRYwg=;
        b=sh/2JqOdrNm8ARQPFHmT7ZEfikSPpQZopt6/aqTPeD6kc5x2iSVF8yWi+LSUBC3RFX
         PFvOUyUzd/473eh4pVXCwlKJGkmtaduPEuU24ms/tBw9N0H75zlBG9UPWlkGQiHf0qEV
         RXRLGZBEPMSiodLJLS1XYGPhDbKYNHaMMJ7NQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=F54v6tv9sbJqw+q3uU8WukTsaafxfdjpJxmamJ6fTjZgGOiDBj2Lev570h+O2BYjVN
         qZvo9o0Hm30JWytatdDz/wlVuwSn8AvJz+kU4NzA0A0vUB5v3eB8DfdxfYEwQADMS9T1
         l00pgPEGCstX7sk62TXABZuqorJ00Y+19BDo0=
Received: by 10.150.182.8 with SMTP id e8mr68263ybf.424.1283496081413;
        Thu, 02 Sep 2010 23:41:21 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id t20sm3112956ybm.5.2010.09.02.23.41.20
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 02 Sep 2010 23:41:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <i5q524$9fc$1@dough.gmane.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155237>

Hi,

Gelonida wrote:

> for a pre-commit trigger I would like to retrieve the list of modified
> files, such, that I could analyze the contents prior to commit.
> 
> what would be the best command for this
> 
> 
> I thought about using "git status", but wondered, which other command
> might return a nicer to parse list.

If you look at the git(1) man page, you will find a number of such
"low-level (plumbing) interrogation commands" listed.  For example:

 . git diff-index
 . git diff-files
 . git update-index
 . git status --porcelain

Hope that helps.
