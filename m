From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: Git: "No you can't handle my root!" (?)
Date: Mon, 12 Oct 2009 20:30:07 +0200
Message-ID: <200910122030.08179.markus.heidelberg@web.de>
References: <20091012012826.7sffggwmm8sk0cc8@webmail.demarque.qc.ca>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: sylvain@demarque.qc.ca
X-From: git-owner@vger.kernel.org Mon Oct 12 20:36:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxPlC-00010D-7h
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 20:36:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757558AbZJLSa1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 14:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757556AbZJLSa1
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 14:30:27 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:36445 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757550AbZJLSa0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 14:30:26 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate02.web.de (Postfix) with ESMTP id BD97D12EB83FF;
	Mon, 12 Oct 2009 20:29:49 +0200 (CEST)
Received: from [89.59.75.30] (helo=pluto)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #314)
	id 1MxPeX-0004iG-00; Mon, 12 Oct 2009 20:29:49 +0200
User-Agent: KMail/1.9.10
In-Reply-To: <20091012012826.7sffggwmm8sk0cc8@webmail.demarque.qc.ca>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX18dwfgsUvskKiW6IMmX+4G5fkVJr+XCSmGq0Syc
	81fDysn9yKuq+0+599rqs/ZWZRSzrT7HR+jbcQePUnu3bu2oEq
	f5F5PswJUQpdj74HKBnw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130047>

sylvain@demarque.qc.ca, 12.10.2009:
> Git is good, Git is great! All praise the Git! :-D
> 
> What do you people think about this strange phenomena?
> 
> localhost / # git --version
> git version 1.6.4.4
> 
> localhost / # git init
> Initialized empty Git repository in //.git/
> 
> localhost / # cd etc
> localhost etc # git add X11/xorg.conf
> fatal: pathspec 'etc/X11/xorg.conf' did not match any files

"git add etc/X11/xorg.conf" works, seems to be a bug.

Markus
