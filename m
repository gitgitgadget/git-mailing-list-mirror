From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] plug a DIR buffer leak in rerere.c
Date: Thu, 26 May 2011 20:32:33 +0200
Message-ID: <877h9d48ji.fsf@rho.meyering.net>
References: <8762ox7ehl.fsf@rho.meyering.net>
	<7v7h9dxqzj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 26 20:32:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPfMV-0001ib-TR
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 20:32:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758105Ab1EZScl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 14:32:41 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:48513 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757756Ab1EZScl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 14:32:41 -0400
Received: from mx.meyering.net (unknown [82.230.74.64])
	by smtp1-g21.free.fr (Postfix) with ESMTP id DB7F39401B7
	for <git@vger.kernel.org>; Thu, 26 May 2011 20:32:34 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 527766029C; Thu, 26 May 2011 20:32:33 +0200 (CEST)
In-Reply-To: <7v7h9dxqzj.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 26 May 2011 11:21:20 -0700")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174557>

Junio C Hamano wrote:
> Thanks; I assume both of these are signed-off?

Yes.  Sorry about the omission.
