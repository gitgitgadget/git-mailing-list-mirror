From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 00/29] Yet more preparation for reference backends
Date: Thu, 28 Apr 2016 21:14:34 -0400
Organization: Twitter
Message-ID: <1461892474.4123.27.camel@twopensource.com>
References: <cover.1461768689.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 03:14:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avx10-0004Og-Bc
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 03:14:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752755AbcD2BOi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 21:14:38 -0400
Received: from mail-qg0-f51.google.com ([209.85.192.51]:36288 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752159AbcD2BOh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 21:14:37 -0400
Received: by mail-qg0-f51.google.com with SMTP id d90so37203870qgd.3
        for <git@vger.kernel.org>; Thu, 28 Apr 2016 18:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=5vZBfMJtLPvZZnen6NpTQJuiweMMmFVKBYmXXVac5Dg=;
        b=1YbcoYvWohRhn+UnlqhsvC4HCJaGG6lbC3wA7Sx5P/5FgqCnC/RwWSaFPaN6MVfUdn
         DLFx8No5Ct/GyUFvdH7aBxj0fYSLsFSxygkVkVigx+6EdIWq2/MY2/9GgH880G23dVXC
         P0n7KGIu5gL5S+NNz08XD8JGKBR2rtGqtX8yGwu5I3K0dGJ3w7qijijCdavpxkgTaYNL
         Y52nmpNCGiDKB8U1l2rPye5HusDxxGtMsuGLHQBB6f3fiAI6+AOz6f35QriplH0COjkB
         ojSg84J3/hU0VNHC6Ob6wV0Dw7sEAwgXHDA3Gj/x1SsqLohlUonjIp5xAFpUBhkD4UOK
         xYEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=5vZBfMJtLPvZZnen6NpTQJuiweMMmFVKBYmXXVac5Dg=;
        b=dpwJ52sGuznV+CluJnnAAfqNLfEoA4Ecxs2GgQWeQlQ/dR0ZIif7xaAXvmwEx3ujye
         i4aJepOvPScGLuvnqksZchBgHnFR014FYAT+QMb0WcPY70BpfVNpawRG8LZ6RhNk+Lzv
         prA0cEqBbo6+UA48FzV5wcsNBhdoz9DtFJo8Z745SriH8jhnIHD2cx39jN7RSovRZSlu
         rQcsxHVyigsveUrchrtka7scl5mhOs+QPdf48bOogqACJ68R1YlIaTPhN2zB1/wsaa2i
         HshhU84tRJcr8gKlySlb4dHghyc1ZN9zuGE2aNk1Yjq7hshmsJvkAtVbOk8BIoVENI/c
         QN/Q==
X-Gm-Message-State: AOPr4FXSNwUz3aJF9PWZD9Uvig7jR4foBqYqR0o7V2NQmNzRn6o/ich69+OrJS6mX6QaDQ==
X-Received: by 10.140.20.14 with SMTP id 14mr16799953qgi.66.1461892476237;
        Thu, 28 Apr 2016 18:14:36 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id v5sm3685133qhv.21.2016.04.28.18.14.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 28 Apr 2016 18:14:35 -0700 (PDT)
In-Reply-To: <cover.1461768689.git.mhagger@alum.mit.edu>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292965>

On Wed, 2016-04-27 at 18:57 +0200, Michael Haggerty wrote:
> This started as a modest attempt to move the last couple of patches
> mentioned here [1] to before the vtable patches. I wanted to do that
> because having real changes mixed with the vtable refactoring was
> making rebasing and stuff awkward.
> 
> But then it snowballed. A lot of what's new is pretty trivial (though
> in some cases fixes minor bugs). But a few of the later patches are
> pretty major.

Apart from the comments on one patch that I sent, this looks good to
me.  I'm a bit worried about the impact on lmdb (which doesn't do
"locking" the same way), but I think it will probably work out.  Since
Michael has been rebasing the pluggable-refs-backend code on top of
this, he's probably got a good sense that it doesn't do too much
violence to the plugin infrastructure.



> 
