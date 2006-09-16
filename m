From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: export-ok option
Date: Sat, 16 Sep 2006 21:44:30 +0200
Organization: At home
Message-ID: <eehk5p$ipm$2@sea.gmane.org>
References: <20060916192750.GA27008@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sat Sep 16 21:45:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOg6H-0001aY-A1
	for gcvg-git@gmane.org; Sat, 16 Sep 2006 21:45:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbWIPTpI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Sep 2006 15:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751465AbWIPTpI
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Sep 2006 15:45:08 -0400
Received: from main.gmane.org ([80.91.229.2]:50394 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751459AbWIPTpG (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Sep 2006 15:45:06 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1GOg62-0001YH-VH
	for git@vger.kernel.org; Sat, 16 Sep 2006 21:45:02 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 16 Sep 2006 21:45:02 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 16 Sep 2006 21:45:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27129>

Matthias Lederhofer wrote:

> Similar to git-daemon checking for git-daemon-export-ok this
> introduces an optional check before showing a repository in gitweb.
> 
> I also changed the 'No such directory' error message to 'No such
> project' because the user visiting my gitweb should not know what
> directories I have in the project root directory.
> 
> undef $project; is used to prevent displaying the description.
> ---
> Perhaps there should be another option which allows only those
> repositories to be shown which are in $projects_list.

I don't know what this is for (well, except replacing 'No such directory'
error message by 'No such project'). If you want only some of repositories
to be present in gitweb, you simply use $projects_list _file_ (e.g. using
new "project_index" action to generate it) and edit it to contain only the
repositories you want to be shown in gitweb.

Unless of course the person who hosts gitweb, and the person who owns
repository are uncommunicado, and you want the power of deciding if
repository is present in gitweb or not to be placed in the hands of
repository owner. Still, gitweb must be configured for this.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
