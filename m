From: =?ISO-8859-1?Q?Stefan_N=E4we?= <stefan.naewe@atlas-elektronik.com>
Subject: Re: "make quick-install-man" on git.git HEAD has failed for two days
Date: Thu, 10 Nov 2011 17:40:10 +0100
Message-ID: <4EBBFE6A.2000002@atlas-elektronik.com>
References: <861utgymsv.fsf@red.stonehenge.com> <4EBBFCD2.9060000@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Thu Nov 10 17:40:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROXfl-0007Jr-No
	for gcvg-git-2@lo.gmane.org; Thu, 10 Nov 2011 17:40:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932765Ab1KJQkL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Nov 2011 11:40:11 -0500
Received: from mail96.atlas.de ([194.156.172.86]:24669 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932173Ab1KJQkK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2011 11:40:10 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail96.atlas.de (Postfix) with ESMTP id 1C47110087;
	Thu, 10 Nov 2011 17:40:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at lxsrv96.atlas.de
Received: from mail96.atlas.de ([127.0.0.1])
	by localhost (lxsrv96.atlas.de [127.0.0.1]) (amavisd-new, port 10124)
	with ESMTP id Qo-wesNKgnUS; Thu, 10 Nov 2011 17:40:08 +0100 (CET)
Received: from mgsrv01.atlas.de (mailrelay-atlas.atlas.de [10.200.101.16])
	by mail96.atlas.de (Postfix) with ESMTP;
	Thu, 10 Nov 2011 17:40:08 +0100 (CET)
Received: from [141.200.19.108] (as112671.atlas.de [141.200.19.108])
	by mgsrv01.atlas.de (Postfix) with ESMTP id A3CA427199;
	Thu, 10 Nov 2011 17:40:08 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <4EBBFCD2.9060000@atlas-elektronik.com>
X-Enigmail-Version: 1.3.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185239>

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
>=20
> You need to clone git-manpages.git next to git.git.

=46YI:

http://thread.gmane.org/gmane.comp.version-control.git/184930/focus=3D1=
85084

Stefan
--=20
----------------------------------------------------------------
/dev/random says: Useless Invention: Fireproof cigarettes.
python -c "print '73746566616e2e6e616577654061746c61732d656c656b74726f6=
e696b2e636f6d'.decode('hex')"
