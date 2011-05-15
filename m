From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 6/7] update git-stage.po
Date: Sat, 14 May 2011 22:44:09 -0500
Message-ID: <20110515034408.GA28245@elie>
References: <1305292458-3920-1-git-send-email-okano.osamu@gmail.com>
 <1305292458-3920-7-git-send-email-okano.osamu@gmail.com>
 <7vtycy7d9z.fsf@alter.siamese.dyndns.org>
 <BANLkTi=u4_vbTjDyL1JNAz06=R_1XUikvA@mail.gmail.com>
 <20110514192154.GA17271@elie>
 <7vd3jkr6ms.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Osamu OKANO <okano.osamu@gmail.com>, git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 15 05:44:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLSFf-0007S2-Q4
	for gcvg-git-2@lo.gmane.org; Sun, 15 May 2011 05:44:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759882Ab1EODoP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 May 2011 23:44:15 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:47116 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755496Ab1EODoP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2011 23:44:15 -0400
Received: by iyb14 with SMTP id 14so2969339iyb.19
        for <git@vger.kernel.org>; Sat, 14 May 2011 20:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=gqAIQ5NY1R/9uwttvYKkCF2Ic8PYVJwJMTLd4Xm8C/c=;
        b=BXtB3+A7X6foX/P++tSMAEgDe3QqNyABbxy8mv4u81A8T9jNX8aMgeIIm0zCWxF9N7
         GKt3W8utSrnozjjU5pTaKW9i/aKkTb1wwWhvTBPsAHOzWDaXPs1pysJBzhoiFVRIj/er
         X7njTSm8njB3RIiW8Jay1Q8dmViUg10Zfoz1I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Ah/wCzd5aZqA4oyo2ZIGzrcFw5mjcN8DGvc6wFRHkU62gNgGnaT6hlc+viJ9qmmytg
         cx1LAUhPETU3tbfwJHkdGwqpmwwcohGhm8iTwn6qxXwZuf3y9mg0JxWl1zUsD+DJj3p2
         YjhaV6GT7qEz1EcBZk3KyLyIVsUI1GRdZCIPM=
Received: by 10.43.135.8 with SMTP id ie8mr3621791icc.508.1305431054441;
        Sat, 14 May 2011 20:44:14 -0700 (PDT)
Received: from elie ([69.209.56.134])
        by mx.google.com with ESMTPS id y10sm1621326iba.46.2011.05.14.20.44.12
        (version=SSLv3 cipher=OTHER);
        Sat, 14 May 2011 20:44:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vd3jkr6ms.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173618>

Junio C Hamano wrote:

> I would rather see that done as a customized content-level merge backend,
> i.e. at the same level as binary and union merges are specified. Losing
> line number information just for the sake of the generic merge that does
> not have domain knowledge (read: "stupid") is a way suboptimal solution to
> the problem, I would think.

Oh!  You are definitely right.  Thank you.
