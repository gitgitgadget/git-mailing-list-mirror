From: Tobia Conforto <tobia.conforto@gmail.com>
Subject: Re: Issues with file status over samba
Date: Fri, 31 Jul 2009 10:03:21 +0000 (UTC)
Message-ID: <loom.20090731T091646-373@post.gmane.org>
References: <3A1A5212-FFB4-4B0D-A972-C90EA336F5D9@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 31 12:11:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWp41-0003MS-Cs
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 12:10:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752033AbZGaKKF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2009 06:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752025AbZGaKKF
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 06:10:05 -0400
Received: from main.gmane.org ([80.91.229.2]:37492 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751630AbZGaKKD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2009 06:10:03 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1MWp3r-0001xf-5W
	for git@vger.kernel.org; Fri, 31 Jul 2009 10:10:03 +0000
Received: from static-217-133-32-17.clienti.tiscali.it ([217.133.32.17])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 31 Jul 2009 10:10:03 +0000
Received: from tobia.conforto by static-217-133-32-17.clienti.tiscali.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 31 Jul 2009 10:10:03 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 217.133.32.17 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_7; en-us) AppleWebKit/530.19.2 (KHTML, like Gecko) Version/4.0.2 Safari/530.19)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124536>

JiHO wrote:
> When working on a git repository on a mounted samba share, I am having
> trouble because some files are detected as changed while they are not.
> git status works OK but git GUIs (git gui and gitX on mac OS X) show
> the problem.

I'm seeing this problem too, accessing a git repository on a Samba share.

Steps to reproduce:
- create git repository on linux;
- connect from OS X over Samba;
- git status (over samba) reports all files as changed;
- git diff works, it only shows the actual differences;
- after the first git diff, any subsequent git status will work,
  even after disconnecting and reconnecting to the samba share.

Tobia
