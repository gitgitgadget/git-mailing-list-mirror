From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [PATCH] fix uninitialized variable in string_expand_length
Date: Sun, 8 Feb 2009 10:58:38 +0100
Message-ID: <2c6b72b30902080158t569ac25er3eb725035d4550d2@mail.gmail.com>
References: <20090207103723.GA18823@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 08 11:00:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LW6SN-0000JI-3P
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 11:00:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752901AbZBHJ6l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 04:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752890AbZBHJ6l
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 04:58:41 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:58765 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752801AbZBHJ6k (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 04:58:40 -0500
Received: by fxm13 with SMTP id 13so2062802fxm.13
        for <git@vger.kernel.org>; Sun, 08 Feb 2009 01:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=zpjfK62Xzd6EL9f6sweMWcEIDYvMfzaOEtDvMeMAowY=;
        b=mde8QqfspO62p9ZC6GoWzYjuAULo3yv9FNQ3zywB5O0srnQQ6+yShn/UBY8qerzPf/
         Hwtaep8OaMUqh/gGv7sB6MfL7VWUKB5e4iBcz+XraeNE8rEPBsZRPtA+1Nn1imh8tfZa
         /R5CF0Iv5dtLcXDPc8YmTEc7P27m4HnFCF4oU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=Udmtr6Zdm6ijw+O8E3vgAWwfpdR7RHTZlYcDZRo9ewOVPoGxGjyGlfMKlHnUz2Li1x
         Ri3f3z8R3oFotxHxep2z8S7qWntWyGrWdYrcDK4fpJKoS+SIIApaQpi+WXBL1t0Ga6nF
         CzGUtbXTmG48rPW16gUxayQiQBjVJUJ4hsEWs=
Received: by 10.180.241.8 with SMTP id o8mr1351264bkh.102.1234087118629; Sun, 
	08 Feb 2009 01:58:38 -0800 (PST)
In-Reply-To: <20090207103723.GA18823@coredump.intra.peff.net>
X-Google-Sender-Auth: 9458423f09cd29ae
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108943>

On Sat, Feb 7, 2009 at 11:37, Jeff King <peff@peff.net> wrote:
> This led to totally unpredictable results from the function. The style
> matches the loop in string_expand.

Oops, thanks.

-- 
Jonas Fonseca
