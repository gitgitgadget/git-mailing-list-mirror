From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2] status: list unmerged files last
Date: Wed, 2 Sep 2009 21:19:41 +0200
Message-ID: <200909022119.42102.j6t@kdbg.org>
References: <20090901145213.GB4194@debian.b2j> <7vljkxdiil.fsf@alter.siamese.dyndns.org> <20090902100730.GA18226@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	bill lam <cbill.lam@gmail.com>, git <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 02 21:19:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MivN2-0000JS-A3
	for gcvg-git-2@lo.gmane.org; Wed, 02 Sep 2009 21:19:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751659AbZIBTTm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2009 15:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751616AbZIBTTm
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Sep 2009 15:19:42 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:31760 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751557AbZIBTTm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2009 15:19:42 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id BCEB7A7EBB;
	Wed,  2 Sep 2009 21:19:42 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 7F102435CD;
	Wed,  2 Sep 2009 21:19:42 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20090902100730.GA18226@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127627>

On Mittwoch, 2. September 2009, David Aguilar wrote:
> No one has suggested this, so I figured I would.
> What do you think about this layout?
>
> - untracked
> - staged
> - modified
> - unmerged

You forget that these things also appear in the commit message editor. In that 
location, the important things must be at the *top*.

We can freely move the list of unmerged files because it will not appear in 
the commit message editor. The current order of the other lists is sane, IMO.

-- Hannes
