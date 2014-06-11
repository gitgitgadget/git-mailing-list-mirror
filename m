From: Richard Hansen <rhansen@bbn.com>
Subject: Re: [PATCH v2 00/11] Zsh prompt tests
Date: Wed, 11 Jun 2014 11:27:23 -0400
Message-ID: <5398755B.4050601@bbn.com>
References: <1401176460-31564-1-git-send-email-rhansen@bbn.com> <1401915687-8602-1-git-send-email-rhansen@bbn.com> <53976563.5020905@web.de> <53976A7E.8010001@bbn.com> <20140611011617.GB368384@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	git@vger.kernel.org
To: sandals@crustytoothpaste.net
X-From: git-owner@vger.kernel.org Wed Jun 11 17:27:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WukR6-0005mh-VX
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 17:27:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932506AbaFKP1d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Jun 2014 11:27:33 -0400
Received: from smtp.bbn.com ([128.33.1.81]:20424 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932350AbaFKP1c convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Jun 2014 11:27:32 -0400
Received: from socket.bbn.com ([192.1.120.102]:36889)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1WukR6-0003EI-HT; Wed, 11 Jun 2014 11:27:36 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 1F2FB3FE73
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <20140611011617.GB368384@vauxhall.crustytoothpaste.net>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251371>

On 2014-06-10 21:16, brian m. carlson wrote:
> On Tue, Jun 10, 2014 at 04:28:46PM -0400, Richard Hansen wrote:
>> On 2014-06-10 16:06, Torsten B=C3=B6gershausen wrote:
>>>  zsh --version
>>> zsh 4.3.9 (i386-apple-darwin10.0)
>>
>> zsh 4.3.9 is over 5 years old (2008-11-03).  Is that young enough th=
at
>> we should still try to support it?
>=20
> zsh 4.3.10 is the version in RHEL/CentOS 6, and people are still usin=
g
> CentOS 5.  At $DAYJOB we build git on both, so it would be nice if at
> least the tests didn't fail.

Looks like CentOS 5 has zsh 4.2.6, so when I rewrite the patch series
I'll test zsh versions that are at least that old.

> Skipping them on older versions (maybe using is-at-least) would be
> fine by me.

I don't think we'll need to skip the tests on old zsh versions --
running 'zsh -c' should still work even if 'emulate zsh -c' doesn't.

Thanks,
Richard
