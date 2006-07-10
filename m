From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/3] git-format-patch: Make the second and subsequent mails replies to the first
Date: Mon, 10 Jul 2006 14:44:22 -0700
Message-ID: <7vwtal9lu1.fsf@assigned-by-dhcp.cox.net>
References: <20060710162920.GR20191@harddisk-recovery.com>
	<1152556878.8890.45.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 10 23:44:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G03YK-0008Hb-Ip
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 23:44:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964973AbWGJVoY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 17:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965032AbWGJVoY
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 17:44:24 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:51336 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S964973AbWGJVoY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jul 2006 17:44:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060710214423.QFRV554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 10 Jul 2006 17:44:23 -0400
To: josht@us.ibm.com
In-Reply-To: <1152556878.8890.45.camel@josh-work.beaverton.ibm.com> (Josh
	Triplett's message of "Mon, 10 Jul 2006 11:41:18 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23658>

Josh Triplett <josht@us.ibm.com> writes:

> Add message_id and ref_message_id fields to struct rev_info, used in show_log
> with CMIT_FMT_EMAIL to set Message-Id and In-Reply-To/References respectively.
> Use these in git-format-patch to make the second and subsequent patch mails
> replies to the first patch mail.
>
> Signed-off-by: Josh Triplett <josh@freedesktop.org>
> ---
> Resend of previous patch as part of new patch series.

While I understand what you said about imap-send, I really would
feel better if this was optional.  Do not change the default
output format, please.
