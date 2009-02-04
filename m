From: Stefan =?utf-8?b?TsOkd2U=?= <stefan.naewe+git@gmail.com>
Subject: Re: git daemon on different port
Date: Wed, 4 Feb 2009 11:27:17 +0000 (UTC)
Message-ID: <loom.20090204T112600-689@post.gmane.org>
References: <loom.20090204T111635-586@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 04 12:28:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUfw9-0002yW-GY
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 12:28:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752478AbZBDL11 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Feb 2009 06:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752462AbZBDL10
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 06:27:26 -0500
Received: from main.gmane.org ([80.91.229.2]:53898 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752341AbZBDL10 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 06:27:26 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LUfuf-0005n4-5N
	for git@vger.kernel.org; Wed, 04 Feb 2009 11:27:25 +0000
Received: from lxsrv96.atlas.de ([194.156.172.86])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 11:27:25 +0000
Received: from stefan.naewe+git by lxsrv96.atlas.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 11:27:25 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 194.156.172.86 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/528.7 (KHTML, like Gecko) Iron/1.0.155.0 Safari/528.7)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108335>

Stefan N=C3=A4we <stefan.naewe+git <at> gmail.com> writes:

>=20
> Hi all.
>=20
> git daemon --port=3D12345....
>=20
> would set the git daemon to listen on port number 12345, right?
>=20
> Question: What would be the clone URL then ?

It would of course be

 git clone git://hostname:12345/path/to/repo.git

Who would have guessed that...

Thanks to anyone who helped ;-)

Stefan
