From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] let core.excludesfile default to ~/.gitignore.
Date: Fri, 20 Nov 2009 10:50:57 -0800
Message-ID: <20091120185056.GB56351@gmail.com>
References: <1258723430-31684-1-git-send-email-Matthieu.Moy@imag.fr>
 <4B06A7EE.2090801@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"gitster@pobox.com" <gitster@pobox.com>
To: Stefan Naewe <stefan.naewe@atlas-elektronik.com>
X-From: git-owner@vger.kernel.org Fri Nov 20 19:51:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBYZy-00079y-Qc
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 19:51:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755179AbZKTSvO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2009 13:51:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755169AbZKTSvJ
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 13:51:09 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:38529 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753718AbZKTSvH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2009 13:51:07 -0500
Received: by fxm21 with SMTP id 21so4006872fxm.21
        for <git@vger.kernel.org>; Fri, 20 Nov 2009 10:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=KYOEAW5rHPzBX3iAUoUfe5WDHxHbpU0T1AacATL7puI=;
        b=QtzlZxu4Z54byyhxMow3W2lIKHIP258gUN/1Knpd1VyTxbI4Nq6aFQQclUU1Bnqdl3
         zBxjD0PRylTA7VOAcylPobsDba+23hE0fkOAz6JvTpxoDATYwS6n0irMfLAEsAlLbVvP
         qFQfGzbPnaNu4kt+2kqPAEJh2xOy0m9iLQvm8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=FAKKwWi215BovD24gQjcKX5/Idn/0nqmWCQpjOrRq/lDlso58A9gMGrmMv+exhe+8w
         9sAzlghELZKx/JOK+ifoZdWworEMwOJnol1YRYpUWFFoagA1BRU9BIyyhtcAggc7YDxf
         EIAGYOexe/2ZX5egELE2CnPx4trYCMfVOg15Y=
Received: by 10.216.88.85 with SMTP id z63mr514973wee.129.1258743072529;
        Fri, 20 Nov 2009 10:51:12 -0800 (PST)
Received: from gmail.com (wdas-1.disneyanimation.com [12.188.26.1])
        by mx.google.com with ESMTPS id t12sm3287062gvd.20.2009.11.20.10.51.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Nov 2009 10:51:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4B06A7EE.2090801@atlas-elektronik.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133363>

On Fri, Nov 20, 2009 at 03:30:06PM +0100, Stefan Naewe wrote:
> On 11/20/2009 2:23 PM, Matthieu Moy wrote:
> > It seems this is the value most users set, so let's make it the default.
> 
> I like the idea but would suggest to use ~/.gitexcludes instead.
> That way it doesn't clash with .gitignore if your $HOME is 
> under git-control.
> 
> Regards
> 
> Stefan

I second this.  I also keep my $HOME in git.


-- 
		David
