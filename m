From: Kari Hameenaho <khaho@kolumbus.fi>
Subject: Re: gitk-1.0 released
Date: Fri, 20 May 2005 21:18:59 +0300
Message-ID: <d6l9l1$ttd$1@sea.gmane.org>
References: <17036.36624.911071.810357@cargo.ozlabs.ibm.com> <20050519132411.GA29111@elte.hu> <17037.5109.556362.904185@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Fri May 20 20:44:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZCSQ-0004sY-Bo
	for gcvg-git@gmane.org; Fri, 20 May 2005 20:42:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261533AbVETSnv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 20 May 2005 14:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261543AbVETSnu
	(ORCPT <rfc822;git-outgoing>); Fri, 20 May 2005 14:43:50 -0400
Received: from main.gmane.org ([80.91.229.2]:59857 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261533AbVETSnt (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 May 2005 14:43:49 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1DZCQB-0004Yu-3R
	for git@vger.kernel.org; Fri, 20 May 2005 20:40:31 +0200
Received: from a81-197-60-61.elisa-laajakaista.fi ([81.197.60.61])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 20 May 2005 20:40:31 +0200
Received: from khaho by a81-197-60-61.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 20 May 2005 20:40:31 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: a81-197-60-61.elisa-laajakaista.fi
User-Agent: KNode/0.9.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Paul Mackerras wrote:

>=20
> Yes, indeed.  I'll have to think about how to do it in a responsive
> fashion, since getting the necessary information involves reading all
> the commits and all the tree objects back to the beginning of time,
> AFAICS. =20

Maybe its not necessary to go back all the way. It is possible to look =
only
commits between 2.6.12-rc4 and 2.6.12-rc3, like follows (needs just a f=
ew
fixes to gitk):

gitk -d $(commit-id v2.6.12-rc4) ^$(parent-id $(commit-id v2.6.12-rc3))

--=20
Kari H=E4meenaho


