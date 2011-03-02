From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] gitk: ensure quoted tag names in event bindings
Date: Tue, 1 Mar 2011 23:47:05 -0600
Message-ID: <20110302054629.GB27567@elie>
References: <20110227224024.3751.96676.reportbug@pcfelipe.sateler>
 <20110301013841.GC5597@elie>
 <87tyfmqu1x.fsf_-_@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	Felipe Sateler <fsateler@debian.org>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Wed Mar 02 06:47:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pueu5-0001JT-Q9
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 06:47:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751853Ab1CBFrM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2011 00:47:12 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:54630 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384Ab1CBFrM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2011 00:47:12 -0500
Received: by vxi39 with SMTP id 39so4928975vxi.19
        for <git@vger.kernel.org>; Tue, 01 Mar 2011 21:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=hAtFCcCcj6qiNeWaT3f4Dkm21Z0rcP916ovmw5hkk24=;
        b=Nv18tOjB1t7J6eQ6QwLhJpgS+qFe86AqB5LP1lAr4GshTLwZJ5fC92KuswpZOMIDn9
         7U0pPlUIjw4s3k5uBZVW7XaAFvSo78LxP/1udjs6up5vMdT9XX9SCip3kIWBJYT1H8MJ
         7tyrSnRlmfLn0KSH8YITysCtphrxsJHugLYQo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=eq5XtxTA+Fb24ZA6mX+9XQMZ75fK8IgsypUwjmI03EtZpL/9r6yhZbH8XSyjc19rwK
         8z97cjkM/pvJyxbIlbPu1G2O96VZlSTZiFeE5ebuYd54h8CSsLc2xAm7GunF2JJ/tZxa
         f2Oo9ABsa8WOtRK1zSSxslxHtvRteCychllIE=
Received: by 10.52.164.168 with SMTP id yr8mr12829232vdb.16.1299044831327;
        Tue, 01 Mar 2011 21:47:11 -0800 (PST)
Received: from elie (adsl-76-206-235-173.dsl.chcgil.sbcglobal.net [76.206.235.173])
        by mx.google.com with ESMTPS id h18sm3995754vbr.4.2011.03.01.21.47.08
        (version=SSLv3 cipher=OTHER);
        Tue, 01 Mar 2011 21:47:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <87tyfmqu1x.fsf_-_@fox.patthoyts.tk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168293>

Pat Thoyts wrote:

> Tag names that contain a % character require quoting when used in event
> bindings or the name may be mis-recognised for percent substitution in
> the event script.
> 
> Reported-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
[...]
> 
>  gitk |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)

Thanks, makes sense (and seems to work).
