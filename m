From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] gitk: let you easily specify lines of context in diff view
Date: Fri, 27 Jul 2007 07:52:28 +0200
Message-ID: <6EA8D0EC-6E64-4F0E-BEDB-A8C5C91AAB53@zib.de>
References: <11854367692095-git-send-email-prohaska@zib.de> <18088.38093.876993.410483@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Fri Jul 27 07:51:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEIjk-0007Rl-IV
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 07:51:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758628AbXG0Fvh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 01:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752693AbXG0Fvh
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 01:51:37 -0400
Received: from mailer.zib.de ([130.73.108.11]:62690 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752501AbXG0Fvg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 01:51:36 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l6R5pXP2021340;
	Fri, 27 Jul 2007 07:51:33 +0200 (CEST)
Received: from [192.168.178.32] (brln-4db10e88.pool.einsundeins.de [77.177.14.136])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l6R5pWBC000540
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 27 Jul 2007 07:51:33 +0200 (MEST)
In-Reply-To: <18088.38093.876993.410483@cargo.ozlabs.ibm.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53899>


On Jul 26, 2007, at 2:34 PM, Paul Mackerras wrote:

> Steffen Prohaska writes:
>
>> More lines of context sometimes help to better understand a diff.
>> This patch introduces a text field above the box displaying the
>> blobdiffs. You can type in the number of lines of context that
>> you wish to view.
>
> Nice idea!  I suggest you use a spinbox instead of an entry though,
> since that has up and down buttons, and allows you to restrict the
> value to an integer.

Thanks. Will try that.


>>    * I don't know how to update the view after entering a new value.
>
> You can put a trace on the associated variable and specify a function
> to be called when the variable's value changes.  Grep for "trace add
> variable" in gitk to see how it's done.

This is already included in the patch but I don't know which of gtk's
procs to call to update the view. gitk would need to execute git diff
and update the text box in the bottom left. I tried 'dodiffindex'
but this causes corruptions of the history view.

	Steffen
