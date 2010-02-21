From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH 3/7] http-push: remove useless condition
Date: Sun, 21 Feb 2010 11:40:15 +0100
Message-ID: <20100221104015.GB5166@localhost>
References: <1266721708-1060-1-git-send-email-rctay89@gmail.com>
 <1266721708-1060-4-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Mike Hommey <mh@glandium.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 21 13:08:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nj9Ef-0006RW-HO
	for gcvg-git-2@lo.gmane.org; Sun, 21 Feb 2010 11:40:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755455Ab0BUKkV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2010 05:40:21 -0500
Received: from mail-fx0-f213.google.com ([209.85.220.213]:40745 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754875Ab0BUKkU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2010 05:40:20 -0500
Received: by fxm5 with SMTP id 5so1541258fxm.29
        for <git@vger.kernel.org>; Sun, 21 Feb 2010 02:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=TEKrxvlyhNFYT5fS4XZ5BSCihNBnqlGJumazzNvRIUE=;
        b=wRK5DzFo72LPPw6eFa2Ny+MioWxci5C7GRgvasLFOOxCAHYFM1Ou+BwDXJX5QjCE0x
         Zp1Y8YdPQLgGBDB275qLrtMLlLFQ7RN98RqlSzoCVJ11rcf1nxfLEq55OQ7mrpCXniV+
         GGla1YG74AsXF00yO5yiTuOPAoxA3Q0OuZuVY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=pLISqfpRwxJON98vyNjqQDnv2cPu0dZ5yM5YMBvW18zEpXZQrqooKvvg3p9RV2eVXP
         AYsEXCEl1nXjm/adLjcW4zNbbBsKt2qMiIUVKDKmSVoWqxHXuWak8qTZqIubMdqrLQZ7
         Dbhu42t8s/KYq4eL8lwn8q/gSahUXoursEH8U=
Received: by 10.103.84.30 with SMTP id m30mr688385mul.22.1266748818534;
        Sun, 21 Feb 2010 02:40:18 -0800 (PST)
Received: from darc.lan (p549A7DE9.dip.t-dialin.net [84.154.125.233])
        by mx.google.com with ESMTPS id 23sm9733259mum.33.2010.02.21.02.40.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 21 Feb 2010 02:40:18 -0800 (PST)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1Nj9EV-0001pR-86; Sun, 21 Feb 2010 11:40:15 +0100
Content-Disposition: inline
In-Reply-To: <1266721708-1060-4-git-send-email-rctay89@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140609>

On Sun, Feb 21, 2010 at 11:08:24AM +0800, Tay Ray Chuan wrote:
> -			if (push_verbosely || 1)
> +			if (push_verbosely)
>  				fprintf(stderr, "'%s': up-to-date\n", ref->name);

Just a minor nit-pick. If you end up doing a resend, maybe you could change
the commit message to this one, since you're actually adding a condition
that was previously disabled, not removing it.

Clemens
