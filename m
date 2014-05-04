From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: pull.prompt or other way to slow/disable 'git pull'
Date: Sun, 04 May 2014 15:54:10 -0500
Message-ID: <5366a8f2c6095_18f9e4b30811@nysa.notmuch>
References: <20140502190746.GJ28634@odin.tremily.us>
 <5363ee55ac2af_70ef0f30cf3@nysa.notmuch>
 <20140502194637.GL28634@odin.tremily.us>
 <5364015a94900_135215292ec28@nysa.notmuch>
 <20140502211305.GN28634@odin.tremily.us>
 <53640bc1ee6eb_135215292ec95@nysa.notmuch>
 <20140502220107.GO28634@odin.tremily.us>
 <53641a1be8d24_1c7bdcd2f049@nysa.notmuch>
 <20140503000530.GP28634@odin.tremily.us>
 <5364bbfc8c0a0_ac68dd308ce@nysa.notmuch>
 <20140504185145.GQ28634@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org
To: "W. Trevor King" <wking@tremily.us>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 04 23:04:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wh3ak-0006y3-PD
	for gcvg-git-2@plane.gmane.org; Sun, 04 May 2014 23:04:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752631AbaEDVEx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2014 17:04:53 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:33557 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752534AbaEDVEw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2014 17:04:52 -0400
Received: by mail-ob0-f171.google.com with SMTP id wn1so2802588obc.2
        for <git@vger.kernel.org>; Sun, 04 May 2014 14:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=HUhF1EgZxipADqFY2R114aOYMAUlGE2BnKqXSlAQz5Q=;
        b=eCx1f8a9l8rWtTpW6fUrVlMfMsD5Syj6ZxwKue+9RwEClW1VrtRjevHVeh8yrnEHnA
         YPoJESLpVIDjjkcH+ibVZm9wLNVzoY/ye5clHSs7kxFS5wzNJk5GX2SADztpgEZQrbHK
         Ru8wPo1oxrGQ06SVmJ5BxUu6MucnIEfYVezkdz9s+L0jksfEU+r0QM3blOANfI70jiRU
         Maq/SWzuO5whFlkqoqaDywkBx808/9gi8iQfgwlm6HO/aYC90QGzljQBz1tZ/ZhyHJKh
         00z7AjjPjyX1DWRVANlprBDK/TNV+CM/24E7BGq6CM8es3D062tspVC6ggQDazdkSzYL
         pvZA==
X-Received: by 10.182.248.131 with SMTP id ym3mr3529756obc.58.1399237492037;
        Sun, 04 May 2014 14:04:52 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id ci10sm28128115oec.0.2014.05.04.14.04.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 May 2014 14:04:50 -0700 (PDT)
In-Reply-To: <20140504185145.GQ28634@odin.tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248113>

W. Trevor King wrote:
> Do you feel folks won't need a way to slow/disable 'git pull' while
> they build the ff options and their project's recommended workflow
> into their own practice?

That's right.

> Or do you agree that they will need some kind of helper for the
> transition, and just feel that git.prompt is the wrong helper?

I feel helpers are good when we are transitioning from an established
Git behavior to a new one. Or when the operation is potentially
dangerous.

But a fast-forward merge is not dangerous, an in fact it's what the vast
majority of people would want.

Even more, I'm now feeling confident I will be able to put a proposal
that allow a simple configuration to fulfill the need of these users
without affecting anyone else negatively.

-- 
Felipe Contreras
