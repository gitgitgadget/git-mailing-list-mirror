From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/5] rebase: improve the keep-empty
Date: Tue, 28 May 2013 22:01:36 -0500
Message-ID: <51a56f90e3b41_807b33e18100220@nysa.mail>
References: <1369747757-10192-1-git-send-email-felipe.contreras@gmail.com>
 <CANiSa6haWGOjpydxX-B9W1ZGAANAJ5Wi5_sLqedQwGCSTu86nA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Martin von Zweigbergk <martinvonz@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 05:04:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhWgO-0000tV-8d
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 05:04:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759464Ab3E2DEH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 23:04:07 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:52724 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753075Ab3E2DEG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 23:04:06 -0400
Received: by mail-ob0-f171.google.com with SMTP id ef5so9953693obb.30
        for <git@vger.kernel.org>; Tue, 28 May 2013 20:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=r0bmiL0dCBBqtjXbjCsDI1o4GB7jnDd4lYD0qIJd5+E=;
        b=tP+dVTlxfC9ftGij6L8BJrZNQTU/lqU0MnVpon0kxvYID9WWlazrHIzKe2aF9A5yas
         rUJCVhXpXeFBJ2MtVs/lDOufXLH4WHYyNijyJeGlfAUnxp6u8wMo9aTpblHIfzsWA86q
         tRHJeYtKifLqfP6eZRgvLZczTD2TDrmLKW/x91ESZNfXudtUaOOVGBEN5xAoRnQOSrQZ
         /sbqpycgwsbX1RCAmTOyWc/ae5ntn812j3H10oHVSdKYvOTiqZUO7X4ty7kYWukxtjo9
         /XIL8NbjvqlYKVgZtr6xq4HyF4bKBAn8F0JJ1UYoOnnJO012Pk6uxw1hAuekSwbpQv9W
         /Ddg==
X-Received: by 10.60.50.202 with SMTP id e10mr425569oeo.42.1369796646202;
        Tue, 28 May 2013 20:04:06 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id jw8sm38049000obb.14.2013.05.28.20.04.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 May 2013 20:04:05 -0700 (PDT)
In-Reply-To: <CANiSa6haWGOjpydxX-B9W1ZGAANAJ5Wi5_sLqedQwGCSTu86nA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225707>

Martin von Zweigbergk wrote:
> I think I have some patches at home that instead teach 'git am' the
> --keep-empty flag. Does that make sense? It's been a while since I
> looked at it, but I'll try to take a look tonight (PST).

I think it does make sense. But I still would prefer 'git rebase' to rely on
'git cherry-pick' primariliy.

-- 
Felipe Contreras
