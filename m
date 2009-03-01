From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] send-email: confirm auto cc before sending
Date: Sun, 1 Mar 2009 19:09:15 +0100
Message-ID: <fabb9a1e0903011009s6f89b680mf732843fab233358@mail.gmail.com>
References: <7d1d9c250902281732m7293330bt108b70a850dc5cb9@mail.gmail.com>
	 <1235879630-39439-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 01 19:10:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ldq7l-0008K4-Cd
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 19:10:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756929AbZCASJT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Mar 2009 13:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756890AbZCASJT
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Mar 2009 13:09:19 -0500
Received: from mail-fx0-f176.google.com ([209.85.220.176]:64802 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752932AbZCASJS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2009 13:09:18 -0500
Received: by fxm24 with SMTP id 24so1702110fxm.37
        for <git@vger.kernel.org>; Sun, 01 Mar 2009 10:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=oOBn9kEJz1v967sgyKGN3zbk3C2iSWPJs6VcZ9mdJok=;
        b=wjq3pdQhjWX0omQnvGe8KpjivNL9oR26/B72ZojXHm02oJ0vCef7NAFKfWn1sqNBea
         ZK60LcNS1ag7dC5fSqzt7zOq65b0PZ1lfXUhzMVrWI/uyiMn80A2FgIekcxfI71/KCsC
         6wANYQvzLmH/XNtYg/GJei355TPBbQC2LK5ZU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BuWLFvNgzWDgbb3bE3XZesblLUQJqtiltLkRsHegj4317JA1i8DPXdodm05DkOkab+
         iePcMEvB4D5yyh7Dq3544Rr9Zl0P6oJlnO5qIm31XxIC4i08Ydyx97CoxP1/nVf546Fw
         4g46KI/QDnUpwDjdNSbFCL43S50QiB8ycYRIs=
Received: by 10.103.212.2 with SMTP id o2mr2490011muq.69.1235930955654; Sun, 
	01 Mar 2009 10:09:15 -0800 (PST)
In-Reply-To: <1235879630-39439-1-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111867>

Heya,

On Sun, Mar 1, 2009 at 04:53, Jay Soffian <jaysoffian@gmail.com> wrote:
> Untested patch, just soliciting ideas.

With a config option to turn it on permanently this would be very nice
to have. It personally annoys me that it decides who to cc (I already
do that manually, thank you very much).
So, FWIW, I like this idea :).

-- 
Cheers,

Sverre Rabbelier
