From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] (Really) Fix install-doc-quick target
Date: Mon, 06 Aug 2007 20:53:44 -0700
Message-ID: <7vd4y09f07.fsf@assigned-by-dhcp.cox.net>
References: <7vmyx6fohv.fsf_-_@assigned-by-dhcp.cox.net>
	<11864401942772-git-send-email-mdl123@verizon.net>
	<Pine.LNX.4.64.0708062349460.14781@racer.site>
	<7vzm149s8s.fsf@assigned-by-dhcp.cox.net> <46B7B10F.4060402@gmail.com>
	<7vhcnc9lpm.fsf@assigned-by-dhcp.cox.net> <46B7D108.20606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mark Levedahl <mdl123@verizon.net>,
	Git Mailing List <git@vger.kernel.org>,
	Ren Scharfe <rene.scharfe@lsrfire.ath.cx>
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 07 05:54:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIG8x-00014Y-IG
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 05:54:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765773AbXHGDxs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 23:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765632AbXHGDxs
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 23:53:48 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:34830 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765463AbXHGDxr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 23:53:47 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070807035346.SBOI2095.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Mon, 6 Aug 2007 23:53:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Yrtk1X0081kojtg0000000; Mon, 06 Aug 2007 23:53:45 -0400
In-Reply-To: <46B7D108.20606@gmail.com> (Mark Levedahl's message of "Mon, 06
	Aug 2007 21:55:20 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55213>

Mark Levedahl <mlevedahl@gmail.com> writes:

> +    printf "$mandir/%s\n" $(git ls-tree -r --name-only $head) | xargs
> gzip -f

No risk that ls-tree output is too long to fit within the exec
args limit to run printf?
