From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [PATCH] Do _not_ call unlink on a directory
Date: Wed, 18 Jul 2007 09:24:39 +0200
Organization: eudaptics software gmbh
Message-ID: <469DC037.A7D69826@eudaptics.com>
References: <11846059721204-git-send-email-sithglan@stud.uni-erlangen.de> <7vtzs3a0xg.fsf@assigned-by-dhcp.cox.net> <20070717101527.GB7774@cip.informatik.uni-erlangen.de> <7vlkdeang0.fsf@assigned-by-dhcp.cox.net> <20070717202754.GB25037@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 18 09:25:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IB3uG-0007bK-3P
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 09:25:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752422AbXGRHZF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 03:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752085AbXGRHZF
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 03:25:05 -0400
Received: from main.gmane.org ([80.91.229.2]:53633 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752422AbXGRHZD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2007 03:25:03 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IB3ty-00045y-Jv
	for git@vger.kernel.org; Wed, 18 Jul 2007 09:24:50 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 18 Jul 2007 09:24:50 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 18 Jul 2007 09:24:50 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52836>

Thomas Glanzmann wrote:
> and as you can see by the
> pastes that I provided to track down the bug I have
> 
>         if [ $UID -eq 0 ]; then
>                 export PS1="(${PROMPT_RED}\h${PROMPT_END}) [${PROMPT_BLUE}\w${PROMPT_END}] ";
>                 alias bk='echo DO *NOT* RUN BK AS ROOT'
>                 alias git='echo DO *NOT* RUN GIT AS ROOT'
>                 alias links='echo DO *NOT* RUN LINKS AS ROOT'
>                 alias elinks='echo DO *NOT* RUN ELINKS AS ROOT'

And if you have a file NOTES in $pwd, it will tell you:

DO NOTES RUN GIT AS ROOT

;-P

-- Hannes
