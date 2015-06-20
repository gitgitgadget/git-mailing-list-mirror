From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 12/12] refs: move the remaining ref module declarations
 to refs.h
Date: Sat, 20 Jun 2015 03:53:13 +0200
Message-ID: <5584C789.7020209@alum.mit.edu>
References: <cover.1434206062.git.mhagger@alum.mit.edu> <79947baebd702f8e9fe9b667e2eeb69afa73094b.1434206062.git.mhagger@alum.mit.edu> <xmqqfv5salh9.fsf@gitster.dls.corp.google.com> <20150615183504.GB4041@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 20 03:53:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z67yV-00076S-0g
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jun 2015 03:53:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753974AbbFTBxa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 21:53:30 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:50373 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752394AbbFTBx2 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Jun 2015 21:53:28 -0400
X-AuditID: 1207440e-f79516d0000012b3-81-5584c78c3cb4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id A5.89.04787.C87C4855; Fri, 19 Jun 2015 21:53:16 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB04CB.dip0.t-ipconnect.de [93.219.4.203])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t5K1rEKZ017565
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 19 Jun 2015 21:53:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <20150615183504.GB4041@peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBKsWRmVeSWpSXmKPExsUixO6iqNtzvCXU4OJOGYuuK91MFg29V5gt
	frT0MFts3tzO4sDisWBTqcez3j2MHhcvKXt83iQXwBLFbZOUWFIWnJmep2+XwJ3xaON6poKV
	4hXzX95laWC8KNTFyMEhIWAicX2XbRcjJ5ApJnHh3nq2LkYuDiGBy4wS+7dcYYdwzjFJ7O7/
	zgbSwCugLbHrsxNIA4uAqsTjxzuYQWw2AV2JRT3NTCAlogJBEq9f5oKEeQUEJU7OfMICYosI
	OEpc2HIEzGYWsJZY3rWWHcQWFoiS6Glaxgix6hqjxJmLTYwgCU6gmYfvNbJBNKhL/Jl3iRnC
	lpdo3jqbeQKjwCwkO2YhKZuFpGwBI/MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl1jvdzMEr3U
	lNJNjJBQ5tvB2L5e5hCjAAejEg/vj6UtoUKsiWXFlbmHGCU5mJREeU8fAgrxJeWnVGYkFmfE
	F5XmpBYfYpTgYFYS4Z07GyjHm5JYWZValA+TkuZgURLnVVui7ickkJ5YkpqdmlqQWgSTleHg
	UJLgXXEMqFGwKDU9tSItM6cEIc3EwQkynEtKpDg1LyW1KLG0JCMeFKfxxcBIBUnxAO3dD9LO
	W1yQmAsUhWg9xagoJc6bAZIQAElklObBjYUlqFeM4kBfCvNKg1TxAJMbXPcroMFMQIMnlDeB
	DC5JREhJNTAWbA78IH5ex8Y2d6FXvLZJwr1/jS9s5MolNolden9ghZSl6oHuV09Yb+iksu9Q
	rTpnH1vtbWVXfvjUpVeaWgzqB5dNmfjMo3exVdFzsbjwY5z2vZWrRIW1V67b9DDo 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272219>

On 06/15/2015 08:35 PM, Jeff King wrote:
> On Mon, Jun 15, 2015 at 11:13:22AM -0700, Junio C Hamano wrote:
> 
>>> @@ -78,15 +170,15 @@ typedef int each_ref_fn(const char *refname,
>>>   * modifies the reference also returns a nonzero value to immediately
>>>   * stop the iteration.
>>>   */
>>> -extern int head_ref(each_ref_fn, void *);
>>> +extern int head_ref(each_ref_fn fn, void *cb_data);
>>
>> For example, between these two, what did we gain?
>>
>> Because of their types, it already was clear what the two parameters
>> are in the original, without noisewords like "fn" (which obviously
>> stands for a "function", but that is clear due to "each_ref_fn").
> 
> I think the real benefit of naming parameters is that you can talk about
> "fn" and "cb_data" by name in the docstring[1]. Of course we do not do
> that here, so we could clearly wait until "if-and-when" we do so. But I
> do not think it is a big deal for our style guide to say "we always name
> parameters in declarations", and to bring things in line there (though
> perhaps it should be a separate patch in that case).

I also like the idea that all parameters in declarations should be
named. It is true that sometimes the purpose of a parameter is easy to
guess from its type without a name. But giving them names make them
easier to talk about in docstrings, in commit messages, or even on the
mailing list when reviewing patches or discussing bugs.

Moreover, I don't see the value of wasting mental energy wondering
"hmmm, in this case is the meaning sufficiently obvious from the type?"
every time I write a function declaration. It is easier to have a
consistent policy of putting them in.

Finally, when I'm inventing new functions (which I admit isn't the case
here), I usually write the declaration first and then copy-paste it to
the C file as the first step in writing the definition. If I name the
parameters in the declaration then (a) I don't have to go back and edit
them at the definition and (b) if parameter names are needed later at
the declaration (e.g., for a docstring), I don't have to edit the
declaration again, cross-referencing back to the C file to make sure I
name them consistently.

I will split the "add names in declarations" changes into a separate
patch. Also, that way Junio can ignore the patch if he still disagrees :-)

>>> -extern int for_each_glob_ref_in(each_ref_fn, const char *pattern, const char* prefix, void *);
>>> +extern int for_each_glob_ref_in(each_ref_fn fn, const char *pattern, const char* prefix, void *cb_data);
>>
>> Likewise for addition of fn and cb_data.
>>
>> If you really want to make unrelated changes to this file, what you
>> should fix is to update "const char* prefix" to "const char *prefix"
>> ;-)
> 
> IMHO they are in the same boat (style fixes), and I would be happy to
> see both improved. :)

I will fix this too.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
