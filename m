From: "Harvey Harrison" <harvey.harrison@gmail.com>
Subject: Re: tracking renames
Date: Tue, 4 Mar 2008 14:03:54 -0800
Message-ID: <590657100803041403q2cc68e21p1c92c244939eb148@mail.gmail.com>
References: <20080304135734.b2c2f473.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Andrew Morton" <akpm@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Mar 04 23:04:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWfFc-00089d-9g
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 23:04:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933268AbYCDWEF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 17:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933149AbYCDWEE
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 17:04:04 -0500
Received: from gv-out-0910.google.com ([216.239.58.186]:21843 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933003AbYCDWEB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 17:04:01 -0500
Received: by gv-out-0910.google.com with SMTP id s4so770331gve.37
        for <git@vger.kernel.org>; Tue, 04 Mar 2008 14:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=AGZ4WmwUsAgXYzYoQmIqfSDMhh5VNqowZe9+bQo7ltA=;
        b=kMX48hPAB3YpFCd7Lmo+xOojsi4qm62unxxrqhyYb47dHV5LyFqXPnWFKIJTWsTnNtYtmyfoUt2fc4ye97LG2ujVHl1z2SiLjnRqogZPXZ551MY4E2OxHrA9tQOGl1KL96AskNTN86GEvGmxO3tv9FuCjoX49Oc7ryzUS2fRErg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tVJmBRzVFP8w9Aujibu0K7OBzM4Chm4jbSUbnmpJ4bcFTsqwvpOTAiufnwSCDrSjmKz3DnGKVKDS0A4pjHgIA143PmDPrPUqoDmXyBO+Qt9rPIAFiNk/UQqA3UV5MdAuV00cH/n7l/p7PB4iJspopkfQlGwn8pnqSCFWcIwX4xI=
Received: by 10.114.60.19 with SMTP id i19mr3022134waa.142.1204668234885;
        Tue, 04 Mar 2008 14:03:54 -0800 (PST)
Received: by 10.115.22.2 with HTTP; Tue, 4 Mar 2008 14:03:54 -0800 (PST)
In-Reply-To: <20080304135734.b2c2f473.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76145>

On Tue, Mar 4, 2008 at 1:57 PM, Andrew Morton <akpm@linux-foundation.org> wrote:
>
>  When I do
>
>         git-whatchanged drivers/watchdog/iTCO_wdt.c
>

git-whatchanged --follow drivers/watchdog/iTCO_wdt.c

Cheers,

Harvey
