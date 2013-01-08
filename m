From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] add warning for depth=0 in git clone.
Date: Tue, 8 Jan 2013 00:14:01 -0800
Message-ID: <20130108081401.GB5722@elie.Belkin>
References: <1357632422-5686-1-git-send-email-stefanbeller@googlemail.com>
 <50EBD453.9050101@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	schlotter@users.sourceforge.net, Ralf.Wildenhues@gmx.de,
	git@vger.kernel.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Jan 08 09:14:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsUKK-0005t0-6G
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 09:14:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754555Ab3AHIOI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2013 03:14:08 -0500
Received: from mail-pb0-f52.google.com ([209.85.160.52]:50137 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754300Ab3AHIOH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 03:14:07 -0500
Received: by mail-pb0-f52.google.com with SMTP id ro2so97274pbb.11
        for <git@vger.kernel.org>; Tue, 08 Jan 2013 00:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=5BafisDITWukJo7t2pDyW261NIpEsMA/kYedgvLSFrc=;
        b=wbem6MwrPIb4nPsunSLRoxEQ4aLWa0Q2pBV3Ut8LPxrWelmZIZGA53x4JjSv0lVQmo
         S4EjISByFQmgEM6gMVKthWKCWiMJ3Ba81zNVzJEhwg4FUF2EGehO/sSWdbQOzRVZ3SMW
         zyIjp5h9PluiCxWUx/SYaC65x2gz+Yk4Akd1PP7NPCyNGpvxmnNdHeEbVPPX612WBnwN
         wpEWwR3h2vi8jSC4lpL9bJHO2Z2duWk9xB483H7azyKcTyXbmURIp8NJQsRKpnYspZYI
         WEw5GaqUr0xp6ZRuz+N6AB2V5KRACPid+2QdyXs+G4C3StC/Rf8IGL6bw6wC8NApJIWn
         jSUQ==
X-Received: by 10.68.232.169 with SMTP id tp9mr195637003pbc.1.1357632846600;
        Tue, 08 Jan 2013 00:14:06 -0800 (PST)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id mt15sm39210121pbc.49.2013.01.08.00.14.04
        (version=SSLv3 cipher=OTHER);
        Tue, 08 Jan 2013 00:14:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <50EBD453.9050101@googlemail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212949>

Stefan Beller wrote:

> I am struggling a little with the development process,
> is a sign-off strictly required for git as it is for kernel development?

Yes.  Documentation/SubmittingPatches has more hints.

> Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
>
> This adds a warning and the previous patch adds the documentation.

Thanks for your work on this.
