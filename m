From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Supporting hashes other than SHA-1
Date: Tue, 12 May 2009 05:55:43 -0700 (PDT)
Message-ID: <m3vdo6lbuy.fsf@localhost.localdomain>
References: <20090511195242.GA14756@foursquare.net>
	<m3zldjl5bq.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Chris Frey <cdfrey@foursquare.net>
X-From: git-owner@vger.kernel.org Tue May 12 15:04:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3reI-0007qT-Ct
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 15:03:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751989AbZELNDp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 09:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751956AbZELNDp
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 09:03:45 -0400
Received: from mail-px0-f123.google.com ([209.85.216.123]:55879 "EHLO
	mail-px0-f123.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751678AbZELNDo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 09:03:44 -0400
X-Greylist: delayed 481 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 May 2009 09:03:44 EDT
Received: by pxi29 with SMTP id 29so107483pxi.33
        for <git@vger.kernel.org>; Tue, 12 May 2009 06:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=RWqaqQ2bQmGt+viKTQZp76jHaMfcOJ1Bl52EnIdRTNo=;
        b=HPM3jSrpRsEWMG84mznl54ZUdYzZy8nfPDFT9qXVZ2aMf+YWOimpUVGfeJo6UapPwH
         Mec2iVF3g50VyefhmC20j72UiBdsmpIQLgMTM2kcEP4nVmxV4yL4SdILgNU5eHVI6atC
         qJanQIIGAjZePY5Ba5kGo8ioSX6vOIXpL2hRY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=fGx7olaiIFgV2JxByH4DA4maJDkiig2lHyV37aK+nLVLQ43Tv/7CaOVg+ePdNJjz2I
         07re90ZzbjTrp63XI2he0nX59pR44eB1TUVW21RoT20efqOsTap/jQfsQ6eAoogqGvL8
         8tgxNGapNgGYKiM4M5bnQiEvHKRPkYCKg1mic=
Received: by 10.115.107.5 with SMTP id j5mr6550115wam.158.1242132944698;
        Tue, 12 May 2009 05:55:44 -0700 (PDT)
Received: from localhost.localdomain (abvp65.neoplus.adsl.tpnet.pl [83.8.213.65])
        by mx.google.com with ESMTPS id m26sm9484575pof.0.2009.05.12.05.55.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 12 May 2009 05:55:43 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n4CCtPKs028538;
	Tue, 12 May 2009 14:55:28 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n4CCtH44028534;
	Tue, 12 May 2009 14:55:17 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <m3zldjl5bq.fsf@localhost.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118892>

Jakub Narebski <jnareb@gmail.com> writes:

> Chris Frey <cdfrey@foursquare.net> writes:
> 
> > Considering the recent news regarding SHA-1's newly found weaknesses,
> > is there any general interest in making git flexible enough to support
> > other hashes in the future?
> 
> First, there isn't as far as I know any 'known preimage' attack
> against SHA-1, and only that would truly matter for Git.
> 
> Second, this issue was discussed in depth in the past; check git
> mailing list archives, please...

See also this blog entry (and comments):
  http://kitenet.net/~joey/blog/entry/sha-1/

-- 
Jakub Narebski
Poland
ShadeHawk on #git
