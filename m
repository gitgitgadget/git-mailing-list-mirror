From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Surprising interaction of "binary" and "eol" gitattributes
Date: Fri, 06 Mar 2015 18:51:03 +0100
Message-ID: <54F9E907.4040703@alum.mit.edu>
References: <54F88684.3020905@alum.mit.edu> <xmqqwq2v14iv.fsf@gitster.dls.corp.google.com> <54F9422D.2020800@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git discussion list <git@vger.kernel.org>
To: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 18:51:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTwP9-0004zm-An
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 18:51:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbbCFRvP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Mar 2015 12:51:15 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:46835 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754469AbbCFRvN (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Mar 2015 12:51:13 -0500
X-AuditID: 12074414-f797f6d000004084-2e-54f9e90a5ef9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 8B.6F.16516.A09E9F45; Fri,  6 Mar 2015 12:51:06 -0500 (EST)
Received: from [192.168.69.130] (p5DDB02A8.dip0.t-ipconnect.de [93.219.2.168])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t26Hp3hM003320
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 6 Mar 2015 12:51:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.4.0
In-Reply-To: <54F9422D.2020800@web.de>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsUixO6iqMv18meIwewr4hZdV7qZLBp6rzBb
	dHZ8ZXRg9rh4Sdnj8yY5j9vPtrEEMEdx2yQllpQFZ6bn6dslcGfser2QpaBfquLvr+fsDYyn
	hLsYOTkkBEwk3nZeYYawxSQu3FvP1sXIxSEkcJlRYvOiC4wQzlkmiS/vHzKBVPEKaEv8//Oc
	EcRmEVCVmDjxNQuIzSagK7GopxmsRlQgSOLQ6ccsEPWCEidnPgGzRQSyJL59+sLaxcjBwQxU
	//BNIkhYWMBdYvXyo6wgtpBAicTqcxCtnAJqEneXPQOzmQX0JHZc/8UKYctLNG+dzTyBUWAW
	kg2zkJTNQlK2gJF5FaNcYk5prm5uYmZOcWqybnFyYl5eapGuhV5uZoleakrpJkZI6IrsYDxy
	Uu4QowAHoxIPr4HEzxAh1sSy4srcQ4ySHExKorxlz4BCfEn5KZUZicUZ8UWlOanFhxglOJiV
	RHgnPgTK8aYkVlalFuXDpKQ5WJTEeb8tVvcTEkhPLEnNTk0tSC2CycpwcChJ8P56DtQoWJSa
	nlqRlplTgpBm4uAEGc4lJVKcmpeSWpRYWpIRD4rU+GJgrIKkeID2vgZp5y0uSMwFikK0nmJU
	lBLnZXkBlBAASWSU5sGNhSWkV4ziQF8K82qAVPEAkxlc9yugwUxAg7XEfoAMLklESEk1MDr1
	JUkLbWeoeOU3I1L4q/XjAtYAq56Lp/XOf79bUZVYrLG9lzvh2NsNBecbfuWUtS84rBDauaM7
	eA7jWYGf8jv2+a/7nJHizblFo/nVuZXaVce/v7VLTQjkdZFYfvtZepZg+v3E93Zf 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264947>

On 03/06/2015 06:59 AM, Torsten B=F6gershausen wrote:
> On 03/05/2015 11:08 PM, Junio C Hamano wrote:
>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>>
>>> I would expect that the following .gitattributes file
>>>
>>>      *       eol=3Dcrlf
>>>      *.png   -text
>>>
>>> would leave EOL translation turned off for PNG files. In other word=
s, I
>>> would expect that explicitly setting "-text" would take precedence =
over
>>> the fact that setting "eol" implies that a file should be considere=
d to
>>> be "text".
>>>
>>> I would even more strongly expect
>>>
>>>      *       eol=3Dcrlf
>>>      *.png   binary
>>>
>>> to turn off EOL translation for PNG files.
>>>
>>> But in fact, in both of the above cases, EOL translation is turned =
*on*
>>> for PNG files.
>>>
>>> I propose that "-text" should override any setting for "eol" (which
>>> would of course fix both problems, since "binary" is equivalent to
>>> "-diff -merge -text"). What do people think?
>> Hmm, is there really something that needs a new proposal and
>> opinions?
>>
>> The way I read the flow in convert.c is:
>>
>>      convert_to_git() uses input_crlf_action() to figure out what
>>      crlf_to_git() conversion is necessary.
>>
>>      input_crlf_action() looks at text_attr and says CRLF_BINARY whe=
n
>>      it is CRLF_BINARY without looking at eol_attr at all.
>>
>>      text_attr above is ca.crlf_action in convert_to_git().
>>
>>      The whole ca.* comes from convert_attrs() inspecting attributes
>>      on the incoming path.
>>
>>      convert_attrs() inspects "eol" and "text" attributes, among
>>      others, and sets crlf_action by calling git_path_check_crlf().
>>
>>      git_path_check_crlf() looks at the 'text' attribute; if it is
>>      set to false, it returns CRLF_BINARY.
>>
>>      crlf_to_git() when given crlf_action=3D=3DCRLF_BINARY is a no-o=
p.
>>
>> So, with the above attributes where anything is eol=3Dcrlf by defaul=
t
>> and in addition *.png is binary (which contains -text), we shouldn't
>> get any crlf munging.  Am I reading/following the code incorrectly?
>>
>> Puzzled....
>> --=20
>=20
> I need to admit that I can't reproduce it here,
> the following should trigger it, but all test cases pass
>=20
>=20
> diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
>=20
> index 452320d..22f031d 100755
> --- a/t/t0027-auto-crlf.sh
> +++ b/t/t0027-auto-crlf.sh
> @@ -37,7 +37,8 @@ create_gitattributes () {
>                 echo "*.txt text" >.gitattributes
>                 ;;
>                 -text)
> -               echo "*.txt -text" >.gitattributes
> +               echo "* eol=3Dcrlf" >.gitattributes
> +               echo "*.txt -text" >>.gitattributes
>                 ;;
>                 crlf)
>                 echo "*.txt eol=3Dcrlf" >.gitattributes
>=20

Oops, I misunderstood an internal bug report. In seems that it is the
following scenario that is incorrect:

    *.png text=3Dauto eol=3Dcrlf

when applied to a binary file.

I'm currently studying documentation and writing tests to figure out th=
e
exact current behavior. But honestly, this end-of-line conversion stuff
is bewildering, so it might take a while.

Sorry for the half-cocked bug report. I'll report back when I know more=
=2E

Michael

--=20
Michael Haggerty
mhagger@alum.mit.edu
