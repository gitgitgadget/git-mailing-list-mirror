From: Eygene Ryabinkin <rea-git@codelabs.ru>
Subject: Re: [PATCH] git-svn testsuite: use standard configuration for
	Subversion tools
Date: Fri, 1 May 2009 23:10:07 +0400
Message-ID: <Z0zFdWIzyQzuBQjCf+Jk/nJtvIw@BjOYljNjUB0FD+/Fw7pzaXMw/Hc>
References: <BfKhGHDBpSzjNF/dt4ZDx88u9wI@BjOYljNjUB0FD+/Fw7pzaXMw/Hc> <7vfxfowugm.fsf@gitster.siamese.dyndns.org>
Reply-To: rea-git@codelabs.ru
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: normaperson@yhbt.net, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 01 21:10:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lzy8O-0004H6-GN
	for gcvg-git-2@gmane.org; Fri, 01 May 2009 21:10:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757010AbZEATKP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2009 15:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756982AbZEATKP
	(ORCPT <rfc822;git-outgoing>); Fri, 1 May 2009 15:10:15 -0400
Received: from 0.mx.codelabs.ru ([144.206.177.45]:58261 "EHLO 0.mx.codelabs.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756252AbZEATKO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2009 15:10:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=simple; s=one; d=codelabs.ru;
	h=Received:Date:From:To:Cc:Subject:Message-ID:Reply-To:References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:Sender;
	b=Tz1p+I6loYb9W5d8WVTooAcjZ2q45d7/KhvuTW2Clu8JGoVbSjQwOKtJND9y+pNzshS9saj2y81MjqtiE87uBhG6J/KjcBL+ae3N+juc372u9ze0zqNHDSfd3+jg1DPqPF1zM+s1stbGqob/4ssEWK1rJSR657f+oK1jmxf+qEs=;
Received: from amnesiac.at.no.dns (ppp83-237-107-194.pppoe.mtu-net.ru [83.237.107.194])
	by 0.mx.codelabs.ru with esmtpsa (TLSv1:AES256-SHA:256)
	id 1Lzy7d-0000jR-CD; Fri, 01 May 2009 23:10:09 +0400
Content-Disposition: inline
In-Reply-To: <7vfxfowugm.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118089>

Junio, good day.

Fri, May 01, 2009 at 11:26:17AM -0700, Junio C Hamano wrote:
> Eygene Ryabinkin <rea-git@codelabs.ru> writes:
> 
> > @@ -54,6 +56,20 @@ poke() {
> >  	test-chmtime +1 "$1"
> >  }
> >  
> > +# We need this, because we should pass empty configuration directory to
> > +# the 'svn commit' to avoid automated property changes and other stuff
> > +# that could be set from user's configuration files in ~/.subversion.
> > +svn_cmd () {
> > +	local cmd
> 
> Does this work without your /bin/sh being bash?

Yes.

Naturally speaking, my /bin/sh isn't bash, but I had substituted it with
the binary of bash 4.0.10(2) and it works.  Moreover, I had just run
t/t9100-*.sh on the RHEL 4.x -- works too.

What are your concerns, 'local'?
-- 
Eygene
