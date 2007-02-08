From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Question on git fetch to bare repo
Date: Thu, 08 Feb 2007 23:34:53 +0100
Organization: At home
Message-ID: <eqg8fa$ru3$1@sea.gmane.org>
References: <17867.41997.561756.679778@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 08 23:34:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFHq5-00075S-O6
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 23:34:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423499AbXBHWd6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 17:33:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423500AbXBHWd6
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 17:33:58 -0500
Received: from main.gmane.org ([80.91.229.2]:40030 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423499AbXBHWd5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 17:33:57 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HFHpj-00032l-L5
	for git@vger.kernel.org; Thu, 08 Feb 2007 23:33:39 +0100
Received: from host-81-190-29-4.torun.mm.pl ([81.190.29.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 08 Feb 2007 23:33:39 +0100
Received: from jnareb by host-81-190-29-4.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 08 Feb 2007 23:33:39 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-29-4.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39112>

Bill Lear wrote:

> I have a public bare repo I created yesterday:
> 
> % mkdir project && cd project
> % git --bare init-db --shared
> % git --bare fetch git://source/project
> [All seems well]

_Seems_ well

  % git clone --bare --shared git://source/project project

is a proper invocation.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
