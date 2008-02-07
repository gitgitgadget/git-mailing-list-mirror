From: Bruno Cesar Ribas <ribas@c3sl.ufpr.br>
Subject: Re: [PATCH] gitweb: Use config file or file for repository owner's
	name.
Date: Thu, 7 Feb 2008 02:12:46 -0200
Message-ID: <20080207041246.GA32595@c3sl.ufpr.br>
References: <1201670898-15076-1-git-send-email-ribas@c3sl.ufpr.br> <7vwsprj0sv.fsf@gitster.siamese.dyndns.org> <20080131023629.GB7778@c3sl.ufpr.br> <7vsl0eg16c.fsf@gitster.siamese.dyndns.org> <7vabmmg0cb.fsf@gitster.siamese.dyndns.org> <20080205044121.GA13263@c3sl.ufpr.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 07 05:13:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMy92-0003xz-43
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 05:13:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753017AbYBGENK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 23:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752990AbYBGENJ
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 23:13:09 -0500
Received: from mx.inf.ufpr.br ([200.17.202.3]:48074 "EHLO urquell.c3sl.ufpr.br"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752250AbYBGENI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 23:13:08 -0500
Received: from localhost (unknown [189.1.135.222])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: ribas)
	by urquell.c3sl.ufpr.br (Postfix) with ESMTP id 7F8B1700003EC;
	Thu,  7 Feb 2008 02:13:05 -0200 (BRST)
Content-Disposition: inline
In-Reply-To: <20080205044121.GA13263@c3sl.ufpr.br>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72888>

On Tue, Feb 05, 2008 at 02m41:21AM -0200, Bruno Cesar Ribas wrote:
><alll snip>

Hello again,

I made another bench, but testing time difference between a gitweb.cgi
without reading gitweb.owner AND reading it.

These times i got with a 1000projects running 2 dd to generate disk IO.
Here comes the resultm
NO projects_list  projects_list
16m30s69          15m10s74       default gitweb, using FS's owner
16m07s40          15m24s34       patched to get gitweb.owner
16m37s76          15m59s32       same above, but without gitweb.owner

Now results for a 1000projects on an idle machine.
NO projects_list  projects_list
1m19s08           1m09s55       default gitweb, using FS's owner
1m17s58           1m09s55       patched to get gitweb.owner
1m18s49           1m08s96       same above, but without gitweb.owner

*For "projects_list" column, gitweb got owner via project_list file.

Small fluctuation occurs. But speed is essencially the same.

My guess is that adding a gitweb.owner there's no problem and helps people
to get owner when there's no need to maintain a project_list or maintain
this file is not wanted.

Bruno

-- 
Bruno Ribas - ribas@c3sl.ufpr.br
http://web.inf.ufpr.br/ribas
C3SL: http://www.c3sl.ufpr.br 
