From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [Announce] GIT v1.5.0-rc2
Date: Mon, 22 Jan 2007 00:08:48 +0100
Message-ID: <200701220008.49158.jnareb@gmail.com>
References: <7v64b04v2e.fsf@assigned-by-dhcp.cox.net> <ep0qc6$bph$1@sea.gmane.org> <Pine.LNX.4.63.0701212348070.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Jan 22 00:08:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8lnl-0004Yu-Vw
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 00:08:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751761AbXAUXIL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Jan 2007 18:08:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751765AbXAUXIL
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jan 2007 18:08:11 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:2449 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761AbXAUXIJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jan 2007 18:08:09 -0500
Received: by ug-out-1314.google.com with SMTP id 44so905482uga
        for <git@vger.kernel.org>; Sun, 21 Jan 2007 15:08:08 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=sv4kdgJ1oHj0IhD85hX/O5R7A4uemPxhq4+6JqZHmm8/blCbqK923h6FvcuR00SFGq+7NB0GH1RWq7ODRQKp2ei4WbwPppQS2sGh2O8xLHKfQp3OysM0+wf+gUWS0ltUwSqY92knj2M3Z5I+L3O0wUtnYiDxpF7rFI5DaSJbPSI=
Received: by 10.67.97.7 with SMTP id z7mr6576547ugl.1169420887999;
        Sun, 21 Jan 2007 15:08:07 -0800 (PST)
Received: from host-81-190-20-200.torun.mm.pl ( [81.190.20.200])
        by mx.google.com with ESMTP id b23sm5954175ugd.2007.01.21.15.08.06;
        Sun, 21 Jan 2007 15:08:07 -0800 (PST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.63.0701212348070.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37359>

Johannes Schindelin wrote:

> On Sun, 21 Jan 2007, Jakub Narebski wrote:
> 
>> Johannes Schindelin wrote:
>> 
>>> On Sun, 21 Jan 2007, Junio C Hamano wrote:
>> 
>>>> * Reflog
>>>> 
>>>>  - Reflog records the history of where the tip of each branch
>>>>    was at each moment.
>>> 
>>> It might make sense to reformulate that:
>>> 
>>>       Reflog records the history from the view point of the local 
>>>       repository. In other words, regardless of the real history,
>>>       the reflog shows the history as seen by one particular repository
>>>       (this enables you to ask "what was the current revision in _this_
>>>       repository, yesterday at 1pm?").
>> 
>> I think that _both_ sentences are right. Reflog records history of where the
>> tip of each branch was at each moment, logging also what command was used
>> to move tip of branch (was it commit, amending commit, rebase, reset, or
>> creating branch anew, git-am or pull).
>> 
>> But where tip of each branch was is purely local matter. What is global
>> is DAG of commits, refs are always as seen by one particular repository.
> 
> What I meant was: people not familiar with git development will probably 
> not understand the shorter, concise statement. They will not know off-hand 
> that there is a difference between the history of development, and the 
> history, as seen from the local repository's viewpoint.
> 
> So of course, both sentences are right.
> 
> Your point -- that reflog also records the action -- is less important 
> IMHO. It is just meta-data of the local view.
> 
> To your second point: the global history remains global, of course. But 
> this is what you _usually_ refer to, when talking about the development 
> history, anyway. Therefore, to motivate reflogs, you should point out the 
> differences between local and global history.
> 
> And this means to at least _mention_ the word "local".

So I'd say:

  - Reflog records local history of where the tip of each branch
    was at each moment.

I think both "local" and "tip of branch" are important
for understanding reflog.

-- 
Jakub Narebski
Poland
