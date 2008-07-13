From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] bash completion: Fix the . -> .. revision range completion
Date: Sun, 13 Jul 2008 14:11:38 +0200
Organization: At home
Message-ID: <g5crdp$u30$1@ger.gmane.org>
References: <20080713111847.29801.8969.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 13 14:13:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KI0RZ-00061V-5i
	for gcvg-git-2@gmane.org; Sun, 13 Jul 2008 14:12:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752807AbYGMMLq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jul 2008 08:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752822AbYGMMLp
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 08:11:45 -0400
Received: from main.gmane.org ([80.91.229.2]:59440 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752335AbYGMMLp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 08:11:45 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KI0Qa-00021H-6c
	for git@vger.kernel.org; Sun, 13 Jul 2008 12:11:44 +0000
Received: from abvf164.neoplus.adsl.tpnet.pl ([83.8.203.164])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 13 Jul 2008 12:11:44 +0000
Received: from jnareb by abvf164.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 13 Jul 2008 12:11:44 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvf164.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88307>

Petr Baudis wrote:

> This patch will make Git perform the . -> .. completion in
> __git_complete_revlist only if there is no filename starting with
> the entered prefix available. =A0At few places, filename could not oc=
cur
> when calling __git_complete_revlist; however, taking this into accoun=
t
> did not seem worth complicating the code further.

Thanks a lot!  This is what I was waiting for...

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
