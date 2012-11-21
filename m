From: "Holger Hellmuth (IKS)" <hellmuth@ira.uka.de>
Subject: Re: [wishlist] support git flow-like view
Date: Wed, 21 Nov 2012 15:52:05 +0100
Message-ID: <50ACEA95.9020909@ira.uka.de>
References: <201211202043.00293.perezmeyer@gmail.com> <CAH5451nrcEo3Uxm0x6b39Hq1k-J4=OZPi-Cao7osaiS-w_Z1+Q@mail.gmail.com> <201211202113.44459.perezmeyer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andrew Ardill <andrew.ardill@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: =?UTF-8?B?TGlzYW5kcm8gRGFtacOhbiBOaWNhbm9yIFDDqXJleiBNZXllcg==?= 
	<perezmeyer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 21 15:51:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TbBeS-0008OK-Lw
	for gcvg-git-2@plane.gmane.org; Wed, 21 Nov 2012 15:51:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754862Ab2KUOv3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Nov 2012 09:51:29 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:50316 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754511Ab2KUOv3 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Nov 2012 09:51:29 -0500
Received: from irams1.ira.uni-karlsruhe.de ([141.3.10.5])
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	id 1TbBe5-0003kO-WB; Wed, 21 Nov 2012 15:51:27 +0100
Received: from i20s141.iaks.uni-karlsruhe.de ([141.3.32.141] helo=[172.16.22.120])
	by irams1.ira.uni-karlsruhe.de with esmtpsa port 587 
	id 1TbBe5-0004AS-PB; Wed, 21 Nov 2012 15:51:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121025 Thunderbird/16.0.2
In-Reply-To: <201211202113.44459.perezmeyer@gmail.com>
X-ATIS-AV: ClamAV (irams1.ira.uni-karlsruhe.de)
X-ATIS-AV: Kaspersky (iramx2.ira.uni-karlsruhe.de)
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1353509487.877314000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210150>

Am 21.11.2012 01:13, schrieb Lisandro Dami=C3=A1n Nicanor P=C3=A9rez Me=
yer:
> Well, two ideas come to my mind:
>
> - detect when using git flow (.git/config contains [gitflow "some_bra=
nch"]
> entries).

Shouldn't it be part of the gitflow package then?

> - Show "swim-lane"-like graphs, including branches that may not be pr=
esent,
> but where there (release branches often are created and merged back, =
for
> example)

As a general feature there could be a config option gitk reads with an=20
ordered list of branch names (with wildcards). Those branches would=20
always be printed in gitk as the leftmost branches (i.e. have their own=
=20
lane on the left side). All other branches would be shown normally.

This would give you part of what you want, a special lane at least for=20
master and develop and for branches you can group under wildcard branch=
=20
names (for example if you prefix all release branches with "rel-").

And it would give others the ability to make special branches in gitk=20
more visible.

(Yes I know, I'm talking again of stuff I won't have time or ability to=
=20
implement ;-). Sigh)
