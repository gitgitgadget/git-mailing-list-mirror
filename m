From: Sergei Organov <osv@javad.com>
Subject: Re: git-blame.el: what is format-spec?
Date: Fri, 04 Dec 2009 19:59:43 +0300
Message-ID: <87ljhi3cao.fsf@osv.gnss.ru>
References: <87vdgm3e1k.fsf@osv.gnss.ru> <m2fx7qae49.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Fri Dec 04 18:00:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGbVY-0000kA-SN
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 17:59:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbZLDQ7j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 11:59:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbZLDQ7j
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 11:59:39 -0500
Received: from javad.com ([205.178.136.214]:39046 "EHLO 02aef2d.netsolvps.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932189AbZLDQ7i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 11:59:38 -0500
Received: (qmail 30011 invoked from network); 4 Dec 2009 16:59:45 +0000
Received: from unknown (HELO osv.gnss.ru) (89.175.180.246)
  by javad.com with (AES256-SHA encrypted) SMTP; 4 Dec 2009 16:59:45 +0000
Received: from osv by osv.gnss.ru with local (Exim 4.69)
	(envelope-from <osv@osv.gnss.ru>)
	id 1NGbVP-0005JU-Br; Fri, 04 Dec 2009 19:59:43 +0300
In-Reply-To: <m2fx7qae49.fsf@igel.home> (Andreas Schwab's message of "Fri\, 04 Dec 2009 17\:38\:30 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134539>

Andreas Schwab <schwab@linux-m68k.org> writes:
> Sergei Organov <osv@javad.com> writes:
>
>> What is format-spec function in current git-blame.el? Neither my GNU
>> Emacs 22.2.1 nor Google knows anything about it.
>
> It's part of Emacs since more than 9 years, imported from Gnus.
>

Thanks, I now see it in Gnus on my own computer, in
lisp/gnus/format-spec.el.gz.

GNU Emacs 22.2.1 (i486-pc-linux-gnu, GTK+ Version 2.12.11) of 2008-11-10
on raven, modified by Debian 

However, isn't it a bad idea to require Gnus(!) for git-blame to run? Gnus
is not installed on our server where I've encountered the problem. Was
format-spec actually moved to core emacs recently?

-- Sergei.
