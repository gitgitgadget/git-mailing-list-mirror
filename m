From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [PATCH 3/3] Fix large-scale exports by 'git-svndump'
Date: Mon, 18 Jun 2007 15:22:30 +0200
Organization: eudaptics software gmbh
Message-ID: <46768716.5A7AF6C7@eudaptics.com>
References: vpqhcp6b85c.fsf@bauges.imag.fr
	 <11821688443683-git-send-email-ynvich@gmail.com>
	 <11821688461828-git-send-email-ynvich@gmail.com>
	 <11821688462290-git-send-email-ynvich@gmail.com> <11821688462083-git-send-email-ynvich@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 18 15:26:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0HF0-0002HK-9m
	for gcvg-git@gmane.org; Mon, 18 Jun 2007 15:25:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762229AbXFRNZ5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Jun 2007 09:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762222AbXFRNZ4
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jun 2007 09:25:56 -0400
Received: from main.gmane.org ([80.91.229.2]:51389 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761314AbXFRNZ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2007 09:25:56 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1I0HE6-0006FC-30
	for git@vger.kernel.org; Mon, 18 Jun 2007 15:25:02 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 18 Jun 2007 15:25:02 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 18 Jun 2007 15:25:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50397>

Sergey Yanovich wrote:
> 
> * Split revision list using 'tail' shell command.
> 
> * Wrap multiple list generation in an endless cycle with 'while true'.
>   Exit from cycle when the current list is empty.
> 
> * Improve handling of merges by adding '--no-merges --topo-order'i
>   arguments to the list generating command.

Please don't just repeat what can be seen in the patch anyway. Tell us
what this is good for, and which problems it solves.

-- Hannes
