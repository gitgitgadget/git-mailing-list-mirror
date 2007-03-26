From: Eygene Ryabinkin <rea-git@codelabs.ru>
Subject: Re: [PATCH 1/5] Consistently use user-defined UI font everywhere in GUI tools.
Date: Mon, 26 Mar 2007 14:16:10 +0400
Message-ID: <20070326101610.GX14837@codelabs.ru>
References: <20070326073715.GE44578@codelabs.ru> <7vr6rcxv5x.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Mar 26 12:16:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVmFR-0002Np-BB
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 12:16:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404AbXCZKQR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 06:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753616AbXCZKQR
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 06:16:17 -0400
Received: from pobox.codelabs.ru ([144.206.177.45]:49999 "EHLO
	pobox.codelabs.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751404AbXCZKQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 06:16:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=simple; s=one; d=codelabs.ru;
	h=Received:Date:From:To:Cc:Message-ID:References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:Sender:X-Spam-Status:Subject;
	b=c1+XBHlbxqd6egFxpHXDeGjfWxrabarmpjBZ2c+KiwYfTy02hTJUetNz/q6/+ftnrgXHhFrQbHnJFl6WSN6RbvfA/yEu54MSjJ92EOrWOvTfOesXoTJW2k9qJdgS0MZbZnBHyfByem0LujtPGa+aAAstwY1oW/y4asZQYWtSjsk=;
Received: from codelabs.ru (pobox.codelabs.ru [144.206.177.45])
	by pobox.codelabs.ru with esmtpsa (TLSv1:AES256-SHA:256)
	id 1HVmFL-000Bow-1V; Mon, 26 Mar 2007 14:16:15 +0400
Content-Disposition: inline
In-Reply-To: <7vr6rcxv5x.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, score=-2.3 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_20
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43146>

Junio,

Mon, Mar 26, 2007 at 01:31:54AM -0700, Junio C Hamano wrote:
> I think this is sane in general, but please
> 
>  (1) do not make a combined patch that covers gitk and git-gui
>      at the same time;

I assume this does not the general rule, but it is just a consequence
of a gitk and git-gui being maintained by the different programmers?
I've always thought that the logically related changes should go
into the same commit.

>  (2) address gitk patches to Paul Mackerras <paulus@samba.org>,
>      with cc: the list;
> 
>  (3) address git-gui patches to Shawn Pearce <spearce@spearce.org>
>      with cc: the list.

OK, will do.

Probably the RTFM question: can I redo my patches to split them up
to the different pieces for the gitk and git-gui in some automated
way?  Or I will need to do it manually?

Thanks!
-- 
Eygene
