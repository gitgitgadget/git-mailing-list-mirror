From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Add --rebase option to git-pull?
Date: Thu, 30 Aug 2007 22:22:51 +0200
Message-ID: <20070830202251.GA15405@steel.home>
References: <550f9510708300540u13c77201oe7cbe599c6773364@mail.gmail.com> <Pine.LNX.4.64.0708301415150.28586@racer.site> <550f9510708300810y1ca84e8dt4d0bab8fc99deb3c@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Tom Clarke <tom@u2i.com>
X-From: git-owner@vger.kernel.org Thu Aug 30 22:23:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQqXe-0002Tt-K9
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 22:23:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759500AbXH3UW4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 16:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757309AbXH3UW4
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 16:22:56 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:45181 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754172AbXH3UWz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 16:22:55 -0400
Received: from tigra.home (Fc93c.f.strato-dslnet.de [195.4.201.60])
	by post.webmailer.de (mrclete mo15) (RZmta 12.1)
	with ESMTP id U065a2j7UGUhLw ; Thu, 30 Aug 2007 22:22:52 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 8EEA9277BD;
	Thu, 30 Aug 2007 22:22:52 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 0D7A9BE2A; Thu, 30 Aug 2007 22:22:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <550f9510708300810y1ca84e8dt4d0bab8fc99deb3c@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaFzAPiog==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57064>

Tom Clarke, Thu, Aug 30, 2007 17:10:31 +0200:
> +# Give up if we are given more than two remotes -- not handling octopus.
> +case "$remotes" in
> +?*' '?*)
> +       exit 2 ;;
> +esac

Isn't it "given two and more remotes"?
