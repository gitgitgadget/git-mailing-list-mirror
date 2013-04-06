From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v2 0/4] remote-helpers: trivial test fixes
Date: Sat, 06 Apr 2013 19:09:02 +0200
Message-ID: <516056AE.9060304@web.de>
References: <1365089779-9726-1-git-send-email-felipe.contreras@gmail.com> <51605546.3080503@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>,
	Antoine Pelisse <apelisse@gmail.com>
To: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Apr 06 19:27:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWc9-0007Xy-FI
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 19:09:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751587Ab3DFRJN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Apr 2013 13:09:13 -0400
Received: from mout.web.de ([212.227.17.12]:59982 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751005Ab3DFRJM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Apr 2013 13:09:12 -0400
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0MQNzw-1U1Odv05YS-00Tyt3; Sat, 06 Apr 2013 19:09:03
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <51605546.3080503@web.de>
X-Provags-ID: V02:K0:c8AADVCswHEs+GCKVtJy3tWCnuopQKrQy6il2apV930
 fd3T+OsqjsRehK68+W2JI/4mOV0XXrerJUMOQAYHv7TQjcm5os
 LJq08CCiCp2W1MwPDcUltpc4Y/s26Z26K35de+pKro0kuBNteM
 qDppvWKzJKkmW0jMJ1A+ndwZs9gT0rIYGsB+511Pc63s0rY/bw
 9qGMrT0wASfY+kprIO0hg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220210>

On 06.04.13 19:03, Torsten B=F6gershausen wrote:
> On 04.04.13 17:36, Felipe Contreras wrote:
>> Hi,
>>
>> A reroll, now we do some checks, just avoid test-lint-duplicates, an=
d fix the
>> outsanding shell portability issue. The rest is the same.
>>
>> Felipe Contreras (4):
>>   remote-bzr: avoid echo -n
>>   remote-helpers: fix the run of all tests
>>   remote-bzr: remove stale check code for tests
>>   remote-hg: fix hg-git test-case
>>
>>  contrib/remote-helpers/Makefile          |  1 +
>>  contrib/remote-helpers/test-bzr.sh       | 16 +---------------
>>  contrib/remote-helpers/test-hg-hg-git.sh |  1 -
>>  3 files changed, 2 insertions(+), 16 deletions(-)
>>
> Sorry being late, now I installed bzr and hg on one of my machines=20
>=20
> One defect found: "\s" is not portable on all grep versions
> A "*" is not a "basic regular expression", so we need to use egrep

Sorry for confusion:
A "*" is a basic regular expression, but not the "+"
"+" is an extended regular expression, which is understood
by some  grep versions (gnu ?).

=46elipe: Should I send a patch, or wait for a re-roll?
