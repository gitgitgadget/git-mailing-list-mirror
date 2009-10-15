From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: linkify author/committer names with search
Date: Thu, 15 Oct 2009 13:41:34 +0200
Message-ID: <200910151341.36520.jnareb@gmail.com>
References: <1255486344-11891-1-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 15 13:50:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyOqX-0005F2-GP
	for gcvg-git-2@lo.gmane.org; Thu, 15 Oct 2009 13:50:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935133AbZJOLng (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2009 07:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935110AbZJOLnf
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Oct 2009 07:43:35 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:23370 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934559AbZJOLne (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2009 07:43:34 -0400
Received: by fg-out-1718.google.com with SMTP id 16so435188fgg.1
        for <git@vger.kernel.org>; Thu, 15 Oct 2009 04:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=N7XmZ3uwIFOGamKEY96/l251dMitaZQb/bd1C1ZtPks=;
        b=H6F+QpalR/MvRDl0VtNmfzOzC9WDTTw4261BZEi/A1uXInxMcME6ZHx+s2MV4dX+Tr
         8Nbv7JwJLmcI7Hj84uW4k0zzs3939myaDh0Vz7wIj4JW+PapC498pUAh8ZQhfB1WbnG+
         yPcUQULT6ADcBlmoyoLEmy3CUDP9vf16TNg3E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=MsDGIZ+9BnzUOc/XVF/KC2qRrToi8Yj0F2RaIeXVTx4szvErY8E8oRvDgh0XwusTEq
         jMGueU1/MBF7Nv3MU0mwYEP1qiK4FL8OPUjvSd6evYpV965aL4pfx04tCNhUyl7WFqjk
         BtvohTvnmer74aUbqD2Essc+LXVeG4zAcExHQ=
Received: by 10.86.254.17 with SMTP id b17mr42658fgi.65.1255606906878;
        Thu, 15 Oct 2009 04:41:46 -0700 (PDT)
Received: from ?192.168.1.13? (abvx49.neoplus.adsl.tpnet.pl [83.8.221.49])
        by mx.google.com with ESMTPS id d4sm1639976fga.16.2009.10.15.04.41.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Oct 2009 04:41:45 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1255486344-11891-1-git-send-email-bebarino@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130388>

On Wed, 14 Oct 2009, Stephen Boyd wrote:

> It's nice to search for an author by merely clicking on their name in
> gitweb. This is usually faster than selecting the name, copying the
> selection, pasting it into the search box, selecting between
> author/committer and then hitting enter.
[...]

I see that it can be useful.  But is this discoverable, and does this
do expected thing?  Most of links in gitweb lead to some view (page)
that is specific to link; other lead to anchor on same page.  Leading
to search results can be unexpected.

Perhaps title explaining what does such link does would help?  Or making
style of this link distinct from other (dashed underline, dashed 
underline on mouseover, double underline, different mouse cursor on
mouseover, etc.)?

Just my 2 eurocents.  Feel free to ignore my ramblings.

-- 
Jakub Narebski
Poland
