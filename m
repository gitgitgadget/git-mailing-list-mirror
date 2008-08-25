From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Mon, 25 Aug 2008 14:43:41 +0200
Message-ID: <20080825124341.GD26610@one.firstfloor.org>
References: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org> <1219664940.9583.42.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	users@kernel.org
To: David Woodhouse <dwmw2@infradead.org>
X-From: git-owner@vger.kernel.org Mon Aug 25 14:43:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXbOw-0003Sm-Qx
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 14:42:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756082AbYHYMlX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 08:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756065AbYHYMlX
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 08:41:23 -0400
Received: from one.firstfloor.org ([213.235.205.2]:34853 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756003AbYHYMlW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 08:41:22 -0400
Received: by one.firstfloor.org (Postfix, from userid 503)
	id 9A7141AD0020; Mon, 25 Aug 2008 14:43:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1219664940.9583.42.camel@pmac.infradead.org>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93617>

>   (C) Just don't do it. Leave the git-foo commands as they were. They
>       weren't actually hurting anyone, and you don't actually _gain_
>       anything by removing them. For those occasional nutters who
>       _really_ care about the size of /usr/bin, give them the _option_
>       of a 'make install' without installing the aliases.

(Ca) Only leave the widely used commands in $PATH and remove the ones
which are mostly used by internal scripts only.

-Andi
