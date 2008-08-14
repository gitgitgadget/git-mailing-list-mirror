From: Marcus Griep <marcus@griep.us>
Subject: Re: [PATCH 1/3] Git.pm: Add faculties to allow temp files to be cached
Date: Thu, 14 Aug 2008 10:35:22 -0400
Message-ID: <48A442AA.8090505@griep.us>
References: <489DBB8A.2060207@griep.us> <1218470035-13864-1-git-send-email-marcus@griep.us> <1218470035-13864-2-git-send-email-marcus@griep.us> <7vwsikds99.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 14 16:36:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTdwF-0000mb-VT
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 16:36:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbYHNOf2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Aug 2008 10:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750995AbYHNOf2
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 10:35:28 -0400
Received: from wr-out-0506.google.com ([64.233.184.225]:16594 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888AbYHNOf1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 10:35:27 -0400
Received: by wr-out-0506.google.com with SMTP id 69so559313wri.5
        for <git@vger.kernel.org>; Thu, 14 Aug 2008 07:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=4EyMJJut75Y/8eHYm7GHMhC/DOca7yvA0Mc7Oyki+5M=;
        b=gcYIEs4qGKfYBdVgY5jQcPysKKiqLFPQA2RaSWpRF/V6aeUYUCYOmI0TRajiRQNBgw
         Ka7tYXpR2XZ6JbpSZiees+khmqGD1hjneIOjPOWKpJmf1EysF2lhoMSO6u7VOmFu+430
         CUlzjvjfRbqORDqSaeNdu/J76eAuUbqGGbQCE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding:sender;
        b=NTC/m3nLgIM/Yf6Uzh5BbAEnGwRb4gFIQB+pEoEmtFTgEPmLCdW0ImT2lWCWT9LEpk
         dxlPE8Gqj8ALfg/snMH+B38Yu2pvrm/MIvpklEbPY+5YL2TL59kb5t8LMro2xh1GPB24
         4TFrrNH1I0gNLI0Ia2PLrObYYiQ8BJJI4//Sk=
Received: by 10.90.90.4 with SMTP id n4mr1922874agb.117.1218724526109;
        Thu, 14 Aug 2008 07:35:26 -0700 (PDT)
Received: from ?192.168.1.3? ( [71.174.65.78])
        by mx.google.com with ESMTPS id p60sm1917831hsa.14.2008.08.14.07.35.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 14 Aug 2008 07:35:25 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <7vwsikds99.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92364>

Junio C Hamano wrote:
> By the way, I think your commit title has a typo: s/cul/cili/.  I've
> already pulled this via Eric, so it will stay in the history forever,
> though...

Actually, I meant faculties.  While in common use faculty is
usually meant as a body of teachers, the primary definition is
"An inherent power or ability".  Adding the caching of temp files gave
Git.pm another power or ability, hence a new faculty.

The caching mechanism itself is also a facility that can be used by
others, and, of course, would also apply. :-P

--=20
Marcus Griep
GPG Key ID: 0x5E968152
=E2=80=94=E2=80=94
http://www.boohaunt.net
=D7=90=D7=AA.=CF=88=CE=BF=C2=B4
