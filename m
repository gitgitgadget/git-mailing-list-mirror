From: "Guilhem Bonnefille" <guilhem.bonnefille@gmail.com>
Subject: Re: [ANNOUNCE] ugit: the pythonic git gui
Date: Wed, 2 Jan 2008 11:42:51 +0100
Message-ID: <8b65902a0801020242x425b792xbfa5ee69a13c2573@mail.gmail.com>
References: <402731c90712281449g3d0c4f53w48c65dc8883bbbb3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 02 11:43:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JA14A-00082w-6c
	for gcvg-git-2@gmane.org; Wed, 02 Jan 2008 11:43:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754452AbYABKmx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2008 05:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754396AbYABKmx
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jan 2008 05:42:53 -0500
Received: from an-out-0708.google.com ([209.85.132.249]:44257 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754146AbYABKmw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2008 05:42:52 -0500
Received: by an-out-0708.google.com with SMTP id d31so963310and.103
        for <git@vger.kernel.org>; Wed, 02 Jan 2008 02:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=rFr30r+OYtAl69VoVckLTMgDx1gX5zt+tTD/4Vx7Cfk=;
        b=Irx+Z8jNOhwuAd0HDJW22iris447HC1a2b5Zp9nUyuKGeozNn+bg3vQamzrpi30snbDS9/FGsTR8gbzPgi0yO3ZgFKi1TcETG+axd7WlNazRrDavWPrLyfQoD8OvMfXQIllfOZdqVvS70ZAvh35HeLWFOongqaFmdt45CPxvtvs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=P2oytZEkzea4gu2ZtPEtRYP2WyCpoH8rVgcusCdTxXGhAnPnnp/AnGGnz0g2QzJweM0EAMuhjFm77Duj1SwkywthX+bNy3Fmca2+pUBLBPJcAOc3EsHmK7i2HH8AajwC44Thc0z30JMkCGIqSK7iQwT3FmB1lQx7hlc/kLCi0D8=
Received: by 10.100.248.9 with SMTP id v9mr29913437anh.19.1199270571039;
        Wed, 02 Jan 2008 02:42:51 -0800 (PST)
Received: by 10.100.247.15 with HTTP; Wed, 2 Jan 2008 02:42:51 -0800 (PST)
In-Reply-To: <402731c90712281449g3d0c4f53w48c65dc8883bbbb3@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69471>

Hi,

Good to learn a new GUI is available for Git.

But, for people like me, not enougth curious to install the software,
do you have any screenshots somewhere?

2007/12/28, David <davvid@gmail.com>:
> ugit, the pyqt-based git gui, has been taking shape as of late.
>
> First off, I'd like to thank everyone that replied with suggestions
> and criticism.  This list is extremely helpful with regards to
> providing honest software critiques.
>
> New features since the last announcement (almost all of which were
> mentioned in one way or another on this list):
>
> * inotify support (we've removed the "Rescan" button)
> * Patch hunk un/staging
> * Allows un/staging selected patch hunk lines (without --unidiff-zero)
> * Prepped for i18n ("env LANG=ja_JP ugit" looks pretty cool now)
> * I'm a westerner, so the unstaged list is now on the left and the
> staged list is on the right (thanks Jason)
> * Optimizations to improve the interactivity of the patch browser
> * Misc. fixes for MacOS and Windows (thanks Steffan and Sebastian)
> * Uses default system colors whenever possible [no more darkness] (thanks Alex)
> * No longer requires PYTHONPATH
>
> Source code (requires pyqt4-dev-tools to build):
> http://repo.or.cz/w/ugit.git
>
> Tarballs (require a stock pyqt-4.3 installation):
> http://ugit.justroots.com/
>
> I'll try and get some .deb, .rpm, etc. action happening soon.
>
> p.s.
> If you read ugit as "(f)uh-git" or "ugly-git", then that's good since
> I think that falls in line with the git style ;-)
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Guilhem BONNEFILLE
-=- #UIN: 15146515 JID: guyou@im.apinc.org MSN: guilhem_bonnefille@hotmail.com
-=- mailto:guilhem.bonnefille@gmail.com
-=- http://nathguil.free.fr/
