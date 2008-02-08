From: Bruno Cesar Ribas <ribas@c3sl.ufpr.br>
Subject: Re: [PATCH] gitweb: Use the config file to set repository owner's
	name.
Date: Fri, 8 Feb 2008 11:53:27 -0200
Message-ID: <20080208135327.GC30264@c3sl.ufpr.br>
References: <1202445714-28971-1-git-send-email-ribas@c3sl.ufpr.br> <1202445714-28971-2-git-send-email-ribas@c3sl.ufpr.br> <m3myqbhg4o.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com,
	Git Managment for C3SL <git@git.c3sl.ufpr.br>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 14:54:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNTgV-0003IP-GV
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 14:54:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755722AbYBHNx6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 08:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755655AbYBHNx6
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 08:53:58 -0500
Received: from mx.inf.ufpr.br ([200.17.202.3]:60888 "EHLO urquell.c3sl.ufpr.br"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755505AbYBHNx5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 08:53:57 -0500
Received: from localhost (unknown [189.1.136.222])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: ribas)
	by urquell.c3sl.ufpr.br (Postfix) with ESMTP id 8382F700003D9;
	Fri,  8 Feb 2008 11:53:55 -0200 (BRST)
Content-Disposition: inline
In-Reply-To: <m3myqbhg4o.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73090>

On Fri, Feb 08, 2008 at 02:55:33AM -0800, Jakub Narebski wrote:
> Bruno Ribas <ribas@c3sl.ufpr.br> writes:
> 
><snip> 
> First, I think the empty lines added are not needed.

I made those empty lines because original code had same empty lines above, I
just let it to have same pattern, but I can remove. Should I remove?! I'll
resend without it, and with $git_dir set.
> 
> Second, git_get_project_config() subroutine _REQUIRES_ for $git_dir to
> be set. So you have to set $git_dir before checking repo config; then
> you can reuse $git_dir in checking file owner.
> 
> -- 
> Jakub Narebski
> Poland
> ShadeHawk on #git

-- 
Bruno Ribas - ribas@c3sl.ufpr.br
http://web.inf.ufpr.br/ribas
C3SL: http://www.c3sl.ufpr.br 
