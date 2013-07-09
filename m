From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH 2/2] test-lint: detect 'export FOO=bar'
Date: Tue, 09 Jul 2013 11:53:38 +0200
Message-ID: <51DBDDA2.8070304@web.de>
References: <b9e889a27f648c44179ad39159240867f86525f3.1373296313.git.trast@inf.ethz.ch> <24ee18d3b06883c4185821f5ffb5faed26e6a436.1373296313.git.trast@inf.ethz.ch> <51DB1399.9020307@web.de> <87a9lwgk0e.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	git@vger.kernel.org
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jul 09 11:53:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwUcE-0001xn-Nq
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 11:53:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752979Ab3GIJxm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Jul 2013 05:53:42 -0400
Received: from mout.web.de ([212.227.15.14]:53673 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752903Ab3GIJxl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 05:53:41 -0400
X-Greylist: delayed 88330 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Jul 2013 05:53:41 EDT
Received: from birne.lan ([195.67.191.23]) by smtp.web.de (mrweb102) with
 ESMTPA (Nemesis) id 0M2MYq-1U6aLm4Ayq-00s69y; Tue, 09 Jul 2013 11:53:39 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <87a9lwgk0e.fsf@linux-k42r.v.cablecom.net>
X-Provags-ID: V03:K0:X85k++D3Ts56x3y41LrcaS7p1W6AU98h52/oFTgVQJAc3lBuQou
 FLp58M523/jMkAfw2eRql7emUZ/wHGlETXxDdyiexCyLTzlYyqPOqW50Efj3AHtBLljLkaV
 5B9dSs0DLyLwPCk9ICN2wXS5Q1n6+UXF0d3mRlV3ykNBqdhobk2oZENzsRVs6hNSFTqGZ90
 KXY+n2Am8sAdVOWauPpOQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229926>

On 09.07.13 11:28, Thomas Rast wrote:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>=20
>>> +	/^\s*export\s+[^=3D]*=3D/ and err '"export FOO=3Dbar" is not port=
able (please use FOO=3Dbar && export FOO)';
>> I have a slightly tighter reg exp in my tree, but credits should go =
to Thomas:=20
>>
>> /^\s*export\s+\S+=3D\S+/
>=20
> Hmm, is that correct?  I would expect shells that have problems with
> 'export FOO=3Dbar' to also fail on 'export FOO=3D' (i.e. set to empty=
 string
> and export).
>=20
Good point, thanks
