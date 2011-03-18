From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Q: rebasing (moving) a whole tree (not just one branch)
Date: Fri, 18 Mar 2011 15:26:37 -0500
Message-ID: <20110318202637.GA23255@elie>
References: <4D83BB0A.8070307@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Dirk =?utf-8?Q?S=C3=BCsserott?= <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Fri Mar 18 21:26:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0gG2-000137-62
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 21:26:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756866Ab1CRU0q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Mar 2011 16:26:46 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:49595 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756818Ab1CRU0p convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Mar 2011 16:26:45 -0400
Received: by yxs7 with SMTP id 7so1740362yxs.19
        for <git@vger.kernel.org>; Fri, 18 Mar 2011 13:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=mzhW7rerJDPxNGqm/sglm78lDuRAI6drQRxOGRrpnLM=;
        b=XA4GazrQN+zc+rv4B6ZPOSibwR9DVm5nau7titOAv6KCkV2G8yLW9ytUir4vTbiq69
         LoV/H2ATqOMkYTHgWNwKhjLxJ++2KZMlnjer9o70YqQmaGIS5dYYzKsQzNRm8tvzfLSL
         yGl/jkPn0hw4CBIIi8RWyEHPPmJHCKuaCeKrY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=AD/D4FNJztxGgYMtgedmm2t+dSWXbfv3L1YP+YPTUM/S1cw6cBltTnIIqZmnY5UY49
         XbDorputVWbHc4P8qNMcKsbilv9kVDT1H8D923Kfr2S366rcfNlEV1HujAOt20NBWcRb
         m1bWjLptDl4de9JODHNfenVtbqOByobufHU5Q=
Received: by 10.236.37.202 with SMTP id y50mr2216380yha.219.1300480004585;
        Fri, 18 Mar 2011 13:26:44 -0700 (PDT)
Received: from elie (adsl-69-209-56-53.dsl.chcgil.ameritech.net [69.209.56.53])
        by mx.google.com with ESMTPS id 33sm2020186yhl.2.2011.03.18.13.26.42
        (version=SSLv3 cipher=OTHER);
        Fri, 18 Mar 2011 13:26:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4D83BB0A.8070307@dirk.my1.cc>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169355>

Hi Dirk,

Dirk S=C3=BCsserott wrote:

> I'd like to rebase a whole tree from A to B. Not just a single
> branch, but a whole tree. Let's say I have the following history:
>
> --- A --- B
>     |
>     + -- C -- D
>          |
>          + E -- F
>=20
> I'd like to rebase C and its descendants from A to B

I'd suggest cheating by making a merge of D and F and "rebase -p"-ing
that. :)

To say something more sensible would probably require more information
about the particular application, though.

Hope that helps,
Jonathan
