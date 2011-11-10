From: =?ISO-8859-1?Q?Stefan_N=E4we?= <stefan.naewe@atlas-elektronik.com>
Subject: Re: "make quick-install-man" on git.git HEAD has failed for two days
Date: Thu, 10 Nov 2011 17:46:58 +0100
Message-ID: <4EBC0002.9030201@atlas-elektronik.com>
References: <861utgymsv.fsf@red.stonehenge.com> <4EBBFCD2.9060000@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Thu Nov 10 17:47:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROXmK-00039H-1p
	for gcvg-git-2@lo.gmane.org; Thu, 10 Nov 2011 17:47:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965309Ab1KJQq7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Nov 2011 11:46:59 -0500
Received: from mail96.atlas.de ([194.156.172.86]:26824 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935046Ab1KJQq6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2011 11:46:58 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail96.atlas.de (Postfix) with ESMTP id AAA4A10074;
	Thu, 10 Nov 2011 17:46:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at lxsrv96.atlas.de
Received: from mail96.atlas.de ([127.0.0.1])
	by localhost (lxsrv96.atlas.de [127.0.0.1]) (amavisd-new, port 10124)
	with ESMTP id uqtsa4s4v-SR; Thu, 10 Nov 2011 17:46:56 +0100 (CET)
Received: from mgsrv01.atlas.de (mailrelay-atlas.atlas.de [10.200.101.16])
	by mail96.atlas.de (Postfix) with ESMTP;
	Thu, 10 Nov 2011 17:46:56 +0100 (CET)
Received: from [141.200.19.108] (as112671.atlas.de [141.200.19.108])
	by mgsrv01.atlas.de (Postfix) with ESMTP id 4E23E27197;
	Thu, 10 Nov 2011 17:46:56 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <4EBBFCD2.9060000@atlas-elektronik.com>
X-Enigmail-Version: 1.3.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185240>

Am 10.11.2011 17:33, schrieb Stefan N=E4we:
> Am 10.11.2011 17:17, schrieb Randal L. Schwartz:
>>
>> Known issue?  Should I have done something differently?
>>
>> "make install quick-install-man" ends with:
>>
>>     make[2]: `GIT-VERSION-FILE' is up to date.
>>     git-manpages repository must exist at ../../git-manpages
>>     make[1]: *** [require-manrepo] Error 1
>>     make: *** [quick-install-man] Error 2
>=20
> This should be fixed with fcbebfd "docs: Update install-doc-quick".
> (It's in master)

Errr...

"fcbebfd" is the cause, not the fix for it, of course.
=20
> You need to clone git-manpages.git next to git.git.

Still true.


Stefan
--=20
----------------------------------------------------------------
/dev/random says: Time wounds all heels...
python -c "print '73746566616e2e6e616577654061746c61732d656c656b74726f6=
e696b2e636f6d'.decode('hex')"
