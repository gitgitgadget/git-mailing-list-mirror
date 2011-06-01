From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 1/1] git-am: provide configuration to enable signoff by default
Date: Wed, 1 Jun 2011 11:03:14 -0500
Message-ID: <BANLkTinorC17+21SA44Eg26GHERSpLb0Rw@mail.gmail.com>
References: <1306917751-27999-1-git-send-email-nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Sekhar Nori <nsekhar@ti.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 18:04:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRnto-0003un-1K
	for gcvg-git-2@lo.gmane.org; Wed, 01 Jun 2011 18:04:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757841Ab1FAQDz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2011 12:03:55 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:41102 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754558Ab1FAQDy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2011 12:03:54 -0400
Received: by qwk3 with SMTP id 3so2657153qwk.19
        for <git@vger.kernel.org>; Wed, 01 Jun 2011 09:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=DTcIU7X3Pfaz0dgU3Z49OtPv7RnQB4u2j8pqMM2XqOg=;
        b=WvwAIiLdSamvyh6K521wzu6GJzBo0afDBBzIdO8Ca3dLuydJl4ZB4NJFdH2dLnmAnV
         992buaesGSfJlZoRzKtWGMOLpq7TpN7fzUPDSc9iQR5uAgudXUt086Ieq9ksD9nnkp6k
         CM/HDlpoy1Jgu4nOufPCYb+dtKzM62TWIiDHU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=F16xOoD2WEsE3cddlUrOEXCQrKus70OFGou8DdfFDfVTmJnB2MdNiw8IUlUCvN0vNq
         SmKrbuNj2z5Vu/31JZFyD83Ge08TsTkNl42ZyKVP1LxyxHGsHzvYMvXcV0mXUb0nyFpV
         BRyq1koBAkJ8WJFWd/DbL8DgLvNri3TVXXApI=
Received: by 10.229.140.195 with SMTP id j3mr5513116qcu.5.1306944234104; Wed,
 01 Jun 2011 09:03:54 -0700 (PDT)
Received: by 10.229.20.6 with HTTP; Wed, 1 Jun 2011 09:03:14 -0700 (PDT)
In-Reply-To: <1306917751-27999-1-git-send-email-nsekhar@ti.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174872>

Heya,

On Wed, Jun 1, 2011 at 03:42, Sekhar Nori <nsekhar@ti.com> wrote:
> Provide a git config option to enable --signoff a
> default when using git-am. This should be handy
> for maintainers who regularly apply patches from
> mailing lists to send them upstream and want to
> be on the sign-off path.

Wouldn't this need tests?

-- 
Cheers,

Sverre Rabbelier
