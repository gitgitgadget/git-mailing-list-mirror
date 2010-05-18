From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] WIP: begin to translate git with gettext
Date: Tue, 18 May 2010 04:23:28 +0000
Message-ID: <AANLkTikUGV8HnkJcz1LOmbpttAmyhf-IynRDZkyNwG6N@mail.gmail.com>
References: <20100517160503.GA12717@unpythonic.net>
	 <AANLkTikkfD_mfBz3mEpu_lP5heB-22QtI6FZP2eZ_C1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff Epler <jepler@unpythonic.net>,
	Git Mailing List <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Dmitry Potapov <dpotapov@gmail.com>, Jan Hudec <bulb@ucw.cz>,
	Thomas Rast <trast@student.ethz.ch>,
	Marc Weber <marco-oweber@gmx.de>
To: Robert Buck <buck.robert.j@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 18 06:23:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OEEL9-0002qZ-NH
	for gcvg-git-2@lo.gmane.org; Tue, 18 May 2010 06:23:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754285Ab0EREXa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 May 2010 00:23:30 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34283 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751089Ab0EREX3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 May 2010 00:23:29 -0400
Received: by iwn6 with SMTP id 6so1143026iwn.19
        for <git@vger.kernel.org>; Mon, 17 May 2010 21:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=kNhAoouX4agAhRd1Bwf0L3FeMOKPjCq5GQDECIYgvw0=;
        b=RbbnuVyw63pSAnhC6FClGs4NZD7jquyJ/ualFLLvdDxWeXU175q5ePvvCyhwOxtpzu
         mG4CVpnvVecOSPwFf/VvBp+SGvcs7M2pb27Z7qveBb3cS5hiQoS9j2pLBfR10tjMdo7Z
         hOb0bONlT5id21uVn8DS0HcUdfvb8oBpVWuTI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=acFPzgQtF8z9gEEpgG6F+efr0Kr0g6OT7tpGdZpowHM75MFibz+VtDbxaNagm1SHka
         gyRj5FMseshTttIzSSrYxpvzm3E6fE4x9S+v7qpwAkm6nYZXwwFaePhLJfnbIflKGP1B
         mhqnNj2TqDadJ/h3eVAyKnVfRNZGJnNow2/6g=
Received: by 10.231.146.140 with SMTP id h12mr1223989ibv.58.1274156608978; 
	Mon, 17 May 2010 21:23:28 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Mon, 17 May 2010 21:23:28 -0700 (PDT)
In-Reply-To: <AANLkTikkfD_mfBz3mEpu_lP5heB-22QtI6FZP2eZ_C1g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147271>

On Mon, May 17, 2010 at 23:29, Robert Buck <buck.robert.j@gmail.com> wrote:
> Is gettext portable? Or is it only POSIX? If it's not portable, have
> you considered using ICU instead as it is the best of class solution
> for I18N/L10N?

Yes it's portable. libintl or libraries that provide compatible
interfaces are available on every platform Git is.

ICU is not a gettext replacement, it's a Unicode processing library, I
don't think it has any gettext-like features. In any case it would be
a huge dependency for the service it would provide.
