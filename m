From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH 1/3] Refactor working tree setup
Date: Fri, 09 Nov 2007 07:41:10 +0900
Message-ID: <87bqa4gy2h.fsf@catnip.gol.com>
References: <1194088993-25692-1-git-send-email-mh@glandium.org>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Thu Nov 08 23:42:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqG4e-0003W8-FW
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 23:42:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760397AbXKHWlf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 17:41:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760178AbXKHWle
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 17:41:34 -0500
Received: from smtp02.dentaku.gol.com ([203.216.5.72]:57052 "EHLO
	smtp02.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759622AbXKHWle (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 17:41:34 -0500
Received: from 203-216-100-114.dsl.gol.ne.jp ([203.216.100.114] helo=catnip.gol.com)
	by smtp02.dentaku.gol.com with esmtpa (Dentaku)
	id 1IqG3k-00013q-AJ; Fri, 09 Nov 2007 07:41:12 +0900
Received: by catnip.gol.com (Postfix, from userid 1000)
	id B8C852FF6; Fri,  9 Nov 2007 07:41:10 +0900 (JST)
System-Type: i686-pc-linux-gnu
In-Reply-To: <1194088993-25692-1-git-send-email-mh@glandium.org> (Mike Hommey's message of "Sat\,  3 Nov 2007 12\:23\:11 +0100")
X-Abuse-Complaints: abuse@gol.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64084>

Mike Hommey <mh@glandium.org> writes:
> Create a setup_work_tree() that can be used from any command requiring
> a working tree conditionally.
...
> +void setup_work_tree(void) {
> +	const char *work_tree = get_git_work_tree();

Hi, could you please not use this "function begin brace at EOL" style?

It's inconsistent with the rest of the source, makes the code harder to
read, and confuses Emacs in some cases[1].  Also it's an abomination
unto God, but I imagine it's the first of these reasons that you'll care
about the most... :-)

Thanks,

-Miles


[1] Until quite recently, Emacs c-mode couldn't find the beginning of
such functions (recent versions of c-mode seem OK though).

-- 
The secret to creativity is knowing how to hide your sources.
  --Albert Einstein
