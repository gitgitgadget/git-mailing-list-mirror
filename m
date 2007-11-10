From: "Remi Vanicat" <vanicat@debian.org>
Subject: Re: [PATCH] Make GIT_INDEX_FILE apply to git-commit
Date: Sat, 10 Nov 2007 19:38:34 +0100
Message-ID: <6b8a91420711101038t3b2ca647v422f81d9365dd05d@mail.gmail.com>
References: <87abpml8rx.dlv@vanicat.homelinux.org>
	 <7vode2mljf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 10 19:39:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqvF1-0003NJ-BX
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 19:39:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751641AbXKJSih (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 13:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753833AbXKJSig
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 13:38:36 -0500
Received: from py-out-1112.google.com ([64.233.166.183]:2137 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751633AbXKJSif (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2007 13:38:35 -0500
Received: by py-out-1112.google.com with SMTP id u77so334146pyb
        for <git@vger.kernel.org>; Sat, 10 Nov 2007 10:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=Yz340yua7vJBnw22sV9JRzSbBQ2uCJl0Cu5qpNxqmk4=;
        b=gumBOSLLd17Hgw4BG1hpYUiFE+q4jVQiwwmvuKTdcXcCp6/AhZSNGV6Pqa84YcD8w5PfmDt+EFOsU2q2tmVR00h22SP/DuRS46pVkbJcYse77MRnia3iTQJlCEiUzzQtFtjwynxaa2Twjtw4z6Lc4mZ36siaiQf3tngSYRqAt3g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=DzXiqRoegb1Fm9j2eDbAMuXzISxFTXu1pzWLR6x0ICoAw9sdFRfTN90X7CtcVPwOPUUk37xqERbZhCMwqpOIPC5INP8eQafvplGcFsgXgi1DGhKz9PwQb7rydatZ1w8KjyfOmL6PrjfkcfT/r+46i6U177c7l/PgSjsW/5Y19VU=
Received: by 10.35.116.12 with SMTP id t12mr3683779pym.1194719914312;
        Sat, 10 Nov 2007 10:38:34 -0800 (PST)
Received: by 10.35.113.17 with HTTP; Sat, 10 Nov 2007 10:38:34 -0800 (PST)
In-Reply-To: <7vode2mljf.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
X-Google-Sender-Auth: a58370e37e6622b9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64364>

2007/11/10, Junio C Hamano <gitster@pobox.com>:
> Sounds sensible.  Tests?
>

all test pass
