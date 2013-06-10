From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/2] rm: introduce advice.rmHints to shorten messages
Date: Mon, 10 Jun 2013 13:56:45 +0530
Message-ID: <CALkWK0kzGDrAqTL6dY65OD9Q0ax+nqGULsABqgMzEEXga52XqA@mail.gmail.com>
References: <1370680434-2709-1-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr>
 <1370680434-2709-2-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr>
 <CALkWK0==9aN1wVoSXENvTJHOT8bd2SYrEFxrmTdhzMxB3mHPCQ@mail.gmail.com>
 <19969d9996306bf0e7ac6351d4ad435d@ensibm.imag.fr> <CALkWK0n+yF-kRahgsQQuT-+QiT5gy=J_Bdati=uooiW0djQrgw@mail.gmail.com>
 <vpqvc5mqspn.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?Mathieu_Li=C3=A9nard=2D=2DMayor?= 
	<mathieu.lienard--mayor@ensimag.fr>,
	Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
	git@vger.kernel.org, gitster@pobox.com,
	Jorge Juan Garcia Garcia 
	<Jorge-Juan.garcia-Garcia@ensimag.imag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 10 10:27:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlxRr-0000ph-8n
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 10:27:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752503Ab3FJI10 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 04:27:26 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:62842 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752384Ab3FJI10 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 04:27:26 -0400
Received: by mail-ie0-f176.google.com with SMTP id ar20so13163635iec.21
        for <git@vger.kernel.org>; Mon, 10 Jun 2013 01:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=e15Nsx1FTVUnwuIx5D6M1zmyfUIRFoABZiCXRtmGJ2w=;
        b=CtbHmYjTYAtXb7Z8J9rWPyz1Y/yUlcYXQMemPnjXwJjYcdjvno2O17/BtZusi1vgMJ
         4HxHQYSmp8n7r8X6ioSJbsGiHceWWmRfZtENl4kYxpR2sdEqAjF5xEFWNAczhUzV8qnB
         +e/voVr6fZ0R8i0eNYnQmG4vYDTX5x256Gh8/pbjG8sBm5xnA15Z/MX8rTFzS3UnE2Zf
         TCAyauWjDUbuielsVH1IaTr7znfCLciBWZzA6EfTyi6N/JZ9OMiAL5hnQlBnywgQpYQP
         f37fhvEGK3fbdy7PB/Ly7BLbR6+1rbuT+GqN4TCoiNeHFPUSF3GmwafbVbgejmjujRZy
         lcGA==
X-Received: by 10.50.98.104 with SMTP id eh8mr3493891igb.111.1370852845668;
 Mon, 10 Jun 2013 01:27:25 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Mon, 10 Jun 2013 01:26:45 -0700 (PDT)
In-Reply-To: <vpqvc5mqspn.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227259>

Matthieu Moy wrote:
> I don't see why add and rm hints should be correlated, or I don't have
> the same advice as you in mind.
>
> Both have completely different meanings: the first is about .gitignore,
> and the second about not loosing data.

Right, my bad.  Please continue with rmHints, and optionally write an
addHints while at it.
