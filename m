From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Fix a formatting error in git-merge.txt
Date: Fri, 29 Oct 2010 10:57:43 -0500
Message-ID: <20101029155743.GA28839@burratino>
References: <4ccaebae.e91dec0a.1ac5.ffff8876@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: "Nathan W. Panike" <nathan.panike@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 17:58:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBrL9-0007GC-55
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 17:58:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934107Ab0J2P55 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Oct 2010 11:57:57 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:47664 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932832Ab0J2P54 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 11:57:56 -0400
Received: by gyg4 with SMTP id 4so2050874gyg.19
        for <git@vger.kernel.org>; Fri, 29 Oct 2010 08:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=PCGBnvwM6i3uqt7U29/sJI2xEkuj5mBRjXe8+KAdyUQ=;
        b=qbUbzP7y98TXO8k5AO/J60Z5PCwcRvQgOlyRLTJefIYPbVKBtlVWBjMVTIgNF5riU1
         T2Rtv6g/NynXy+8rvQQwXJzquQVV8aJF6//vy95dOe+54r10jMZJbTRXkBhb7ZrfmaaV
         tarjhftA5B23wKmkzQeQYCAeXg/2il+HPygzg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=IZxmCEL85s3+7JFBahDScNgt9Pg3rFRznlCM2EpXPCToH6bjUtYjtiBsTRW6pXoRIO
         FD4/jE+dScIAHarm3M7uT4WvyI4jWwLea2lEhXW7FrUZVVTMS9uCd6FIqzIylwoezEDq
         AauVd6yt7i4NjLiHNGBjroMn//OrRC20A95Sw=
Received: by 10.42.211.201 with SMTP id gp9mr9577524icb.278.1288367876048;
        Fri, 29 Oct 2010 08:57:56 -0700 (PDT)
Received: from burratino ([68.255.106.176])
        by mx.google.com with ESMTPS id s26sm885504vcr.37.2010.10.29.08.57.51
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 29 Oct 2010 08:57:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4ccaebae.e91dec0a.1ac5.ffff8876@mx.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160335>

(+cc: Ram, Junio)

Hi,

Nathan W. Panike wrote:

> Signed-off-by: Nathan W. Panike <nathan.panike@gmail.com>
> ---
> Without this patch, the lines below get set in typewriter mode, which
> just looks wrong.

This part belongs above the "---" line, so future generations can
learn the reason for the patch (and thus avoid undoing it when
considering future changes).

>  Documentation/git-merge.txt |   14 +++++++-------
>  1 files changed, 7 insertions(+), 7 deletions(-)

Thanks.  The patch proper looks good to me.

Regards,
Jonathan
