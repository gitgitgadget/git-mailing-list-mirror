From: Eygene Ryabinkin <rea-git@codelabs.ru>
Subject: Re: [PATCH] Add the WITH_P4IMPORT knob to the Makefile.
Date: Tue, 27 Mar 2007 15:22:03 +0400
Message-ID: <20070327112202.GB14837@codelabs.ru>
References: <Pine.LNX.4.63.0703211522320.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070321144008.GE14837@codelabs.ru> <Pine.LNX.4.63.0703211630160.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070321160126.GH14837@codelabs.ru> <7v1wji371q.fsf@assigned-by-dhcp.cox.net> <20070326073143.GB44578@codelabs.ru> <20070326073250.GC44578@codelabs.ru> <7v1wjcz9x1.fsf@assigned-by-dhcp.cox.net> <20070327102601.GN14837@codelabs.ru> <7vps6vnehz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Mar 27 13:22:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HW9kl-0002HE-PY
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 13:22:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753801AbXC0LWN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 07:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753811AbXC0LWN
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 07:22:13 -0400
Received: from pobox.codelabs.ru ([144.206.177.45]:58505 "EHLO
	pobox.codelabs.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753801AbXC0LWM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 07:22:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=simple; s=one; d=codelabs.ru;
	h=Received:Date:From:To:Cc:Message-ID:References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:Sender:X-Spam-Status:Subject;
	b=jdaF/PjEOEUTHyFFsSLLC8RrKJz7Z5PyPzPqRZYI/EcNnFgcOonzJFgCIkj2aIsywDD5oa4+FDLMCPlVGgQW/EvdKiq7MgmBPTY3cfvRSTQWlDl7Z/pY7yN9JwF+Qi0UeaxtXAI4pCCoj2zorjRqugN/8LvSryvRhGq/x7XSs60=;
Received: from codelabs.ru (pobox.codelabs.ru [144.206.177.45])
	by pobox.codelabs.ru with esmtpsa (TLSv1:AES256-SHA:256)
	id 1HW9kg-000Des-1O; Tue, 27 Mar 2007 15:22:10 +0400
Content-Disposition: inline
In-Reply-To: <7vps6vnehz.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, score=-1.9 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_50
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43264>

Tue, Mar 27, 2007 at 03:54:16AM -0700, Junio C Hamano wrote:
> Eygene Ryabinkin <rea-git@codelabs.ru> writes:
> 
> > WITH_P4IMPORT: enables the installation of the Perforce import
> > script.
> >
> > Signed-off-by: Eygene Ryabinkin <rea-git@codelabs.ru>
> 
> Thanks.

You're welcome ;))

> I wonder if we need to update git.spec.in file if we
> were to take this patch.

Created a quick patch, but have no Linux host with autoconf >= 2.59
at hand, so can not test. The patch follows.
-- 
Eygene
