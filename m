From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v4 01/11] add fetch-pack --diag-url tests for some corner
 cases
Date: Fri, 6 May 2016 06:17:04 +0200
Message-ID: <4349487f-716e-dadf-795b-cf790b03e02d@web.de>
References: <1462082573-17992-1-git-send-email-mh@glandium.org>
 <1462265452-32360-1-git-send-email-mh@glandium.org>
 <1462265452-32360-2-git-send-email-mh@glandium.org>
 <xmqqzis7nn02.fsf@gitster.mtv.corp.google.com>
 <20160503224830.GA21973@glandium.org> <20160505215229.GA31157@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, tboegi@web.de
To: Mike Hommey <mh@glandium.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 06 06:17:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayXD4-0008RN-IA
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 06:17:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750860AbcEFERq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 00:17:46 -0400
Received: from mout.web.de ([212.227.15.4]:62352 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750727AbcEFERp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2016 00:17:45 -0400
Received: from birne9.local ([195.252.60.88]) by smtp.web.de (mrweb002) with
 ESMTPSA (Nemesis) id 0MaJgG-1bDzeM0Ajw-00JtlR; Fri, 06 May 2016 06:17:14
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:45.0)
 Gecko/20100101 Thunderbird/45.0
In-Reply-To: <20160505215229.GA31157@glandium.org>
X-Provags-ID: V03:K0:npE7PgwSib5I3EsMY8hx11nAbx1aoZEF/aywARanveGLHLZaVCk
 LRVh/CtLeHEGDUS2S28nc5ZuHclBT/z8YyQWohCubKpBRLbTzeJZfrO/db6ty/VC50FxYwd
 M5ye6nsNRDtjws/5bmFNVm4SW0gG+HzT3yMENk7gXX8EPxDJk+xb0pgzQsffO3z+A6FE98e
 Ta5bAW74kGJc92YyURmUA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:y9VfoFoXl2U=:8y3dNlztgH+igRo7dMGdtS
 jVUfbNEHQaqM/81q0fG2pF72S8pGsHEkS1BU+zOGQcu6URL3IPFrC7weEJqILCeFppXxn1c1a
 R+gBqqjW5APgVUKbU/BHKGe8oUAfxv/iLyTYEOcwCgnCSZsenihbG5tnKHKPN5je7bGPNF3nr
 BqhNRIqyMOgIcs9aZTvmqh2E/+f2jwNBlf2EDGkGZAxcYp9UWiqpuKNnyhVMIONyw4fsu9PRi
 5cLw29e2MAJW7MW5tR2jrhx9B9EB6QryNg9vv4GDLq74Txy5LdyUOzyv07npDtS1Ahk+JlPWR
 SLlawY362sFti51hpJ2toGJvW04G4FWs7bvlJC3c+e86vKQceOJA4uiNuWUaNKq1BKQBTe8bz
 /XdxrARbfXoEEBBiMVxY2kUFXuFxLH4JYINYVjmk6PidV64t5ZWwfbo5AKAQ7xz2ZnhdnB+IA
 f+c+nUYI27V7AKOmMY5jrhpSuGoZ08zroase7wf+/6OCoGjm6ZEWv7oAz/AiU5t4B2sOP4PVd
 JjkkizNJraT7Ca5+RhGRj3xUltaaaUmHRhmj4OhB6Q0joLMlVYIssGoiKlBywd8IQeqK5908E
 VJdMd0w2vEtaaGdsA0G4aivxOGJukhj2IcWHvi6ldHuIgRcWnGKPt4gU0yebPBW/YbB+kj5wO
 G4ozKfyc3dXJ3HyJy6WEyA7OU2QKJuISaHcLxfp0BzjBOX4f0JWqHTuHXdC+yPuQcXwCnjacd
 E8E4d12th0T00+cODHv7+pbJ+lCkpIB3JhDnNtCdEQOou9IOSdsiQm6jsis8xLVPW184dL0a 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293737>

On 05.05.16 23:52, Mike Hommey wrote:
> On Wed, May 04, 2016 at 07:48:30AM +0900, Mike Hommey wrote:
>> On Tue, May 03, 2016 at 09:07:41AM -0700, Junio C Hamano wrote:
>>> Mike Hommey <mh@glandium.org> writes:
>>>
>>>> t5603-clone-dirname uses url patterns that are not tested with
>>>> fetch-pack --diag-url, and it would be useful if they were.
>>>>
>>>> Interestingly, some of those tests, involving both a port and a
>>>> user:password pair, don't currently pass. Note that even if a
>>>> user:password pair is actually not supported by git, the values used
>>>> could be valid user names (user names can actually contain colons
>>>> and at signs), and are still worth testing the url parser for.
>>>
>>> I am not sure about the last part of this (and the tests in the
>>> patch for them).  When you are constrained by the Common Internet
>>> Scheme Syntax, i.e.
>>>
>>>     <scheme>://<user>:<password>@<host>:<port>/<url-path>
>>>
>>> you cannot have arbitrary characters in these parts; within the user
>>> and password field, any ":", "@", or "/" must be encoded.
>>>
>>> Which maens that for the purpose of the parser you are modifying,
>>> you can rely on these three special characters to parse things out
>>> (decoding after the code determines which part is user and which
>>> part is password is a separate issue).
>>
>> t5603-clone-dirname contains a test for e.g. ssh://user:passw@rd@host:1234/
>> That's the basis for these additions. Whether that should work or not is
>> besides what I was interested in, which was to have a single test file to
>> run to test my changes, instead of several.
>>
>> Strictly speaking, this patch is not necessary, because it only covers
>> things that I found while breaking other tests.
>>
>> So, there are multiple possible ways forward here:
>> - Completely remove this patch for v5 of the series.
>> - Remove the user:passw@rd cases because of the @.
>> - Remove the user:password cases because we do nothing with the password
>>   anyways.
>> - A combination of both of the above.
> 
> Any opinions on this?

ssh itself does not use a password:

SSH(1)                    BSD General Commands Manual                   SSH(1)

NAME
     ssh -- OpenSSH SSH client (remote login program)

SYNOPSIS
     ssh [-1246AaCfgKkMNnqsTtVvXxYy] [-b bind_address] [-c cipher_spec]
         [-D [bind_address:]port] [-e escape_char] [-F configfile] [-I pkcs11]
         [-i identity_file] [-L [bind_address:]port:host:hostport]
         [-l login_name] [-m mac_spec] [-O ctl_cmd] [-o option] [-p port]
         [-R [bind_address:]port:host:hostport] [-S ctl_path] [-W host:port]
         [-w local_tun[:remote_tun]] [user@]hostname [command]


Neither does Git.
A user name must not include a ':'

The user:password came in here:
Commit 92722efec01f67a54b
clone: do not use port number as dir name

Actually, looking back, it may have been better to say
git clone ssh://aaaa:bbbb@host:/path
is illegal and simply die() out.

Back to your question and looking at the offered alternatives. I would vote for
"Completely remove this patch for v5 of the series."
