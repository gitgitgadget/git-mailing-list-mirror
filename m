From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Surprising interaction of "binary" and "eol" gitattributes
Date: Tue, 10 Mar 2015 23:24:27 +0100
Message-ID: <54FF6F1B.2030900@alum.mit.edu>
References: <54F88684.3020905@alum.mit.edu> <xmqqwq2v14iv.fsf@gitster.dls.corp.google.com> <54F9422D.2020800@web.de> <54F9E907.4040703@alum.mit.edu> <54FA1C7B.3040906@web.de> <54FF450F.7040506@alum.mit.edu> <54FF5376.7070500@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git discussion list <git@vger.kernel.org>
To: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 10 23:24:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVSZo-0000ZA-J0
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 23:24:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753047AbbCJWYc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Mar 2015 18:24:32 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:61488 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752497AbbCJWYb (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Mar 2015 18:24:31 -0400
X-AuditID: 12074412-f79e46d0000036b4-37-54ff6f1e086d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 1A.02.14004.E1F6FF45; Tue, 10 Mar 2015 18:24:30 -0400 (EDT)
Received: from [192.168.69.130] (p4FC962B5.dip0.t-ipconnect.de [79.201.98.181])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t2AMORug000933
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 10 Mar 2015 18:24:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.5.0
In-Reply-To: <54FF5376.7070500@web.de>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsUixO6iqCuX/z/EYP8mEYuuK91MFg29V5gt
	Oju+Mjowe1y8pOzxeZOcx+1n21gCmKO4bZISS8qCM9Pz9O0SuDPmPT/NWvCfp+L6z8OsDYwd
	XF2MnBwSAiYSTxs6mSFsMYkL99azgdhCApcZJfo6FbsYuYDs80wSszo3sYIkeAW0JZr+7QIr
	YhFQlWj/3sMOYrMJ6Eos6mlmArFFBYIkXt76ywhRLyhxcuYTFhBbRCBL4tunL0BzODiYgeof
	vkkECQsLuEusXn6UFWLXC0aJ5hmfwGZyCqhJ7D+0Amwms4CexI7rv1ghbHmJ5q2zmScwCsxC
	smIWkrJZSMoWMDKvYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI108vNLNFLTSndxAgJXaEdjOtP
	yh1iFOBgVOLhXWH4L0SINbGsuDL3EKMkB5OSKO+96P8hQnxJ+SmVGYnFGfFFpTmpxYcYJTiY
	lUR400yAcrwpiZVVqUX5MClpDhYlcd6fi9X9hATSE0tSs1NTC1KLYLIyHBxKEryyeUCNgkWp
	6akVaZk5JQhpJg5OkOFcUiLFqXkpqUWJpSUZ8aBIjS8GxipIigdoryZIO29xQWIuUBSi9RSj
	opQ475VcoIQASCKjNA9uLCwhvWIUB/pSmDcMpJ0HmMzgul8BDWYCGsxiDTa4JBEhJdXAmPhL
	rOJHtkhBEbNfzs7D25g3v/GSO3zvGoucg/n1uMjGpEm/D79ktQzgdT1+7X+trm9DVbvqD/PE
	0Dj+lxxZVTnJ1seaNyUy611+w+j8cmpni29XU+sf9UVl3f0fHpes+Z52R11v37+k 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265271>

On 03/10/2015 09:26 PM, Torsten B=F6gershausen wrote:
> On 10.03.15 20:25, Michael Haggerty wrote:
>> [...]
>> I'm still trying to infer the spirit of the current behavior, so cav=
eats
>> here.
>>
>> This comes from a real-life scenario where a user, somewhere early i=
n
>> .gitattributes, had
>>
>>     * text
>>     * eol=3Dcrlf
>>
>> and then later (this could be in a subdirectory) tried to carve out
>> exceptions to this rule by using
>>
>>     *.png binary
>>     * text=3Dauto
> Hm,
> I can see 2 problems here:
> the "binary" attribute does not exist at all.
>
> I sometimes which we had it, but we don't.
> There is "text" and "-text", and that is it.

There is a "binary" macro that is equivalent to "-diff -merge -text". I=
t
is documented in gitattributes(5) under "USING MACRO ATTRIBUTES" and
"DEFINING MACRO ATTRIBUTES".

> The other problem is the order of the lines, which is fully
> intuitive for each person who has ever written a "matching parser".
>=20
> The parser matches each file namr on it's own, depending on the match=
ing:
>=20
> *.png -text
> * text=3Dauto
> means that all png files are binary, and ALL files are "auto".
>=20
> Guess what happens to the png's ?
>=20
> The second rule wins, as it is the last rule processed.
>=20
> git check-attr text *
> A.png: text: auto
> B.txt: text: auto

That much is perfectly clear. The question is, what should happen when
the contents-based heuristic, whose use was requested by "text=3Dauto",
determines that A.png is in fact a binary file? Should it be subjected
to EOL translation anyway? I think not.

Michael

--=20
Michael Haggerty
mhagger@alum.mit.edu
