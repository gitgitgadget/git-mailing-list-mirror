From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: Re: [PATCH v2 1/2] completion: create variable for untracked file
 modes
Date: Thu, 2 Jun 2016 14:19:31 +0200
Message-ID: <b41a90a6-c679-d148-823c-a94231f3f90c@virtuell-zuhause.de>
References: <20160601040542.GA18978@sigill.intra.peff.net>
	 <1464773846.4315.0.camel@virtuell-zuhause.de>
	 <20160601135938.Horde.2Daxezldve72SBukDSPenPP@webmail.informatik.kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>
To: =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Jun 02 17:13:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8UJb-0007P7-0h
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 17:13:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414AbcFBPNh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Jun 2016 11:13:37 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:51888 "EHLO
	wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932099AbcFBPNg convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Jun 2016 11:13:36 -0400
Received: from p4fc87c53.dip0.t-ipconnect.de ([79.200.124.83] helo=[192.168.100.43]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1b8UJR-0003kA-9O; Thu, 02 Jun 2016 17:13:33 +0200
X-Mozilla-Keys: 
FCC: imap://wp1126771-182009@wp156.webpack.hosteurope.de/Gesendete Objekte
X-Identity-Key: id2
X-Account-Key: account1
X-Mozilla-Draft-Info: internal/draft; vcard=0; receipt=0; DSN=0;
 uuencode=0; attachmentreminder=0
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
In-Reply-To: <20160601135938.Horde.2Daxezldve72SBukDSPenPP@webmail.informatik.kit.edu>
X-Mailer: Evolution 3.12.9-1+b1 
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1464880416;74cfb77c;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296205>

Am 01.06.2016 um 13:59 schrieb SZEDER G=C3=A1bor:
>=20
> This subject would perhaps read better:
>=20
>   completion: factor out untracked file modes into a variable

Yes, definitly. Will be included in reroll.

> Quoting Thomas Braun <thomas.braun@virtuell-zuhause.de>:
>=20
>> Signed-off-by: Thomas Braun <thomas.braun@virtuell-zuhause.de>
>> ---
>>  contrib/completion/git-completion.bash | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/contrib/completion/git-completion.bash
>> b/contrib/completion/git-completion.bash
>> index 3402475..addea89 100644
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -1098,6 +1098,8 @@ _git_clone ()
>>      esac
>>  }
>>
>> +__git_untracked_file_modes=3D"all no normal"
>> +
>>  _git_commit ()
>>  {
>>      case "$prev" in
>> @@ -1119,7 +1121,7 @@ _git_commit ()
>>          return
>>          ;;
>>      --untracked-files=3D*)
>> -        __gitcomp "all no normal" "" "${cur##--untracked-files=3D}"
>> +        __gitcomp "$__git_untracked_file_modes" ""
>> "${cur##--untracked-files=3D}"
>>          return
>>          ;;
>>      --*)
>=20
>=20
>=20
