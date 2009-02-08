From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv3 1/3 (resend)] gitweb: Modularized git_get_project_description to be more generic
Date: Sun, 8 Feb 2009 12:10:48 +0100
Message-ID: <200902081210.49328.jnareb@gmail.com>
References: <87zlgxp595.wl%seb@cine7.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Sebastien Cevey <seb@cine7.net>
X-From: git-owner@vger.kernel.org Sun Feb 08 12:12:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LW7aI-0001I6-3Q
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 12:12:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753295AbZBHLKz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 06:10:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753288AbZBHLKz
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 06:10:55 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:17696 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753240AbZBHLKy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 06:10:54 -0500
Received: by fg-out-1718.google.com with SMTP id 16so864834fgg.17
        for <git@vger.kernel.org>; Sun, 08 Feb 2009 03:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=7Aa5XDa0lUOPy9stjkDoe07LQ4HDpH2CAxxuVI0REf0=;
        b=XVqrSqh3MRKnG2c2353ZUcpxLUJ58FSvnD8harGyyMuPlWbqmKEeXnTAkwkF4RRWiQ
         ngfij/fDz3ug0Ph9TRoHGl+rwUD+fYx4AKInWPXBkj9Jk2XZSgVeDUZDu83HhBjn7szB
         5vDTdDhJKKFLgxkOw6miybXFd6DODZY8MyL74=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=OoEQ9f66RfdApaDeUxHl5B57cJHtkDQ6mq4OYxc5LFrPXZGRPXr+i2rYSwYBtPLEVA
         lEW7kA7va2kbiZTwhPP7VIpifM1HcCHGNsNjHIiEj7HU1q4IKH/3Rh1wf3Zaij5XmpXQ
         5psBanl0YMiBuZSVIqsYpbG5J6gqPIqXf8u58=
Received: by 10.86.72.15 with SMTP id u15mr1097175fga.8.1234091452855;
        Sun, 08 Feb 2009 03:10:52 -0800 (PST)
Received: from ?192.168.1.13? (abwm89.neoplus.adsl.tpnet.pl [83.8.236.89])
        by mx.google.com with ESMTPS id l12sm35252fgb.31.2009.02.08.03.10.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 08 Feb 2009 03:10:52 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <87zlgxp595.wl%seb@cine7.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108959>

Sebastien Cevey wrote:

[...]
> Sending this patch again. It has been rebased onto 621f1b so it should
> apply cleanly on the current git master branch.

Thanks a lot.

Due to changes to gitweb, while first patch in (earlier version of) 
series applies cleanly, second patch didn't, and git could not find
base to fall back to 3-way merge (because second patch is based on
state after first patch, and situation after first patch changed).
It is much easier to rebase series if youhave them as commits, and
not as series of emails.

-- 
Jakub Narebski
Poland
