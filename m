From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [BUG REPORT] git-svn fails to create branches if ssh+svn gets
	used as protocol.
Date: Wed, 23 Dec 2009 12:03:28 -0800
Message-ID: <20091223200328.GA11521@dcvr.yhbt.net>
References: <4B309730.5070509@fkoeberle.de> <20091223072500.GB4323@dcvr.yhbt.net> <4B326EE3.5060409@fkoeberle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Florian =?iso-8859-1?Q?K=F6berle?= <florian@fkoeberle.de>,
	Robert Zeh <robert.a.zeh@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 23 21:03:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NNXQk-00050i-WC
	for gcvg-git-2@lo.gmane.org; Wed, 23 Dec 2009 21:03:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757097AbZLWUDa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Dec 2009 15:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756135AbZLWUDa
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Dec 2009 15:03:30 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:43107 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756857AbZLWUD3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Dec 2009 15:03:29 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id D16B51F525;
	Wed, 23 Dec 2009 20:03:28 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4B326EE3.5060409@fkoeberle.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135632>

=46lorian K=F6berle <florian@fkoeberle.de> wrote:
> Hello Eric,
>=20
> your patch works great. I created successfully a branch on a svn+ssh:=
//
> repository using the patched git-svn.
>=20
> Thank you for the patch and the fast reply. I hope the patch find it'=
s
> way into the next release.

Hi Florian, thanks for the report and testing the fix.

I've just pushed the that commit and Robert's test for Junio to pull at
git://git.bogomips.org/git-svn

Eric Wong (1):
      git svn: branch/tag commands detect username in URLs

Robert Zeh (1):
      git svn: add test for a git svn gc followed by a git svn mkdirs

--=20
Eric Wong
