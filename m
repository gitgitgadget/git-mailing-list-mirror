From: Enrico Weigelt <weigelt@metux.de>
Subject: Re: Using Origin hashes to improve rebase behavior
Date: Sun, 20 Feb 2011 18:49:14 +0100
Message-ID: <20110220174914.GA23366@nibiru.local>
References: <m21v3fvbix.fsf@hermes.luannocracy.com>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 20 18:59:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrDZE-00032T-Rl
	for gcvg-git-2@lo.gmane.org; Sun, 20 Feb 2011 18:59:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754656Ab1BTR7Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Feb 2011 12:59:24 -0500
Received: from caprica.metux.de ([82.165.128.25]:44416 "EHLO
	mailgate.caprica.metux.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754634Ab1BTR7X (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Feb 2011 12:59:23 -0500
Received: from mailgate.caprica.metux.de (localhost.localdomain [127.0.0.1])
	by mailgate.caprica.metux.de (8.14.4/8.14.4) with ESMTP id p1KHu6S0010656
	for <git@vger.kernel.org>; Sun, 20 Feb 2011 18:56:24 +0100
Received: (from uucp@localhost)
	by mailgate.caprica.metux.de (8.14.4/8.14.4/Submit) with UUCP id p1KHtbKV010579
	for git@vger.kernel.org; Sun, 20 Feb 2011 18:55:37 +0100
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id p1KHnErd012921
	for git@vger.kernel.org; Sun, 20 Feb 2011 18:49:14 +0100
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <m21v3fvbix.fsf@hermes.luannocracy.com>
User-Agent: Mutt/1.4.1i
X-Terror: bin laden, kill bush, Briefbombe, Massenvernichtung, KZ, 
X-Nazi: Weisse Rasse, Hitlers Wiederauferstehung, 42, 
X-Antichrist: weg mit schaeuble, ausrotten, heiliger krieg, al quaida, 
X-Killer: 23, endloesung, Weltuntergang, 
X-Doof: wer das liest ist doof
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167427>

* John Wiegley <johnw@boostpro.com> wrote:

<snip>

> Later, there is work on master which changes the same lines of code that 3'
> has changed.  The commit which changes 3' is e*
> 
>     a   b   c   3'  d   e*  f
>     o---o---o---o---o---o---o
>              \
>               o---o---o---o
>               1   2   3   4
> 
> At a later date, I want to rebase the private branch onto master.  What will
> happen is that the changes in 3 will conflict with the rewritten changes in
> e*.  However, I'd like Git to know that 3 was already incorporated at some
> earlier time, and *not consider it during the rebase*, since it doesn't need
> to.

I'm solving these situations by incremental rebase (rebasing onto earlier
commits than the head, iteratively). A command for that would be nice.


cu
-- 
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------
