From: Junio C Hamano <junkio@cox.net>
Subject: Re: Tracking branch history
Date: Sun, 14 May 2006 16:14:55 -0700
Message-ID: <7vk68o19n4.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0605121838490.6713@iabervon.org>
	<Pine.LNX.4.64.0605121640210.3866@g5.osdl.org>
	<20060513034051.GA21586@spearce.org>
	<7vody2v7yr.fsf@assigned-by-dhcp.cox.net>
	<20060513071753.GA21998@spearce.org>
	<20060513074328.GB21998@spearce.org>
	<Pine.LNX.4.64.0605130815550.3866@g5.osdl.org>
	<7vbqu1vps3.fsf@assigned-by-dhcp.cox.net>
	<20060513181816.GA12475@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 15 01:15:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfPnh-0004WV-Tn
	for gcvg-git@gmane.org; Mon, 15 May 2006 01:15:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbWENXO5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 May 2006 19:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbWENXO5
	(ORCPT <rfc822;git-outgoing>); Sun, 14 May 2006 19:14:57 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:43713 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751373AbWENXO4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 May 2006 19:14:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060514231456.QWHK27967.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 14 May 2006 19:14:56 -0400
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060513181816.GA12475@spearce.org> (Shawn Pearce's message of
	"Sat, 13 May 2006 14:18:16 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19989>

Shawn Pearce <spearce@spearce.org> writes:

> Log ref updates to logs/refs/<ref>
>
> If config parameter core.logRefUpdates is true then append a line
> to .git/logs/refs/<ref> whenever git-update-ref <ref> is executed.

I cannot decide if a parameter makes more sense, or just making
the existence of such a file a cue is better.  For example, I do
not much care about when I updated each of my topic branch head,
while I do care about master, next, and pu branches.  A global
parameter would make this black-or-white choice, while opening
the log without O_CREAT and write things out only when the log
file exists might make things as easy and controllable.

I could "touch" the ones I care about to prime the process.

Hmm?
