From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-bundle questions
Date: Tue, 06 Nov 2007 22:49:55 +0100
Organization: At home
Message-ID: <fgqnhv$5di$1@ger.gmane.org>
References: <1194382443.5568.13.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 06 22:50:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpWJV-0000ni-GE
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 22:50:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754701AbXKFVuJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 16:50:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752041AbXKFVuI
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 16:50:08 -0500
Received: from main.gmane.org ([80.91.229.2]:37597 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754475AbXKFVuH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 16:50:07 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IpWJ4-0007Mu-EP
	for git@vger.kernel.org; Tue, 06 Nov 2007 21:49:58 +0000
Received: from abva250.neoplus.adsl.tpnet.pl ([83.8.198.250])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 06 Nov 2007 21:49:58 +0000
Received: from jnareb by abva250.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 06 Nov 2007 21:49:58 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abva250.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63734>

Matthew Booth wrote:

> Secondly, has anybody given any thought to allowing a user to create a
> bundle from any of the web front-ends? The reason for this request is
> that I've been doing some work for a company where only corporate
> standard desktops have internet access. They run Windows, and you can't
> install additional software on them. This makes interacting with an
> external git repository from my development servers problematic. Git
> bundles do at least make this possible, but I have to create a bundle on
> my laptop when I'm at home and transfer it to a server when I get to the
> office. This would be a whole lot easier if I could just download the
> bundle at the office.

I have though about adding such support to gitweb. The problem lies
in how to specify the commits and refs to bundle.

Perhaps separate CGI script would be an answer.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
