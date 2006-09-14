From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH (take 4)] gitweb: Use File::Find::find in git_get_projects_list
Date: Thu, 14 Sep 2006 22:24:07 +0200
Organization: At home
Message-ID: <eecdoe$n4k$1@sea.gmane.org>
References: <200609140839.56181.jnareb@gmail.com> <200609142134.33725.jnareb@gmail.com> <7vejue2omq.fsf@assigned-by-dhcp.cox.net> <200609142218.59428.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Thu Sep 14 22:24:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNxkv-0001fu-Er
	for gcvg-git@gmane.org; Thu, 14 Sep 2006 22:24:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbWINUYN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 14 Sep 2006 16:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbWINUYN
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Sep 2006 16:24:13 -0400
Received: from main.gmane.org ([80.91.229.2]:22739 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751130AbWINUYL (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Sep 2006 16:24:11 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GNxkd-0001bP-W3
	for git@vger.kernel.org; Thu, 14 Sep 2006 22:24:00 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 14 Sep 2006 22:23:59 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 14 Sep 2006 22:23:59 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27040>

Jakub Narebski wrote:

> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0# skip current directory

Perhaps it would be better to say "skip $projects_list (top) directory"=
=2E
I don't think it is important enough to resend a patch.
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
