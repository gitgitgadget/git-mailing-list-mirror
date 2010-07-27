From: Will Palmer <wmpalmer@gmail.com>
Subject: Re: [PATCH 2/3] checkout, commit: remove confusing assignments to
 rev.abbrev
Date: Tue, 27 Jul 2010 21:18:56 +0100
Message-ID: <1280261936.4462.6.camel@walleee>
References: <19531.65276.394443.190317@winooski.ccs.neu.edu>
	 <20100725130935.GA22083@LK-Perkele-V2.elisa-laajakaista.fi>
	 <20100725221539.GA21813@burratino>
	 <7vbp9uaii2.fsf@alter.siamese.dyndns.org>
	 <20100726190448.GA32367@burratino>
	 <7vzkxc7rpn.fsf@alter.siamese.dyndns.org> <20100727182942.GB5578@burratino>
	 <20100727183706.GD5578@burratino>
Reply-To: wmpalmer@gmail.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Eli Barzilay <eli@barzilay.org>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 27 22:19:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdqcI-0007pe-Hn
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 22:19:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752624Ab0G0UTF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jul 2010 16:19:05 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:50826 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751853Ab0G0UTD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 16:19:03 -0400
Received: by wyf19 with SMTP id 19so3475147wyf.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 13:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=lqye0w/DxDzmAk0oKw4RLt6SN3nxifWvOUwjKAhMlAg=;
        b=anymv1KpFys0VlUO/DqLHolT9aOFLwAAfbKRFvXPgv22k/Xksz0CkcFJ/MLZowLbSu
         QjT2XAD0xzspY54Kab8dJ1GvOwFx4Pu34J5Z3KBL9aggrxvqAfHpDhFCOfYcpeFUndki
         mLaRwUnBr2s0AsUTzSewCya8XTUiggEncz3oI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=CAZj0g3nvAaRlONOxdIqLSEs4XDkyUJ7PDgxUIqyD4FSG/QZMMWER2Bakyd/syrLPo
         zGTGofErTu9GC9Dl3suRfNtVVnNyYOrb1gs8mKGwCTJLxvqtYSOj2EV4Hdv+TyGilry8
         pZB/5Cp7YefpA4rzUlhbGZCOCInWHjHbaw6S4=
Received: by 10.227.145.208 with SMTP id e16mr9409084wbv.164.1280261940583;
        Tue, 27 Jul 2010 13:19:00 -0700 (PDT)
Received: from [192.168.0.3] (5acc3a9a.bb.sky.com [90.204.58.154])
        by mx.google.com with ESMTPS id u32sm2981327weq.11.2010.07.27.13.18.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 Jul 2010 13:18:59 -0700 (PDT)
In-Reply-To: <20100727183706.GD5578@burratino>
X-Mailer: Evolution 2.26.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151983>

On Tue, 2010-07-27 at 13:37 -0500, Jonathan Nieder wrote:
...
> v1.7.1.1~17^2~3 (2010-05-03) taught the log --format=%h machinery
> to respect --abbrev instead of always abbreviating ...
...

I've been seeing this phrasing throughout this discussion, and at first
I thought it was merely a poor choice of words, but now I feel I must
ensure it's clear:
the purpose of the patch was to respect --abbrev instead of always
abbreviating to a minimum of 7 characters. /Not/ to respect abbrev
"instead of always abbreviating". Perhaps armed with that phrasing, a
more general solution, such as equating "0" with "DEFAULT_ABBREV" rather
than "no abbrev", could be applied?

-- 
-- Will
