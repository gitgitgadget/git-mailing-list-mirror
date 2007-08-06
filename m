From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] (Really) Fix install-doc-quick target
Date: Mon, 06 Aug 2007 16:07:47 -0700
Message-ID: <7vzm149s8s.fsf@assigned-by-dhcp.cox.net>
References: <7vmyx6fohv.fsf_-_@assigned-by-dhcp.cox.net>
	<11864401942772-git-send-email-mdl123@verizon.net>
	<Pine.LNX.4.64.0708062349460.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Levedahl <mdl123@verizon.net>,
	Git Mailing List <git@vger.kernel.org>,
	Ren Scharfe <rene.scharfe@lsrfire.ath.cx>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Aug 07 01:07:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIBg5-0003Cw-3U
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 01:07:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763643AbXHFXHu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 19:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763567AbXHFXHu
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 19:07:50 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:55786 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762951AbXHFXHt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 19:07:49 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070806230749.YTPJ26965.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Mon, 6 Aug 2007 19:07:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Yn7n1X00b1kojtg0000000; Mon, 06 Aug 2007 19:07:48 -0400
In-Reply-To: <Pine.LNX.4.64.0708062349460.14781@racer.site> (Johannes
	Schindelin's message of "Mon, 6 Aug 2007 23:50:21 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55184>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Mon, 6 Aug 2007, Mark Levedahl wrote:
>
>> -	for i in `git ls-tree -r --name-only $head`
>> +	for i in `git --git-dir="$GIT_DIR" ls-tree -r --name-only $head`
>
> This awfully looks like hiding a bug.  It should _never_ be necessary to 
> say '--git-dir="$GIT_DIR"'.

Yes.  And 00d8c51 obviously "works for me", so there is
something different between what Mark and I are doing.  I cannot
tell what it is.
