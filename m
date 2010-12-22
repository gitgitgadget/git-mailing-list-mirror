From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] t3419-*.sh: Fix arithmetic expansion syntax error
Date: Wed, 22 Dec 2010 19:42:42 +0100
Message-ID: <20101222184242.GA6088@localhost>
References: <4D10F707.1000206@ramsay1.demon.co.uk>
Reply-To: Clemens Buchacher <drizzd@aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Wed Dec 22 19:41:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVTd0-0007pA-Oy
	for gcvg-git-2@lo.gmane.org; Wed, 22 Dec 2010 19:41:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753717Ab0LVSl2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Dec 2010 13:41:28 -0500
Received: from mail-fx0-f66.google.com ([209.85.161.66]:61245 "EHLO
	mail-fx0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753491Ab0LVSl1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Dec 2010 13:41:27 -0500
Received: by fxm14 with SMTP id 14so1495157fxm.1
        for <git@vger.kernel.org>; Wed, 22 Dec 2010 10:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:reply-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=qCr/Pbs/Rsje4AAVE/TmPyZZRls0tP6z7QCI0xcP1Rs=;
        b=ZFw20nHbAILZquEIPhSTn4plka05Oq5dvpBdCBdNrknqSeS7j83VYaOuia+1RfGjYD
         vMnLualAiCEx0Ph3mg3OTSNoebTOGEdIls5ylaiNV94X6Ef6Bweja7tMCFizsxu6XqzO
         eUt8HLWnPNkDDmlfUpqfUZn2sGdUMeNRpJbZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=EsqXxMxkIWGJrQaWblNXz5nfznqckX3NWC9LTpHYhrcXpySzaJzIPrR3Cdx4TS8hUc
         boLu14/RLDrbeLIjnbQfGDgQf4oM+YwfACoJq/Bh/KRiOsnMxE7/VZ/a9stf8XD6zAUR
         DejT5XUNfQq89wr3sRykpB4s8tcZ75MUOrIHk=
Received: by 10.223.102.67 with SMTP id f3mr6378093fao.125.1293043286121;
        Wed, 22 Dec 2010 10:41:26 -0800 (PST)
Received: from darc.lan (p5B22D75E.dip.t-dialin.net [91.34.215.94])
        by mx.google.com with ESMTPS id 17sm1796920far.43.2010.12.22.10.41.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 22 Dec 2010 10:41:25 -0800 (PST)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1PVTe6-0001bH-LS; Wed, 22 Dec 2010 19:42:42 +0100
Content-Disposition: inline
In-Reply-To: <4D10F707.1000206@ramsay1.demon.co.uk>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164093>

On Tue, Dec 21, 2010 at 06:50:47PM +0000, Ramsay Jones wrote:
> 
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>

Thanks.

> Note that this test is unique in having an '#!/bin/bash' line (rather
> than '#!/bin/sh'), which was (indirectly) responsible for me not
> noticing this failure for a while. I don't see anything that would
> require bash, so I suspect this is not intensional.

Indeed. I actually removed all bashisms from the script, but then
apparently forgot to get rid of #!/bin/bash as well.

Clemens
