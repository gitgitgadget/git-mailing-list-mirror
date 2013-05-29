From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/4] remote-helpers: rename tests
Date: Tue, 28 May 2013 21:50:09 -0500
Message-ID: <51a56ce142986_807b33e18100084@nysa.mail>
References: <1369449507-18269-1-git-send-email-felipe.contreras@gmail.com>
 <1369449507-18269-3-git-send-email-felipe.contreras@gmail.com>
 <7vmwrezx7n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	David Aguilar <davvid@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 04:53:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhWVw-0000V4-Rp
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 04:53:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759420Ab3E2CxU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 22:53:20 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:40298 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759366Ab3E2CxT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 22:53:19 -0400
Received: by mail-ob0-f170.google.com with SMTP id er7so9995822obc.1
        for <git@vger.kernel.org>; Tue, 28 May 2013 19:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=DmrKwb6Cxz+FcgtJpukdkxuBOsMHPO3j2h0fjAStXLY=;
        b=JRV0Rwc20nIShPO8uT0ewIiWBTgVg4O1043cU9Ai4c+UC32mJht/9tg2PciJIoghUZ
         bJiPzbMT8oa1AucUw2Ym8E6BJ0xDULEL/ETZIPPsv3Hp+4A1RlWKU0rTvwx6RnBS3uqE
         RVaVnP6vUBFIyunwKM6EcegKMcxaXkjFOlEolaWSNT4acPuT8vpzvDcUFqFjbk5dFZFo
         FYmP0cJZhcK/zXnIrZR1qPsfYMV9g9Cee1eadVQIiI7P8stEaJTw6Y3CMWr6HDeB2DaL
         KyvfTEP6JHruwY6gYDg/PgYiO0+9qhrM3Q3HulwUi7XM++XREwh4UAm3SsftT5VPym0k
         Wokw==
X-Received: by 10.60.79.68 with SMTP id h4mr437112oex.39.1369795999130;
        Tue, 28 May 2013 19:53:19 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id jw8sm38008225obb.14.2013.05.28.19.53.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 May 2013 19:53:18 -0700 (PDT)
In-Reply-To: <7vmwrezx7n.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225704>

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > The .t extension is more standard for sharness tests.
> >
> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > ---
> 
> Is that "sharness" test the sh script testsuite forked from our
> testsuite?
> 
> I do not see how it makes sense to copy how they deviate from us
> back to our codebase, especially if we plan to eventually move some
> of these tests out of contrib/ area, but even without such a plan in
> the future.

They deviate from us, we deviate from them, whatever. We are a single project,
what more than one project does is more standard.

% man prove

--ext             Set the extension for tests (default '.t')

-- 
Felipe Contreras
