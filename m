From: Robert Buck <buck.robert.j@gmail.com>
Subject: Re: [PATCH] WIP: begin to translate git with gettext
Date: Mon, 17 May 2010 19:29:58 -0400
Message-ID: <AANLkTikkfD_mfBz3mEpu_lP5heB-22QtI6FZP2eZ_C1g@mail.gmail.com>
References: <20100517160503.GA12717@unpythonic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Dmitry Potapov <dpotapov@gmail.com>, Jan Hudec <bulb@ucw.cz>,
	Thomas Rast <trast@student.ethz.ch>,
	Marc Weber <marco-oweber@gmx.de>
To: Jeff Epler <jepler@unpythonic.net>
X-From: git-owner@vger.kernel.org Tue May 18 01:30:48 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OE9lk-0002pY-1J
	for gcvg-git-2@lo.gmane.org; Tue, 18 May 2010 01:30:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755218Ab0EQXaF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 May 2010 19:30:05 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:44880 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756691Ab0EQXaA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 May 2010 19:30:00 -0400
Received: by wwi17 with SMTP id 17so89554wwi.19
        for <git@vger.kernel.org>; Mon, 17 May 2010 16:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=SgGaZyxbXNtu0i4AtuB3wRB9s7e3nmLATmyayQ7gvcI=;
        b=NAE8mVnugJW6uXOYKEwJwlkjzf2QMC9MO9bbqPrj2E2qJ7gAurWriVo8Lm+Ny4HQFU
         uDPcXogeLK94HcOVG+2J3d4/uPvqqEyA9IsRxPrcqHWRg0unr4uxH+n9zJrbjuC7JKqY
         jlU8pm7iJJkaC9tDa9mmNiKW+ISpwRBLllArM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=QBGa9QCTT9mNg6sdf5r2RCGjeAqlVcRJ6SWrzRaxF+4ihTcFc13YFYrjuF7WB8FyS5
         NN2aNnqfL5ilSjrLGhRMS6h1FLXw2chbonuGvu59+X6H5cl02vbbTRqYpZ5lMQVlPzuo
         1RuQ2ybIyNJLzqSH8hPW2N71CBIr3glJ/dWAM=
Received: by 10.216.158.65 with SMTP id p43mr3632071wek.50.1274138998663; Mon, 
	17 May 2010 16:29:58 -0700 (PDT)
Received: by 10.216.7.207 with HTTP; Mon, 17 May 2010 16:29:58 -0700 (PDT)
In-Reply-To: <20100517160503.GA12717@unpythonic.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147265>

Is gettext portable? Or is it only POSIX? If it's not portable, have
you considered using ICU instead as it is the best of class solution
for I18N/L10N?

That's my 0.02.

-Bob
