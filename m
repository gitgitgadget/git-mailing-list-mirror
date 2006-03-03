From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add --temp and --stage=all options to checkout-index.
Date: Thu, 02 Mar 2006 21:25:31 -0800
Message-ID: <7vmzg83xro.fsf@assigned-by-dhcp.cox.net>
References: <20060303012032.GC6321@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 03 06:25:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FF2nQ-0002fJ-Sx
	for gcvg-git@gmane.org; Fri, 03 Mar 2006 06:25:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750844AbWCCFZf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Mar 2006 00:25:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750970AbWCCFZf
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Mar 2006 00:25:35 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:45793 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1750858AbWCCFZd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Mar 2006 00:25:33 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060303052402.EICP20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 3 Mar 2006 00:24:02 -0500
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060303012032.GC6321@spearce.org> (Shawn Pearce's message of
	"Thu, 2 Mar 2006 20:20:32 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17135>

Shawn Pearce <spearce@spearce.org> writes:

>  Unfortunately this change lead me down a path which changed the core
>  checkout code also used by apply and read-tree.

... which makes it much harder to swallow without careful
inspection X-<.

I think the patch only appears much bigger than it actually is,
because of reindentation effect coming from "if (to-temp-file)".
However, I am too tired to carefully examine them tonight, so I
hope you do not mind my postponing this for now.
