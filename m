From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: GIT 1.6.0-rc1
Date: Mon, 28 Jul 2008 08:38:38 +0200
Message-ID: <20080728063838.GB4234@blimp.local>
References: <7vy73myim5.fsf@gitster.siamese.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 28 08:40:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNMOT-0003EX-EK
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 08:39:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751708AbYG1Gil (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 02:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751567AbYG1Gik
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 02:38:40 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.180]:40958 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237AbYG1Gik (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 02:38:40 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg2r44guxV
Received: from tigra.home (Fa949.f.strato-dslnet.de [195.4.169.73])
	by post.webmailer.de (klopstock mo26) (RZmta 16.47)
	with ESMTP id t0239dk6S1P0SP ; Mon, 28 Jul 2008 08:38:38 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 4587C277BD;
	Mon, 28 Jul 2008 08:38:38 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id 2282A36D18; Mon, 28 Jul 2008 08:38:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vy73myim5.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90419>

Junio C Hamano, Mon, Jul 28, 2008 02:09:38 +0200:
> Ok, so I tagged and pushed it out.  There still is the "git mv" bugfix
> from Pasky that is parked in 'next' but other than that I think this is
> pretty much "it" for 1.6.0 feature-wise.
> 
> Major parts of the changes since 1.6.0-rc0 consists of documentation and
> tests portability; there is nothing surprising nor scary.

t2103-update-index-ignore-missing.sh still broken on Windows because
of stat.st_size being 0 for directories there.

    http://thread.gmane.org/gmane.comp.version-control.git/89370
