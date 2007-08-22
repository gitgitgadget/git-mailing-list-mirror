From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: empty directories
Date: Wed, 22 Aug 2007 02:06:39 +0200
Organization: At home
Message-ID: <fafumf$fb4$1@sea.gmane.org>
References: <1187716461.5986.71.camel@beauty>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 22 02:06:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INdkO-0000jB-5f
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 02:06:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbXHVAGw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Aug 2007 20:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751026AbXHVAGw
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Aug 2007 20:06:52 -0400
Received: from main.gmane.org ([80.91.229.2]:46596 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750885AbXHVAGv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2007 20:06:51 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1INdkH-0007LR-SH
	for git@vger.kernel.org; Wed, 22 Aug 2007 02:06:49 +0200
Received: from host-89-229-8-65.torun.mm.pl ([89.229.8.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 22 Aug 2007 02:06:49 +0200
Received: from jnareb by host-89-229-8-65.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 22 Aug 2007 02:06:49 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-8-65.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56340>

Josh England wrote:


> Git doesn't seem to allow me to add an empty directory to the index, or
> even nested empty directories.  Is there any way to do this?  What is
> the reasoning?  I've got a use case where having empty directories in my
> git repository would be *very* valuable.  Any information and help is
> greatly appreciated.

Git does not track empty directories [yet], but you can use empty .gitignore
file trick to mark "empty" directories to be added.

There were some discussion about this on git mailing list (see archives),
and this issue is most probably mentioned on GitFaq page in git wiki.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
