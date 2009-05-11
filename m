From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/5] gitweb: Some code cleanups (up to perlcritic --stern)
Date: Mon, 11 May 2009 03:33:51 +0200
Message-ID: <200905110333.52127.jnareb@gmail.com>
References: <200905100203.51744.jnareb@gmail.com> <7vy6t4sbxj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 11 03:33:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3KP1-0004Yz-3S
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 03:33:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756777AbZEKBdv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 May 2009 21:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756379AbZEKBdv
	(ORCPT <rfc822;git-outgoing>); Sun, 10 May 2009 21:33:51 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:33993 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752631AbZEKBdu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2009 21:33:50 -0400
Received: by fg-out-1718.google.com with SMTP id 16so835725fgg.17
        for <git@vger.kernel.org>; Sun, 10 May 2009 18:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=OjNQHAEDlehCBxSlKGm872LaJoLp1pR18LeGGgffwZI=;
        b=BCQHOJNE8/32J2SQBRPoBUq6Ci5qDmhewfHu4aTeyokR5izIWExHEmLmuIjVtNFhzO
         tcbTn0RMhdv0aXDvdhPonYvr9Td8hn9bDmqver6RhpDfaZMbspPP3OXHoxf7zyP8cZoU
         ZGSz4pkm+S1XpCyBzONEhebakVI8Yg2ree9DQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=E+4gj0esE8MVNxfPunUa54gfqp/koH7aBKVvcbg2qUr7oksoTDzzdIArUOQsCU6TF0
         tuqu4lsECol28aMr5SBKrME8RdZEKV6BEWFrU09KTdUwTvSL/c/PnMG6UHAyYGGk++Ue
         Lx43PHfIQwSlCkPlfC4HzWu+KZDBA/mbRceaI=
Received: by 10.86.65.18 with SMTP id n18mr5927857fga.25.1242005629845;
        Sun, 10 May 2009 18:33:49 -0700 (PDT)
Received: from ?192.168.1.13? (abvi64.neoplus.adsl.tpnet.pl [83.8.206.64])
        by mx.google.com with ESMTPS id 12sm5783839fgg.0.2009.05.10.18.33.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 10 May 2009 18:33:49 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vy6t4sbxj.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118768>

On Mon, 11 May 2009, Junio C Hamano wrote:

> But this series, when queued to 'pu', seems to break t9500; I haven't
> looked at the breakage myself yet.

I'm sorry about that. My bad. The fix is in the email (unless you
prefer for me to just resend the series)...

-- 
Jakub Narebski
Poland
