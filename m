From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [Announce] GIT v1.5.0-rc2
Date: Sun, 21 Jan 2007 23:45:07 +0100
Organization: At home
Message-ID: <ep0qc6$bph$1@sea.gmane.org>
References: <7v64b04v2e.fsf@assigned-by-dhcp.cox.net> <7v3b6439uh.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0701212234520.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 21 23:45:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8lQx-0007s4-O1
	for gcvg-git@gmane.org; Sun, 21 Jan 2007 23:45:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751739AbXAUWpE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Jan 2007 17:45:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751740AbXAUWpE
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jan 2007 17:45:04 -0500
Received: from main.gmane.org ([80.91.229.2]:51626 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751739AbXAUWpB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jan 2007 17:45:01 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H8lQX-0005mC-6U
	for git@vger.kernel.org; Sun, 21 Jan 2007 23:44:42 +0100
Received: from host-81-190-20-200.torun.mm.pl ([81.190.20.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 21 Jan 2007 23:44:41 +0100
Received: from jnareb by host-81-190-20-200.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 21 Jan 2007 23:44:41 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-20-200.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37356>

Johannes Schindelin wrote:

> On Sun, 21 Jan 2007, Junio C Hamano wrote:

>> * Reflog
>> 
>>  - Reflog records the history of where the tip of each branch
>>    was at each moment.
> 
> It might make sense to reformulate that:
> 
>       Reflog records the history from the view point of the local 
>       repository. In other words, regardless of the real history,
>       the reflog shows the history as seen by one particular repository
>       (this enables you to ask "what was the current revision in _this_
>       repository, yesterday at 1pm?").

I think that _both_ sentences are right. Reflog records history of where the
tip of each branch was at each moment, logging also what command was used
to move tip of branch (was it commit, amending commit, rebase, reset, or
creating branch anew, git-am or pull).

But where tip of each branch was is purely local matter. What is global
is DAG of commits, refs are always as seen by one particular repository.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
