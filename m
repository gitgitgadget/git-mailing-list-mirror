From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: .git inside a .git: is it safe?
Date: Mon, 12 Mar 2007 23:56:59 +0100
Organization: At home
Message-ID: <et4lmo$nnj$1@sea.gmane.org>
References: <8b65902a0703121456s56008088ra14452ef7f325cf3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 12 23:54:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQtPg-0002vE-CH
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 23:54:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751710AbXCLWyl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 18:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751862AbXCLWyl
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 18:54:41 -0400
Received: from main.gmane.org ([80.91.229.2]:48709 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751710AbXCLWyl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 18:54:41 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HQtPR-0002Ng-Np
	for git@vger.kernel.org; Mon, 12 Mar 2007 23:54:29 +0100
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 12 Mar 2007 23:54:29 +0100
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 12 Mar 2007 23:54:29 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42085>

Guilhem Bonnefille wrote:

> Hi,
> 
> I'm actually working on the packaging of a project. To do so, I use
> two Git repositories:
> - one to follow the main project
> - one to manage my updates on this project.
> 
> But, the matter is I cannot merge the both root. I need to have the
> main project sources in a subdirectory of my own project. My workspace
> is as follow: myproject/sub/tree/mainproject
> 
> With SVN, I think such things are handled with svn:external.
> 
> Actually, with Git, I frequently copy the mainproject inside its
> subtree in my workspace.
> 
> 
> But, I recently discover that everything seems fine if I include the
> Git repo of mainproject inside the Git repo of my project. The layout
> lloks like this:
> myproject
> |- .git
> |- sub
>   |- tree
>     |- mainproject
>       |- .git
> 
> 
> It seems to work. But do you think such layout is "safe" ?

IIRC Junio uses similar layout managing todo branch in git.git
(which comes from separate repository).
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
