From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2] Reimplement emailing part of hooks--update in contrib/hooks/post-receive-email
Date: Sat, 31 Mar 2007 13:36:37 +0200
Organization: At home
Message-ID: <eulgu1$u2m$1@sea.gmane.org>
References: <7v7it54rfj.fsf@assigned-by-dhcp.cox.net> <200703302016.27303.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 31 13:34:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXbqQ-0002Y8-N0
	for gcvg-git@gmane.org; Sat, 31 Mar 2007 13:34:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752914AbXCaLdr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 31 Mar 2007 07:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752945AbXCaLdr
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Mar 2007 07:33:47 -0400
Received: from main.gmane.org ([80.91.229.2]:44940 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752913AbXCaLdq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Mar 2007 07:33:46 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HXbpx-0001IB-Tx
	for git@vger.kernel.org; Sat, 31 Mar 2007 13:33:37 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 31 Mar 2007 13:33:37 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 31 Mar 2007 13:33:37 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43547>

Andy Parkins wrote:

> =A0git rev-list --not --all
>=20
> would now give the wrong list because "--all" in the post-receive hoo=
k
> includes the ref that we are making the email for. =A0This made it mo=
re
> difficult to show only the new revisions added by this update.

What about "git rev-list --not --all ^included" ?
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
