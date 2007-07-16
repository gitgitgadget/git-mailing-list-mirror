From: Thomas Glanzmann <thomas@glanzmann.de>
Subject: Re: "git clone" executed as root on solaris 10 shreds UFS (it is
	possible to create hardlinks for directories as root under solaris)
Date: Mon, 16 Jul 2007 14:46:04 +0200
Message-ID: <20070716124604.GK24036@cip.informatik.uni-erlangen.de>
References: <20070716100803.GA24036@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <gitster@pobox.com>
To: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 16 14:46:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAPxp-0003nA-Nj
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 14:46:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755859AbXGPMqH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 08:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755744AbXGPMqF
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 08:46:05 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:55972 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755542AbXGPMqF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jul 2007 08:46:05 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id 4A9123F42E; Mon, 16 Jul 2007 14:46:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070716100803.GA24036@cip.informatik.uni-erlangen.de>
User-Agent: Mutt/1.5.15 (2007-05-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52670>

Hello again,
it is definitively "git-checkout-index -a -f":

truss output is at http://wwwcip.informatik.uni-erlangen.de/~sithglan/git_checkout_index_a_f.truss.gz

        Thomas
