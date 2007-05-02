From: Jari Aalto <jari.aalto@cante.net>
Subject: Re: [PATCH] Makefile: use --unsafe option under Cygwin with asciidoc
Date: Wed, 02 May 2007 18:32:20 +0300
Organization: Private
Message-ID: <647bdywr.fsf@cante.net>
References: <ejlze97d.fsf@cante.net> <46388CBE.1080605@byu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 02 17:33:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjGpC-0000tr-Ld
	for gcvg-git@gmane.org; Wed, 02 May 2007 17:33:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993372AbXEBPc7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 May 2007 11:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993373AbXEBPc7
	(ORCPT <rfc822;git-outgoing>); Wed, 2 May 2007 11:32:59 -0400
Received: from main.gmane.org ([80.91.229.2]:41717 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2993372AbXEBPc6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2007 11:32:58 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HjGox-0001t7-Oe
	for git@vger.kernel.org; Wed, 02 May 2007 17:32:47 +0200
Received: from a81-197-175-198.elisa-laajakaista.fi ([81.197.175.198])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 02 May 2007 17:32:47 +0200
Received: from jari.aalto by a81-197-175-198.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 02 May 2007 17:32:47 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: a81-197-175-198.elisa-laajakaista.fi
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.3 (windows-nt)
Cancel-Lock: sha1:e2Jy1EthW1cY2e+Edzh8DNu3Ldg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46028>

Eric Blake <ebb9@byu.net> writes:

> According to Jari Aalto on 5/2/2007 5:49 AM:
>
>> New: variable ASCIIDOC_FLAGS was introduced. It was also added to two
>> new targets. The old ASCIIDOC_EXTRA is set to --unsafe under Cygwin to
>> ignore asciidoc error about unsafe include.
>
> This isn't just for cygwin, since it benefits any platform where the
> installed asciidoc is 8.1 or better (asciidoc is currently at 8.2.1 if you
> build the from tarballs).

I thought this was Cygwin issue only. Should --unsafe be
unconditionally enable by default?

Jari
