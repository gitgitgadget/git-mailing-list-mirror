From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: git log of remote repositories.
Date: Wed, 14 Apr 2010 22:25:42 +0200
Message-ID: <o2qfabb9a1e1004141325uaf06d8d0r7b4211c055eb5042@mail.gmail.com>
References: <u2n3abd05a91004131625k500e79bbsc8ffa6455a85332d@mail.gmail.com> 
	<slrnhsba0k.h9q.heipei@dualtron.heipei.net> <x2q3abd05a91004141208x6e154385l8b7ce6488d65f21b@mail.gmail.com> 
	<20100414194552.GA5178@dualtron.lan> <w2s3abd05a91004141305h28d69d44g2fcb69abe578dbcc@mail.gmail.com> 
	<r2rfabb9a1e1004141311sa27dedf2h8bfff789a6ef1200@mail.gmail.com> 
	<z2m3abd05a91004141318mdf91a7aapf66b742192fc44a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Gilger <heipei@hackvalue.de>, git@vger.kernel.org
To: Aghiles <aghilesk@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 14 22:26:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O29A3-00049R-IC
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 22:26:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756651Ab0DNU0G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 16:26:06 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:35362 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755757Ab0DNU0E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Apr 2010 16:26:04 -0400
Received: by qw-out-2122.google.com with SMTP id 8so185197qwh.37
        for <git@vger.kernel.org>; Wed, 14 Apr 2010 13:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=ULZgeK0ZCO8O1cPeNjDJEEO+gQyE4KvRRT85w74ENsg=;
        b=PNmcgi/3iQiLDJR3iNzpPwBWO0yN1qabHkaOvr2pjd6OnUIY0kv+lTUaVfaxo4oF2T
         MMqSD/60tBSzXwT7DD+RLmxzwgVJ8FXPSr+L3yp+sM//+qr6O0LfEseA3o3hSlpzRH4P
         RqOyxAanqCOsPJ12Vy8NAIgdP/p9i77MS/9kk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=RHTtyIvigGuK2hXrU2g3KRBxvq9Pq/o1P7FXGOXxFREMKUUloZ+Ci8kn4qyKELcwGK
         U6PkARMH/sTuE7sNblgrdswDuKUzLhMDh/1HSsx4PIDpx+E3hmHCxLVeaXRDZSOhkBGf
         EgJPqrG1Bm7qlk2V6mgNTx9fkhl7lLdVn5dOo=
Received: by 10.224.74.3 with HTTP; Wed, 14 Apr 2010 13:25:42 -0700 (PDT)
In-Reply-To: <z2m3abd05a91004141318mdf91a7aapf66b742192fc44a3@mail.gmail.com>
Received: by 10.224.59.70 with SMTP id k6mr2806141qah.237.1271276762349; Wed, 
	14 Apr 2010 13:26:02 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144905>

Heya,

On Wed, Apr 14, 2010 at 22:18, Aghiles <aghilesk@gmail.com> wrote:
> Yes, size can be an issue. Additionally, git fetch will probably update
> some references, like FETCH_HEAD, no ? I might want these
> untouched, if possible.

I don't think it's a good idea to rely on FETCH_HEAD; if it contains
anything you care about you should make a branch or tag for it. Other
than FETCH_HEAD 'git fetch' will only update refs in the
'refs/remotes/<remote>/' namespace.

-- 
Cheers,

Sverre Rabbelier
