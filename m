From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Supporting hashes other than SHA-1
Date: Mon, 11 May 2009 14:04:11 -0700 (PDT)
Message-ID: <m3zldjl5bq.fsf@localhost.localdomain>
References: <20090511195242.GA14756@foursquare.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Chris Frey <cdfrey@foursquare.net>
X-From: git-owner@vger.kernel.org Mon May 11 23:04:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3cgC-0004K8-W8
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 23:04:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758708AbZEKVEP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2009 17:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758435AbZEKVEO
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 17:04:14 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:39878 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757986AbZEKVEM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2009 17:04:12 -0400
Received: by fxm2 with SMTP id 2so2955359fxm.37
        for <git@vger.kernel.org>; Mon, 11 May 2009 14:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=kcri6PuG/Hf1WdiqNP62spB2vKZ6TneOcAwxstO2m+E=;
        b=TBZPSo5fcrPaR5UCjZp/q2nDI34taj592kCk37pRsfollbBXdGB3Jv0vnZQNG90F76
         ftgoOCnDgxFRtngzhtrM3ez5d0XISSZ0tKAPy97KtJNOII44+H3WCVi4c8nEyCCM8Z/T
         hsB2QQMbgSPm3SnP/K1RlpzAg3drqrhD58Qvc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=Z6BC06SgYsFVAessZXAKrtsJ2qzSBZSz5tJRGgB+lfW4tO4he2pDRj/IgqDDVwLU6h
         uWqVy+pNTMRBZ6TFLFXoOa+iMlg0R4HPQtg3pV/JxeQsjomJfUFOQ2Eo1pj1pFHhG7M1
         XMZJ9yBkf/toWZ3u3LmXJ7rQ9aWNyIQEYbVRA=
Received: by 10.86.59.2 with SMTP id h2mr6950145fga.30.1242075852076;
        Mon, 11 May 2009 14:04:12 -0700 (PDT)
Received: from localhost.localdomain (absh130.neoplus.adsl.tpnet.pl [83.8.127.130])
        by mx.google.com with ESMTPS id 3sm4006920fge.11.2009.05.11.14.04.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 11 May 2009 14:04:11 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n4BL4Bfs019161;
	Mon, 11 May 2009 23:04:12 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n4BL49oZ019158;
	Mon, 11 May 2009 23:04:09 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20090511195242.GA14756@foursquare.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118847>

Chris Frey <cdfrey@foursquare.net> writes:

> Considering the recent news regarding SHA-1's newly found weaknesses,
> is there any general interest in making git flexible enough to support
> other hashes in the future?

First, there isn't as far as I know any 'known preimage' attack
against SHA-1, and only that would truly matter for Git.

Second, this issue was discussed in depth in the past; check git
mailing list archives, please...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
