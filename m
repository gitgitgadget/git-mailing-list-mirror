From: Eric Wong <normalperson@yhbt.net>
Subject: Re: 'git svn fetch' keeps giving a error after freezing
Date: Wed, 8 Jul 2009 16:59:00 -0700
Message-ID: <20090708235900.GB20768@dcvr.yhbt.net>
References: <h31vg6$b38$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Graeme Geldenhuys <graemeg@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 09 01:59:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOh2a-0002mU-D6
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 01:59:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756080AbZGHX7D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2009 19:59:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755799AbZGHX7B
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jul 2009 19:59:01 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:43376 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754972AbZGHX7A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2009 19:59:00 -0400
Received: from localhost (unknown [12.186.229.34])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 622171F605;
	Wed,  8 Jul 2009 23:59:00 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <h31vg6$b38$1@ger.gmane.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122927>

Graeme Geldenhuys <graemeg@gmail.com> wrote:
> Hi,
>
> I'm using git-1.6.3.3 under Ubuntu Linux 8.04.2
>
> I'm trying to convert (clone) a SubVersion repository to Git, so I can  
> host the mirror on GitHub, but for the last 4 days I don't get very far.  
> It seems to be getting a few files, then freezes and then gives the  
> error shown below. I'm now stuck around r2665 out of about 14,000  
> revisions. :-(
>
> I have done such a clone before using a different SVN repository and  
> pulling in around 13,000 revisions, so my 'git svn' commands should work.
>
> ==============================
> $ git svn fetch
> .....
>         A       fixes_2_0/fv/gadgets.pas
>         A       fixes_2_0/fv/colortxt.pas
>         A       fixes_2_0/fv/outline.pas
> RA layer request failed: REPORT of '/svn/fpc/!svn/vcc/default': Could  
> not read response body: connection was closed by server  
> (http://svn2.freepascal.org) at /usr/local/libexec/git-core/git-svn line  
> 4505

Does restarting "git svn fetch" work?  Can you checkout exactly that
revision from SVN itself?  It could be an extremely large file that
SVN has trouble serving, but as far as I can tell it's a problem
with the server or your connection and not with git svn.

I'll give it a shot when I'm on a better connection/machine later.

-- 
Eric Wong
