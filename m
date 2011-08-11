From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] t3900: do not reference numbered arguments from the
 test script
Date: Thu, 11 Aug 2011 02:11:55 -0500
Message-ID: <20110811071155.GA28213@elie.gateway.2wire.net>
References: <20110321105628.GC16334@sigill.intra.peff.net>
 <cover.1300872923.git.git@drmicha.warpmail.net>
 <20110324082108.GA30196@elie>
 <20110808011341.GA19551@elie.gateway.2wire.net>
 <20110808011709.GC19551@elie.gateway.2wire.net>
 <4E40F3EA.8020406@viscovery.net>
 <20110809153638.GA15687@sigill.intra.peff.net>
 <4E437F4C.4020305@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Aug 11 09:12:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrPR6-0005V6-JC
	for gcvg-git-2@lo.gmane.org; Thu, 11 Aug 2011 09:12:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752904Ab1HKHMI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Aug 2011 03:12:08 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:45358 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754589Ab1HKHME (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2011 03:12:04 -0400
Received: by iye16 with SMTP id 16so746151iye.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 00:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=kumMBeOQm3qi/imgpR9skKzZ1AkZtCShOGrSkdTJtUQ=;
        b=ZbAFtF31lf5TQxjwtt4r18uK1egnbpV5Qrn2ODUYcka6/5452DkgMnpklT+XuPzTyF
         K7yAksN9ZWuCEGQWvvWprxXotflFz1qCn8W/Ml/zasxq7DhUQ+RX26yUS1IGNsYKT4PW
         zZPBQuPXUGFOsrQ1L+p+UZkzRgPvlYFYaz3P4=
Received: by 10.43.131.201 with SMTP id hr9mr9184338icc.376.1313046724273;
        Thu, 11 Aug 2011 00:12:04 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-69-209-69-68.dsl.chcgil.sbcglobal.net [69.209.69.68])
        by mx.google.com with ESMTPS id o8sm2690657icc.5.2011.08.11.00.12.03
        (version=SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 00:12:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4E437F4C.4020305@viscovery.net>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179088>

Johannes Sixt wrote:

> Remove it because -m is optional and the test case
> does not check for it. There are tests in t7500 that check combinations of
> --squash and -m.

That's a comfort.  Looks obviously good to me, fwiw.
