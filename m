From: Klas Lindberg <klas.lindberg@gmail.com>
Subject: Re: Fetching SHA id's instead of named references?
Date: Mon, 6 Apr 2009 15:06:46 +0200
Message-ID: <33f4f4d70904060606h4d014fbdibe195a83233d8899@mail.gmail.com>
References: <33f4f4d70904060513k320fb6a0ya928c714dcd11e89@mail.gmail.com>
	 <alpine.DEB.1.00.0904061431020.6619@intel-tinevez-2-302>
	 <33f4f4d70904060541s6dfb7e8ctf50f5e8a872ae1c@mail.gmail.com>
	 <vpqprfq3ptb.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Users List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Apr 06 15:08:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqoYp-0008MK-Pg
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 15:08:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755015AbZDFNGv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 09:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754763AbZDFNGv
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 09:06:51 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:55795 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754715AbZDFNGu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 09:06:50 -0400
Received: by fxm2 with SMTP id 2so1875139fxm.37
        for <git@vger.kernel.org>; Mon, 06 Apr 2009 06:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=1EWoe/WC/MoyCp0Ik1JR/9Pi0nRr/BgvlrID32hWips=;
        b=KYrbsVYITGGrAbVOzVW84F2C+lthaTPrsiUZloOXFigE5zwuewVbce+tnVwhJbBPHF
         4Lq5Kcm+KoQK4kaS+AX1myaMNz9R5b0TfLsBk3QmMw7g51iCSp3Ra3MtHPoAeYxtHHao
         rjyZoRMUxplPLK2C2gqXwj++yHfqP+Vxd/S7Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=k8ZKGqjgIh/1k7cwMIDHQrlCo7v2ueAbsEm6/D9A861NRGdolS+wsFMmGsuYNbQa/0
         L5qM2cu7GInxdxOaKKOi5IvneFag38CSMDu7sl+3Z02/GbqDEsylD9GMysxzRsjSC1VD
         gDQNxdIXL6enh2wtCyU3Oz2NzEdcLNjuuCnVA=
Received: by 10.223.124.147 with SMTP id u19mr3740750far.28.1239023206730; 
	Mon, 06 Apr 2009 06:06:46 -0700 (PDT)
In-Reply-To: <vpqprfq3ptb.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115818>

On Mon, Apr 6, 2009 at 2:54 PM, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:

> What Johannes pointed out is that someone could fetch from your repo
> _after_ you correct the mistake (if you don't control garbage
> collection).

Aha, ok. But how then does submodule update work? Git will only see
SHA keys for each submodule in the cotntainer tree commit, so how does
it perform fetching of those (unnamed) references?

BR / Klas
