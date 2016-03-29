From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v1 1/7] Make it possible to get sha1 for a path from the
 index
Date: Tue, 29 Mar 2016 17:05:19 +0200
Message-ID: <56FA99AF.1040006@web.de>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
 <1459257930-17193-1-git-send-email-tboegi@web.de>
 <CACsJy8A-nwv2B=6B4TqAz+i=DxC6Wu5yO924uaXWd5zLuXFRTQ@mail.gmail.com>
 <CACsJy8DqN+s2inEeO++hcen1MH+9Op_DFG2x6n8D4xuVfgAu8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Mar 29 17:08:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akvD9-0006iT-QS
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 17:05:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757278AbcC2PFe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Mar 2016 11:05:34 -0400
Received: from mout.web.de ([212.227.17.12]:60645 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757275AbcC2PFd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 11:05:33 -0400
Received: from macce.local ([195.252.60.88]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0MDg9K-1aW5UL2sIQ-00H66b; Tue, 29 Mar 2016 17:05:23
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.7.0
In-Reply-To: <CACsJy8DqN+s2inEeO++hcen1MH+9Op_DFG2x6n8D4xuVfgAu8w@mail.gmail.com>
X-Provags-ID: V03:K0:0hUrRKJBroUnHfRNHlS86QJz919yns0sGYZ2LcTsP53nLZOillb
 lrWb+zJxqxadOw0+jWH55stEIZMahv+MRT4GhzaNMWypRUQycMkOfwpVrN2VaLaEvkRFnhN
 +ha7PX2sYHwUhqIbBWVJExrPfFBw5w/g9x/jOIILa+yKa6oe0QLVTYedo1Xu1gNcQL4isB8
 hWvwZ1kYqPyoO2ejfA+pw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2AZOxdRqlmY=:hucFGkk3QT1s9UTy7JNrlW
 2OSutYTMyzRZCpDi8cPWlXkKIFsfw/5sXKkiyjHg9gYFbXfNvtnMVA6NC1cgmxldcQFYfFz0D
 rO1ltm+soXy7/8vd/zegCxrSgVegip3NKoI+TYvYkuRtMdy5jOGw+O3lDaZNu6BA4zPNiSyBb
 hj3RJ8tZBnYZyQAaZHmsV3c+YsjQTVaNNr2eevEkuA+CawwQfUkoBcLdRaNtUqUicr4s1vZsy
 oOXoudSFW2YtEBiHRtDQ6F6wyfL5y3YmWgsrVwmgpJhBQ4N1t9v/Ohw+CRngrJ+QvJunxUSdg
 nv5D6h5cPs9sqUu/AkhAHNaM49s5y4f4zku9JXIoXrmSY5BGf8SbTMKQFAgQy20BCLa4/G93G
 ykaLMvtnJi1y8La79HxHlJhY2Kzc3gqfGPaT+MEzVT9XupEYI2ex9bFFFSSaYogbNhPgJPtDL
 rDjnjPo3hcmjFp+XgugTXSdizdxDGnxkhYhYtoPB/tJB8d5h2jg1e0VCr8J795AxuJWQYxAYl
 JY4jt8bhpKcWubvKPPiG2OZ0lzMgHcKyhK93HnTRml2LT++d4vBVeV/l/0jkJ0QEHgz3hBX5E
 ZaNQqEI5GhLmgE1Xuk5WrCFzFTy3eV0gw08j5mBc3Q3gTdNONsBqiFZ45sOFJdCImqxuZaMJs
 bpvYJgvkpH3uVHZDTvZWkSQtdswn6107TGI80DD1sSR93KCzRiWZI7uIHh2xjhSBVadjw0b2a
 zaZUyq945RX/sq7Tc/Z97s5hgF2X/ldLFceeTvM1wFEwhIOtSZjH3EILesva+04hW3dNrgQM 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290141>

On 2016-03-29 15.31, Duy Nguyen wrote:
> On Tue, Mar 29, 2016 at 8:28 PM, Duy Nguyen <pclouds@gmail.com> wrote=
:
>> On Tue, Mar 29, 2016 at 8:25 PM,  <tboegi@web.de> wrote:
>>> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>>>
>>> Factor out the retrival of the sha1 for a given path in
>>> read_blob_data_from_index() into the function get_sha1_from_index()=
=2E
>>
>> Getting _sha1_ from index is one function call and a memory
>> dereference or two. I think you mean get sha1 _file_ (or data) from
>> index. Maybe put either word in the function name.
>=20
> Oops, shouldn't have trusted that function name in the @@ line. No
> what you write in the commit message matches the patch. Sorry for the
> noise.
>=20
Thanks for the review.
It feels that the naming isn't ideal, let's see if we can find a better
function name.
