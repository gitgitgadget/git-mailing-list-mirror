From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: .git/info/refs
Date: Wed, 24 Jan 2007 10:28:56 +0100
Organization: At home
Message-ID: <ep78r0$h2u$1@sea.gmane.org>
References: <45B70D06.3050506@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 24 10:28:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9eQg-0000ee-SK
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 10:28:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750696AbXAXJ20 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 04:28:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750725AbXAXJ20
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 04:28:26 -0500
Received: from main.gmane.org ([80.91.229.2]:34836 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750696AbXAXJ2Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 04:28:25 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H9eQO-0002qN-Pw
	for git@vger.kernel.org; Wed, 24 Jan 2007 10:28:12 +0100
Received: from host-81-190-20-200.torun.mm.pl ([81.190.20.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 24 Jan 2007 10:28:12 +0100
Received: from jnareb by host-81-190-20-200.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 24 Jan 2007 10:28:12 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-20-200.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37613>

H. Peter Anvin wrote:

> Would it be an incompatible change to add the commit date (and perhaps 
> the author date) to .git/info/refs?  I believe that would make it 
> possible to dramatically (orders of magnitude) speed up the generation 
> of the gitweb index page, which is easily the most expensive gitweb page 
> to generate.

With new gitweb and new git it is not that expensive. It is now one call
to git-for-each-ref per repository.

Besides, we can't rely that .git/info/refs is up to date, or even exists.
It is for dumb protocols, not for gitweb.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
