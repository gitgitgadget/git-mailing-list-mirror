From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 2/2] test-lint: detect 'export FOO=bar'
Date: Tue, 9 Jul 2013 11:28:17 +0200
Message-ID: <87a9lwgk0e.fsf@linux-k42r.v.cablecom.net>
References: <b9e889a27f648c44179ad39159240867f86525f3.1373296313.git.trast@inf.ethz.ch>
	<24ee18d3b06883c4185821f5ffb5faed26e6a436.1373296313.git.trast@inf.ethz.ch>
	<51DB1399.9020307@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Jul 09 11:28:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwUDf-0004iX-GP
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 11:28:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753729Ab3GIJ2T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Jul 2013 05:28:19 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:34600 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753666Ab3GIJ2S convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jul 2013 05:28:18 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 9 Jul
 2013 11:28:16 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS12.d.ethz.ch (172.31.38.212) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Tue, 9 Jul 2013 11:28:17 +0200
In-Reply-To: <51DB1399.9020307@web.de> ("Torsten \=\?utf-8\?Q\?B\=C3\=B6gershaus\?\=
 \=\?utf-8\?Q\?en\=22's\?\= message of
	"Mon, 08 Jul 2013 21:31:37 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229922>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

>> +	/^\s*export\s+[^=3D]*=3D/ and err '"export FOO=3Dbar" is not porta=
ble (please use FOO=3Dbar && export FOO)';
> I have a slightly tighter reg exp in my tree, but credits should go t=
o Thomas:=20
>
> /^\s*export\s+\S+=3D\S+/

Hmm, is that correct?  I would expect shells that have problems with
'export FOO=3Dbar' to also fail on 'export FOO=3D' (i.e. set to empty s=
tring
and export).

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
