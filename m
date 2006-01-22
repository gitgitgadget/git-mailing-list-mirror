From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Reverting "git push logic change"?
Date: Sun, 22 Jan 2006 15:09:51 -0800
Message-ID: <7vpsmjamgw.fsf@assigned-by-dhcp.cox.net>
References: <20060120225336.GA29206@kroah.com>
	<7vlkxa30rd.fsf@assigned-by-dhcp.cox.net>
	<20060121001547.GA30712@kroah.com>
	<7vfynivx9s.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0601221311530.25300@iabervon.org>
	<7vr770c8db.fsf@assigned-by-dhcp.cox.net>
	<7vu0bw9ch7.fsf@assigned-by-dhcp.cox.net>
	<BAYC1-PASMTP0532B701820FA4ADB3C640AE110@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 23 00:09:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0oLM-0006Mu-JU
	for gcvg-git@gmane.org; Mon, 23 Jan 2006 00:09:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782AbWAVXJy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jan 2006 18:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964785AbWAVXJy
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jan 2006 18:09:54 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:54732 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S964782AbWAVXJx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jan 2006 18:09:53 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060122230736.JBBE26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 22 Jan 2006 18:07:36 -0500
To: sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP0532B701820FA4ADB3C640AE110@CEZ.ICE>
	(seanlkml@sympatico.ca's message of "Sun, 22 Jan 2006 16:42:50 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15067>

sean <seanlkml@sympatico.ca> writes:

> What about just always excluding the origin branch from being 
> implicitly pushed; even if it does exist in both repositories?
> In the rare cases where it is actually desired to be pushed,
> it can be done explicitly.

The problem is "origin" is just a Porcelain convention and we
would not want to teach that to the core level, so that will not
fly.
