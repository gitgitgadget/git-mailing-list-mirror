From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [msysGit] [FYI][PATCH] Customizing the WinGit installer
Date: Mon, 06 Oct 2008 09:00:37 -0700 (PDT)
Message-ID: <m3zllhpvby.fsf@localhost.localdomain>
References: <20081003122727.GE10360@machine.or.cz>
	<alpine.DEB.1.00.0810061621110.22125@pacific.mpi-cbg.de.mpi-cbg.de>
	<20081006141840.GO10360@machine.or.cz>
	<alpine.DEB.1.00.0810061718240.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, msysgit@googlegroups.com,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 06 18:05:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmsWx-0004ne-Cd
	for gcvg-git-2@gmane.org; Mon, 06 Oct 2008 18:01:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752419AbYJFQAo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 12:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752503AbYJFQAo
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 12:00:44 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:7512 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752289AbYJFQAm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 12:00:42 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1057942nfc.21
        for <git@vger.kernel.org>; Mon, 06 Oct 2008 09:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=I4Kh0OiYghqcLQ0Lmke+AkoRQpN7pOnyqZNbYg8nXG8=;
        b=Mo+OJCGWZlSySgWBR1OdhQ0WeyWZ3b3Iaxx2ChhYFucu+3DmeSchMTh/bXbuR7Bzgg
         dSf3AdLF+Dc8hP1vYCI0yMBmVLKKmpkh4kRLgWpDbeL0tah5loDGpUjnaumvKaRZ14/o
         f3SKzZYHsXeHYXDAZlMwJMRQe/zl63q3jqt4k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=fx9aZ5/GPNKcGrF7+XIdVLHov7BZs8C/Qtd5BtTA5WZkAF6S2pVQaOA1Iyq5N0wRys
         PkHBhJFMm0C8nP3X+8/Md3gedhSkQJHEHNB+uBhEncJVOyF3bM2cG3/j3Y/KJq49Y6aC
         xEzVxOpvI2jV2RRJBo2pkpTJojplnNOUAUSSw=
Received: by 10.210.44.1 with SMTP id r1mr6509639ebr.153.1223308840569;
        Mon, 06 Oct 2008 09:00:40 -0700 (PDT)
Received: from localhost.localdomain (abwo50.neoplus.adsl.tpnet.pl [83.8.238.50])
        by mx.google.com with ESMTPS id c22sm7782401ika.1.2008.10.06.09.00.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 06 Oct 2008 09:00:37 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m96G0ZMI021507;
	Mon, 6 Oct 2008 18:00:36 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m96G0XNo021504;
	Mon, 6 Oct 2008 18:00:33 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <alpine.DEB.1.00.0810061718240.22125@pacific.mpi-cbg.de.mpi-cbg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97598>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> On Mon, 6 Oct 2008, Petr Baudis wrote:
> > On Mon, Oct 06, 2008 at 04:22:08PM +0200, Johannes Schindelin wrote:
> > > On Fri, 3 Oct 2008, Petr Baudis wrote:
> > > 
> > > > -InfoBeforeFile=gpl-2.0.rtf
> > > 
> > > I'd rather keep it in, especially in a corporate environment.
> > 
> >   why? How is it relevant for the users?
> 
> To give them an idea about their _rights_.  Because they are entitled by 
> the GPL to get -- in source -- the changes that were done to that 
> particular distributions.
> 
> Speaking from experience, companies usually do not want to tell you about 
> your rights with regard to free software.
> 
> And in this case, I have a personal interest.  I feel that my efforts to 
> the msysGit project are not really rewarded.  People like to use it, but 
> they hardly give anything back (you being a very notable exception).

Wouldn't it be better to keep it, but move it from EULA position
to for example 'License' item in 'Help' entry (below 'About') in
gitk and git-gui?  IIRC there was a lot of controversy about Firefox
using EULA, although MS Windows users are most probably used to it...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
