From: Bill Lear <rael@zopyra.com>
Subject: Re: [PATCH] pager: default to LESS=FRX not LESS=FRSX
Date: Mon, 26 Mar 2007 13:14:44 -0600
Message-ID: <17928.7076.871485.136142@lisa.zopyra.com>
References: <20070326073502.GD44578@codelabs.ru>
	<7vwt14xvaw.fsf@assigned-by-dhcp.cox.net>
	<20070326083617.GG13247@spearce.org>
	<7v8xdkxukt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Eygene Ryabinkin <rea-git@codelabs.ru>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Mar 26 21:15:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVues-0006RY-U3
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 21:15:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbXCZTOu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 15:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752677AbXCZTOu
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 15:14:50 -0400
Received: from mail.zopyra.com ([65.68.225.25]:60113 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751143AbXCZTOt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 15:14:49 -0400
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l2QJElv08132;
	Mon, 26 Mar 2007 13:14:47 -0600
In-Reply-To: <7v8xdkxukt.fsf@assigned-by-dhcp.cox.net>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43177>

On Monday, March 26, 2007 at 01:44:34 (-0700) Junio C Hamano writes:
>"Shawn O. Pearce" <spearce@spearce.org> writes:
>
>> Junio C Hamano <junkio@cox.net> wrote:
>>> Eygene Ryabinkin <rea-git@codelabs.ru> writes:
>>> 
>>> > Remove unnecessary '-S' option that enabled less to chop long lines.
>>> > It used to provide some confusion at least for the 'git diff':
>>> > "Where are my long lines? Are they missed from the patch?".
>>> 
>>> It is not "unnecessary", but only "what _you_ are not used to".
>>> As this breaks expectentions of people already familiar with
>>> what git does by default, I cannot take this patch.
>>
>> Hear hear.  I completely agree with Junio.  I (and a number of
>> other users that I work with) expect this behevaior by default.
>
>Two tips.
>
> (1) Learn to use left/right arrow keys under "less -S" if you
>     have occasional lines that are too long.

Hmm, looking at the code: why, if the environment variable LESS is
already set, should this all be worth talking about?  Shouldn't the
user be able to set LESS to whatever they want, once, and be done with
it?  The current setenv() call to set up the pager does this, correct?


Bill
