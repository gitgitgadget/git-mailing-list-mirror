From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: What's cooking in git.git (Nov 2012, #03; Tue, 13)
Date: Sat, 17 Nov 2012 08:11:24 +0100
Message-ID: <50A7389C.6080003@web.de>
References: <20121113175205.GA26960@sigill.intra.peff.net> <50A2B14C.9040608@web.de> <50A2F17D.4010907@gmail.com> <20121114190228.GA3860@sigill.intra.peff.net> <50A40978.2060504@web.de> <20121115001635.GA17370@sigill.intra.peff.net> <50A44A73.8020007@gmail.com> <20121115015608.GB19131@sigill.intra.peff.net> <50A48391.9090207@web.de> <7vlie1mlcb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Jeff King <peff@peff.net>, Mark Levedahl <mlevedahl@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 17 08:11:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZcZ8-0007xX-8R
	for gcvg-git-2@plane.gmane.org; Sat, 17 Nov 2012 08:11:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752804Ab2KQHLc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Nov 2012 02:11:32 -0500
Received: from mout.web.de ([212.227.15.3]:53410 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751860Ab2KQHLb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2012 02:11:31 -0500
Received: from birne.lan ([195.67.191.23]) by smtp.web.de (mrweb103) with
 ESMTPA (Nemesis) id 0Ljamy-1T2keD0F9U-00be9c; Sat, 17 Nov 2012 08:11:25 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:16.0) Gecko/20121026 Thunderbird/16.0.2
In-Reply-To: <7vlie1mlcb.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:kq+o85FUe3L4iZsIf0Bqt+oVF3DjYjnmiBCXVtQYff0
 L10k0ZIgYBa5G50BLCWn2zIPb9sECNMwLqU27T0NXrbL4ZYdjc
 dJcxoaJH7LHhZvvQxzTrehexCWPYRwDEevoMSRjzEk11BvGAoR
 rKtPmFm6Z/tMoKmbmIZTZBJCR8aWLtHBkl6CvZp9zxmPYYhX8t
 /rHJ3Dk4PpK4XjnsBIGEg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209932>

On 16.11.12 19:52, Junio C Hamano wrote:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>=20
>> My understanding:
>> Either use people cygwin 1.5 or they use cygwin 1.7, and in this cas=
e
>> the installation is updated frequently.
>>
>> Peff or Junio, please go ahead with the patch.
>>
>> If it turns out that we want to support cygwin installations like 1.=
7.7
>> which could be upgraded, but are not upgraded since they are
>> "production machines we do not dare to touch" we can still improve
>> the autodetection.
>=20
> OK.  I moved the topic forward but we may still want to rename the
> name of the macro to have CYGWIN somewhere in the name.

I send a patch some seconds ago.
I forgot to mention that this should be applied to next
