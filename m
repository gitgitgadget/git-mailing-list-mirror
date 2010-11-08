From: Yann Dirson <dirson@bertin.fr>
Subject: Re: [PATCHv3 1/2] rebase: better rearranging of fixup!/squash! lines
 with --autosquash
Date: Mon, 08 Nov 2010 11:52:39 +0100
Organization: Bertin Technologies
Message-ID: <20101108115239.7309504f@chalon.bertin.fr>
References: <1289213283-24294-1-git-send-email-kevin@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Mon Nov 08 12:03:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFPVU-0003hf-Tp
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 12:03:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754397Ab0KHLDR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 06:03:17 -0500
Received: from blois.bertin.fr ([195.68.26.9]:58815 "EHLO blois.bertin.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752542Ab0KHLDR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 06:03:17 -0500
Received: from blois.bertin.fr (localhost [127.0.0.1])
	by postfix.imss70 (Postfix) with ESMTP id 174E454347
	for <git@vger.kernel.org>; Mon,  8 Nov 2010 12:03:10 +0100 (CET)
Received: from YPORT1 (yport1.bertin.fr [192.168.1.13])
	by blois.bertin.fr (Postfix) with ESMTP id E852F54340
	for <git@vger.kernel.org>; Mon,  8 Nov 2010 12:03:09 +0100 (CET)
Received: from chalon.bertin.fr ([172.16.1.1]) by yport1.innovation.bertin.fr
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPPA id <0LBK008Q5C196360@yport1.innovation.bertin.fr> for
 git@vger.kernel.org; Mon, 08 Nov 2010 12:03:09 +0100 (CET)
In-reply-to: <1289213283-24294-1-git-send-email-kevin@sb.org>
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.20.1; i486-pc-linux-gnu)
X-TM-AS-Product-Ver: IMSS-7.0.0.8200-6.0.0.1038-17752.006
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160923>

Kevin wrote:
>The current behvaior of --autosquash can duplicate fixup!/squash! lines
>if they match multiple commits, and it can also apply them to commits
>that come after them in the todo list.

That last part of the sentence does not match my experience - it looks
like you describe as a bug a nonexistent feature I miss :)

See http://marc.info/?l=git&m=128784082701920 for a testcase that
exhibits what I think is a problem.

-- 
Yann Dirson - Bertin Technologies
