From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: should Documentation/howto/setup-git-server-over-http.txt be
 marked obsolete?
Date: Fri, 22 Oct 2010 10:06:27 -0500
Message-ID: <20101022150627.GB9224@burratino>
References: <AANLkTimJe9vEUwWM482NLmfHGYjnsKD5RAryQO=Zyqjj@mail.gmail.com>
 <7vsjzyrh2w.fsf@alter.siamese.dyndns.org>
 <AANLkTinv3kzvtC_Pq4F0cM_JqU7-Q2a=sWs8YSxbMiPs@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 22 17:10:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9JGC-0003MU-88
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 17:10:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757068Ab0JVPKR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 11:10:17 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:45069 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756914Ab0JVPKQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 11:10:16 -0400
Received: by eye27 with SMTP id 27so1118189eye.19
        for <git@vger.kernel.org>; Fri, 22 Oct 2010 08:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=s68FT5evsRqHwboSfTy7kJTE2x6ayCVmuikEot2Bsrk=;
        b=I1DCm1Lsl2atpYLvM1n0DJhgTw8jzVkNUdGLtbMQzPHusY9DPm0FUxNNqNBtcn2EUt
         /rp0cp2G+w+MqClfNJebkQRqYu+FP1sp0w9oCpTEe4sw7Nq2NNEyOYpEL3pbK7UG1wRW
         ZyGfVnJN/jPleOXZh7ozcXPdcOyppE+2xMab4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=rNcYbr6OPHTdioUXag52Lfq9XyI1hmJaQhr0HK7vLJUx10RuOyyqdeMfYCZBwJRjB2
         uzetbrg0yJD2+sBHSF4L57Um+YMDIhOBNhcMuaadigvNP1cgjefNkYazfffxAsySU14n
         amIYLu5e89vtUM1lD5gkrZONiTbRF651vPv/U=
Received: by 10.14.37.10 with SMTP id x10mr2248325eea.32.1287760215082;
        Fri, 22 Oct 2010 08:10:15 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id w20sm3393139eeh.0.2010.10.22.08.10.13
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 22 Oct 2010 08:10:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTinv3kzvtC_Pq4F0cM_JqU7-Q2a=sWs8YSxbMiPs@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159695>

Sitaram Chamarty wrote:

> I assumed that the new -- much more efficient (correct?) transport
> would make the older (dumber) transport obsolete, and I didn't realise
> it had any advantages over the new one.

FWIW the old transport still has its place.  If your web host (e.g.,
an ISP) allows only static content (no CGI), then there is no choice.

Not so relevant for gitolite but still relevant in the world.

Hope that helps,
Jonathan
