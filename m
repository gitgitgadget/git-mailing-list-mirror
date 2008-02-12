From: Michael Hendricks <michael@ndrix.org>
Subject: Re: [PATCH] pack-objects: Add runtime detection of online CPU's
Date: Tue, 12 Feb 2008 07:52:01 -0700
Message-ID: <20080212145200.GB20686@ginosko.local>
References: <47B156CD.1010209@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@cam.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Feb 12 15:53:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOwVG-0003bX-I0
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 15:52:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753520AbYBLOwI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 09:52:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753413AbYBLOwG
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 09:52:06 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:50457 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753439AbYBLOwF (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Feb 2008 09:52:05 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 2889790579;
	Tue, 12 Feb 2008 09:52:04 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Tue, 12 Feb 2008 09:52:04 -0500
X-Sasl-enc: pkxClprs0I0wQPXPvPYSIjTp0ACmZlapv0Gdw0TkRuM/ 1202827923
Received: from ndrix.org (tameion.ndrix.org [166.230.131.80])
	by mail.messagingengine.com (Postfix) with ESMTP id 0414A1124C;
	Tue, 12 Feb 2008 09:52:02 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <47B156CD.1010209@op5.se>
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73665>

On Tue, Feb 12, 2008 at 09:20:29AM +0100, Andreas Ericsson wrote:
>  + * By doing this in two steps we can at least get
>  + * get the function to be somewhat coherent, even
>  + * with this disgusting nest of #ifdefs.

"we can at least get get the ..."

An extra "get" snuck in there.

-- 
Michael
