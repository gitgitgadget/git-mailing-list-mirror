From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] mergetool-lib: call vim in readonly mode for diffs
Date: Sun, 27 Feb 2011 14:33:54 -0800
Message-ID: <20110227223350.GA37866@gmail.com>
References: <20110224203412.29b732b9@glyph>
 <227c6e4e11ce964a6e6898afb422d424d46a7b50.1298626494.git.git@drmicha.warpmail.net>
 <7v62s7anp0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	netuse@lavabit.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 27 23:34:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtpC3-00029o-Ah
	for gcvg-git-2@lo.gmane.org; Sun, 27 Feb 2011 23:34:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751927Ab1B0WeS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Feb 2011 17:34:18 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:57666 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751886Ab1B0WeR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Feb 2011 17:34:17 -0500
Received: by iwn34 with SMTP id 34so2606754iwn.19
        for <git@vger.kernel.org>; Sun, 27 Feb 2011 14:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Soheu49iEFNnQ7GBrLL4Jxf59SHCIk1/tbhUwV3Kqps=;
        b=t7F3V2plunUYz6OTHZbYJ498BauazM58yZvlTJP74xz2K6G1ADzWOWn4xQ3cA2sMKD
         4FTsq3JZ4YK7oAapaKEQAb4ZsqZvdliSHCfSIhqty71PEXK5FzZOfcJkQx6lSMkCY1cd
         siGAK7nJK7p6v5v3eqiLMZA5M/dviCjCp6+BU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=IQbSfHz+yj2LxKmOaQ9CQOJOErTYI2POGrD6O8Cqim+e9IiboZyklNKhjwPnJB/f7b
         zAdklgWnT3dz7nLj1vxvN0OnxuxidEqLtPMS3sy9Au/hzsep5X83JyxV5m8N2SV+UXPs
         R3Vye01awfDSwTOKWpF8oorz+2wLdpAErKR2E=
Received: by 10.42.175.65 with SMTP id az1mr4051673icb.192.1298846057161;
        Sun, 27 Feb 2011 14:34:17 -0800 (PST)
Received: from gmail.com (h-66-134-235-242.lsanca54.static.covad.net [66.134.235.242])
        by mx.google.com with ESMTPS id uf10sm947720icb.5.2011.02.27.14.34.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 27 Feb 2011 14:34:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7v62s7anp0.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168058>

On Fri, Feb 25, 2011 at 12:01:15PM -0800, Junio C Hamano wrote:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
> > When [g]vimdiff is called for files which are opened already, the editor
> > complains about the existing swap file. But we do not want to write
> > anything when called from difftool. So, make difftool use "-R" for the
> > vim family.
> 
> Makes sense.  Maint-worthy?

I think this would be good in maint.
thanks,
-- 
		David
