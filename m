From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Surprising interaction of "binary" and "eol" gitattributes
Date: Tue, 10 Mar 2015 23:16:03 +0100
Message-ID: <54FF6D23.4060301@alum.mit.edu>
References: <54F88684.3020905@alum.mit.edu>	<xmqqwq2v14iv.fsf@gitster.dls.corp.google.com>	<54F9422D.2020800@web.de> <54F9E907.4040703@alum.mit.edu>	<54FA1C7B.3040906@web.de> <54FF450F.7040506@alum.mit.edu> <xmqq385c1v13.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	git discussion list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 10 23:16:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVSRk-000060-7u
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 23:16:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752094AbbCJWQM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2015 18:16:12 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:54943 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750920AbbCJWQJ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Mar 2015 18:16:09 -0400
X-AuditID: 12074411-f79fa6d000006b8a-14-54ff6d26d424
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id F8.10.27530.62D6FF45; Tue, 10 Mar 2015 18:16:06 -0400 (EDT)
Received: from [192.168.69.130] (p4FC962B5.dip0.t-ipconnect.de [79.201.98.181])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t2AMG3XJ000491
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 10 Mar 2015 18:16:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.5.0
In-Reply-To: <xmqq385c1v13.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsUixO6iqKuW+z/EYPc/EYuuK91MFg29V5gt
	Oju+Mjowe1y8pOzxeZOcx+1n21gCmKO4bZISS8qCM9Pz9O0SuDOWTv3BVLBXqOLy6hb2BsZz
	fF2MHBwSAiYSc79WdDFyApliEhfurWfrYuTiEBK4zCgxf+tUVgjnPJPEvQV/2UGqeAW0JS7O
	62UGsVkEVCWm/nkNZrMJ6Eos6mlmArFFBYIkXt76ywhRLyhxcuYTFhBbREBNYmLbITCbWaBA
	4vzy86wgtrCAu8Tq5Uehlv1llLiydAHYUE4Ba4kJ1/+zQjSoS/yZd4kZwpaXaN46m3kCo8As
	JDtmISmbhaRsASPzKka5xJzSXN3cxMyc4tRk3eLkxLy81CJdU73czBK91JTSTYyQ4BXcwTjj
	pNwhRgEORiUe3hWG/0KEWBPLiitzDzFKcjApifLei/4fIsSXlJ9SmZFYnBFfVJqTWnyIUYKD
	WUmEN80EKMebklhZlVqUD5OS5mBREuflW6LuJySQnliSmp2aWpBaBJOV4eBQkuDdlw3UKFiU
	mp5akZaZU4KQZuLgBBnOJSVSnJqXklqUWFqSEQ+K1fhiYLSCpHiA9k4CaectLkjMBYpCtJ5i
	VJQS590EkhAASWSU5sGNhaWkV4ziQF8K814HqeIBpjO47ldAg5mABrNYgw0uSURISTUwKsmJ
	vVgsm/OjRsFA7fK0Bpm7adtaSnP45iybvoH5gZ3Plalqzyw2JsdP0CyNOeuRkaP4ac6ukonM
	bOdYtkTZfT6bGVPetHurSX9IjqffimnTmY/3yu5gSQqxWiW4/vTk3sIZuiZ9M3Ks 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265270>

On 03/10/2015 09:01 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
>> [...]
>> It seems to me that setting "text=auto" should mean that Git uses its
>> heuristic to guess whether a particular file is text or not, and then
>> treats the file as if it had "text" or "-text" set. If the latter, then
>> EOL translation should be suppressed.
> 
> ... I think this makes even more sense. I do not think the code is
> set up to do so.  To be honest, eol_attr thing introduced in
> fd6cce9e (Add per-repository eol normalization, 2010-05-19) always
> confuses me whenever I follow this codepath.

Would this change be "backwards-compatible enough" that it can be made
without waiting for Git 3.0?

>> It also seems to me that "binary" should imply "-eol".
> 
> I thought that "eol" attribute is not even looked at when you say
> "binary"; that is what I recall finding out when I dug into this
> earlier in the thread.

Well, that's true, but the "eol" attribute can regain its effect if
"binary" is followed by "text" or "text=auto". So I guess the simplest
question is as follows. Suppose I have the following .gitattributes:

    a.foo eol=crlf
    a.foo binary
    a.foo text

It is obvious in this case that a.foo should be treated as a text file.
Should it be processed with "eol=crlf", or should the intervening
"binary" imply "-eol"?

I guess it would be more natural to process it with "eol=crlf". So I
withdraw my proposal that "binary" should imply "-eol", provided the
first change (that "text=auto" is treated the same as "-text" for binary
files) is implemented.

So I guess the proposed new behavior WRT these attributes is:

* "text" determines whether a file should be subject to EOL
  translation.
* "text=auto" has the same effect as "text" or "-text", depending
  on the outcome of the binary detection heuristic; in particular,
  it causes EOL translation to be suppressed for files determined
  to be binary.
* "eol" determines what EOLs should be translated to *if* the
  file is determined to be a text file.
* If "text" is unspecified but "eol" is specified, then do EOL
  translation without a heuristic check.

But I still have to work out how core.autocrlf and the "crlf" attribute
fit into all this.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
