From: Howard Miller <howard@e-learndesign.co.uk>
Subject: Re: Mysterious junk in file.... "not commited yet"
Date: Mon, 5 Apr 2010 20:29:29 +0100
Message-ID: <x2n26ae428a1004051229hf238c770tc4875df83e96a639@mail.gmail.com>
References: <i2v26ae428a1004051113q68a0cf13o65fbf1349f941648@mail.gmail.com>
	 <o2n32541b131004051152ie6c82b3wdab0f38a9e657943@mail.gmail.com>
	 <p2y26ae428a1004051203jbb7c838eh8de0cb5f6ae1dcb1@mail.gmail.com>
	 <vpq8w91r9bo.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Apr 05 21:29:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyrzN-00009p-Cb
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 21:29:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755775Ab0DET3c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Apr 2010 15:29:32 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:33645 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753638Ab0DET3b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 15:29:31 -0400
Received: by fxm27 with SMTP id 27so1300586fxm.28
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 12:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:received:message-id:subject
         :from:to:cc:content-type;
        bh=c3FoiZr49U/A3bTc9gqIs0S7VtkHle7qsWM1/WhMQZU=;
        b=tqKCab4wekg6JBZEIxLVDqIZSwWeBQ2UJicQGQrhSCuOAzjINn20Gx8rmPFI6v61vu
         WljjLULqPRN9alUX4I2BM30xKVR8N3x9XTKyoTFBnZz9Cje+WvXdjD7dalmr3qq3rO2D
         uTSGsMxFZNrBQSmoiwUbA1FFflIFUxRv1ZgJ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=WcfiG8yYVRUKvmcLNv6+kmSaiV3RSjaUop0WRCTIycNZbZPCCI8gZFUXPxczOo/rws
         moKCodtOk9fQJ5CNB148NmhFiRty/edPixkXiZ8EJ/WbXK76tEh9D9JoA+fJMm8jiqQs
         ycTkENmG3KL6Q0KhadH5ARubDQZ0YC42z55gQ=
Received: by 10.239.160.143 with HTTP; Mon, 5 Apr 2010 12:29:29 -0700 (PDT)
In-Reply-To: <vpq8w91r9bo.fsf@bauges.imag.fr>
X-Google-Sender-Auth: 5cb75b3b5c6434a3
Received: by 10.239.137.69 with SMTP id k5mr502402hbk.214.1270495769368; Mon, 
	05 Apr 2010 12:29:29 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144054>

> Plain "git checkout" will read from the index, while "git checkout
> HEAD" takes the last commited version.

Cool.... that's the bit I hadn't appreciated. I was (falsely) under
the impression that 'git checkout' grabbed the last committed version.
Suitably educated... thanks!
