From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Surprising interaction of "binary" and "eol" gitattributes
Date: Tue, 10 Mar 2015 20:25:03 +0100
Message-ID: <54FF450F.7040506@alum.mit.edu>
References: <54F88684.3020905@alum.mit.edu> <xmqqwq2v14iv.fsf@gitster.dls.corp.google.com> <54F9422D.2020800@web.de> <54F9E907.4040703@alum.mit.edu> <54FA1C7B.3040906@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git discussion list <git@vger.kernel.org>
To: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 10 20:25:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVPmT-0004zk-AJ
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 20:25:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752900AbbCJTZX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Mar 2015 15:25:23 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:47612 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751762AbbCJTZX (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Mar 2015 15:25:23 -0400
X-AuditID: 1207440e-f79bc6d000000c43-3f-54ff45132f37
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 4B.B1.03139.3154FF45; Tue, 10 Mar 2015 15:25:07 -0400 (EDT)
Received: from [192.168.69.130] (p4FC962B5.dip0.t-ipconnect.de [79.201.98.181])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t2AJP4gV024244
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 10 Mar 2015 15:25:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.5.0
In-Reply-To: <54FA1C7B.3040906@web.de>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsUixO6iqCvs+j/E4EiXkEXXlW4mi4beK8wW
	nR1fGR2YPS5eUvb4vEnO4/azbSwBzFHcNkmJJWXBmel5+nYJ3Bl3djezFuzkrbj6bApTA+NO
	ri5GTg4JAROJL0s+M0LYYhIX7q1n62Lk4hASuMwoceHtfxYI5zyTxOtjJ1hAqngFtCX2vZ/E
	DmKzCKhKfH0M0c0moCuxqKeZCcQWFQiSeHnrLyNEvaDEyZlPwHpFBLIkvn36wtrFyMHBDFT/
	8E0iSFhYwF1i9fKjrBC71jFKtOydxAyS4BRQk5i17ifYHGYBPYkd13+xQtjyEs1bZzNPYBSY
	hWTFLCRls5CULWBkXsUol5hTmqubm5iZU5yarFucnJiXl1qka6yXm1mil5pSuokRErx8Oxjb
	18scYhTgYFTi4V1h+C9EiDWxrLgy9xCjJAeTkiivg9n/ECG+pPyUyozE4oz4otKc1OJDjBIc
	zEoivGkmQDnelMTKqtSifJiUNAeLkjiv2hJ1PyGB9MSS1OzU1ILUIpisDAeHkgSvujNQo2BR
	anpqRVpmTglCmomDE2Q4l5RIcWpeSmpRYmlJRjwoVuOLgdEKkuIB2psH0s5bXJCYCxSFaD3F
	qCglzusGkhAASWSU5sGNhaWkV4ziQF8K87aDVPEA0xlc9yugwUxAg1mswQaXJCKkpBoYt3WI
	LH7z81W0WPezgr6QrOJ/4gvU2QStBfxVxN/eDqrrNL97ytVIbcOq/NiZp5+HJJQsSlmacCdX
	WfjZr4ciE2RWNk5h3cOitkzuyQvvVL5//Y/TNjlU/qpY2rR5yk4fsdCJH+vlUgJi 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265256>

On 03/06/2015 10:30 PM, Torsten B=F6gershausen wrote:
>=20
>> Oops, I misunderstood an internal bug report. In seems that it is th=
e
>> following scenario that is incorrect:
>>
>>     *.png text=3Dauto eol=3Dcrlf
> Hm, I don't know if we support this combination at all.

The user can specify this combination in a .gitattributes file and we
have to react to it *some way*. Theoretically we could document that
this combination is undefined and/or emit an error if we see this
combination, but we don't do so.

> The current logic supports auto-detection of text/binary,
> * text=3Dauto
> (the files will get the line ending from core.eol or core.autocrlf)
>=20
> or the  the setting of a line ending:
> *.sh eol=3Dlf
> *.bat eol=3Dcrlf
>=20
>=20
> Is there a special use-case, which needs the combination of both ?

I'm still trying to infer the spirit of the current behavior, so caveat=
s
here.

This comes from a real-life scenario where a user, somewhere early in
=2Egitattributes, had

    * text
    * eol=3Dcrlf

and then later (this could be in a subdirectory) tried to carve out
exceptions to this rule by using

    *.png binary
    * text=3Dauto

Intuitively it *feels* like either of the later lines should suppress
EOL translation in PNG files (assuming the PNG file has a NUL byte in
the first 8k, which this one did).

It seems to me that setting "text=3Dauto" should mean that Git uses its
heuristic to guess whether a particular file is text or not, and then
treats the file as if it had "text" or "-text" set. If the latter, then
EOL translation should be suppressed.

It also seems to me that "binary" should imply "-eol".

Michael

--=20
Michael Haggerty
mhagger@alum.mit.edu
