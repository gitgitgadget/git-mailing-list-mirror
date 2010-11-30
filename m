From: Jan =?UTF-8?B?S3LDvGdlcg==?= <jk@jk.gs>
Subject: Re: http://tech.slashdot.org/comments.pl?sid=1885890&cid=34358134
Date: Tue, 30 Nov 2010 11:08:36 +0100
Message-ID: <20101130110836.2549aa78@jk.gs>
References: <AANLkTinTsn4PP8VxJX=pUOYKtoybCxqB0+-p9kNRGMj8@mail.gmail.com>
	<AANLkTim0FeCE94R1zacOxGiEP8vZRSoDqNuNRUotnd9B@mail.gmail.com>
	<AANLkTima6meFsovFS-15X7CMTD53n=kkvueKrOeN4Yd4@mail.gmail.com>
	<AANLkTi=aCRGNtKxrPLH81H8_NvpBNOmJ-0MHgRms2a3T@mail.gmail.com>
	<1291025571.4262.21.camel@wpalmer.simply-domain>
	<4CF3FEB0.9040806@eaglescrag.net>
	<1291110230.11984.21.camel@wpalmer.simply-domain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "J.H." <warthog19@eaglescrag.net>,
	"=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
	Luke Kenneth Casson Leighton <luke.leighton@gmail.com>,
	git <git@vger.kernel.org>
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 30 11:08:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNN8g-0006YO-JJ
	for gcvg-git-2@lo.gmane.org; Tue, 30 Nov 2010 11:08:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755228Ab0K3KIl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Nov 2010 05:08:41 -0500
Received: from zoidberg.org ([88.198.6.61]:35896 "EHLO cthulhu.zoidberg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751043Ab0K3KIk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Nov 2010 05:08:40 -0500
Received: from jk.gs (xdsl-89-0-8-3.netcologne.de [::ffff:89.0.8.3])
  (AUTH: LOGIN jast, SSL: TLSv1/SSLv3,128bits,AES128-SHA)
  by cthulhu.zoidberg.org with esmtp; Tue, 30 Nov 2010 11:08:38 +0100
  id 0040022E.4CF4CD26.00004D96
In-Reply-To: <1291110230.11984.21.camel@wpalmer.simply-domain>
X-Mailer: Claws Mail 3.7.7 (GTK+ 2.22.0; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162483>

--- Will Palmer <wmpalmer@gmail.com> wrote:

> As a simple use-case:
> Everyone comes into an office in the morning and runs "git remote
> update". This potentially causes a lot of traffic between the office
> and their offsite central repository. If this were a p2p scenario, the
> transfer from the offsite could potentially happen only once.

The same savings can be achieved by:

- Hosting the repository locally in the office;
- Automatically updating the 'official' location whenever something is
  pushed to the local repository;
- Having all developers use the office repository as their remote.

Takes about five minutes to set up.

(That does not invalidate your overall arguments, of course, but I
don't have time to address them in much detail.)

-Jan
