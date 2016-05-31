From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 2/2] strbuf: allow to use preallocated memory
Date: Tue, 31 May 2016 10:25:29 +0200
Message-ID: <574D4A79.1030405@alum.mit.edu>
References: <20160530103642.7213-1-william.duclot@ensimag.grenoble-inp.fr>
 <20160530103642.7213-3-william.duclot@ensimag.grenoble-inp.fr>
 <alpine.DEB.2.20.1605301326530.4449@virtualbox>
 <574CFF75.3090805@alum.mit.edu>
 <alpine.DEB.2.20.1605310822490.4449@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: William Duclot <william.duclot@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org, simon.rabourg@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr,
	antoine.queru@ensimag.grenoble-inp.fr, matthieu.moy@grenoble-inp.fr
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue May 31 10:26:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7ezz-00015Z-C6
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 10:26:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756570AbcEaIZt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 04:25:49 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:59282 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755906AbcEaIZq (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 May 2016 04:25:46 -0400
X-AuditID: 1207440f-8bbff700000008e4-a0-574d4a7c12d1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id BD.FA.02276.C7A4D475; Tue, 31 May 2016 04:25:32 -0400 (EDT)
Received: from [192.168.69.130] (p508EABD0.dip0.t-ipconnect.de [80.142.171.208])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u4V8PTtE003647
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 31 May 2016 04:25:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.8.0
In-Reply-To: <alpine.DEB.2.20.1605310822490.4449@virtualbox>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJKsWRmVeSWpSXmKPExsUixO6iqFvj5RtusLWH02LyhnusFnebMiy6
	rnQzWfQv72KzuPR5PavF1a03GS12T77E6MDucbU5wOPDxziPiV+Os3p83iQXwBLFbZOUWFIW
	nJmep2+XwJ3x/f5UpoJO6Yqpq5pZGhjviXYxcnJICJhI/NoyjxHEFhLYyigx91hFFyMXkH2B
	SeLv5wcsIAlhAUeJc7cOs4HYIkANjTsb2CCKJjJJ7Ph0ixnEYRZoYJJ4d+4ZM0gVm4CuxKKe
	ZiYQm1dAW+L4k39gNouAqsS+T8fB1okKhEicX7eVFaJGUOLkzCdg2zgFbCS2P//JDmIzC+hJ
	7Lj+ixXClpfY/nYO8wRG/llIWmYhKZuFpGwBI/MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl0T
	vdzMEr3UlNJNjJCg5t/B2LVe5hCjAAejEg9vRLdPuBBrYllxZe4hRkkOJiVRXqvfQCG+pPyU
	yozE4oz4otKc1OJDjBIczEoivLmevuFCvCmJlVWpRfkwKWkOFiVxXvUl6n5CAumJJanZqakF
	qUUwWRkODiUJ3gUgjYJFqempFWmZOSUIaSYOTpDhXFIixal5KalFiaUlGfGgqIwvBsYlSIoH
	aK8V2N7igsRcoChE6ylGXY4j+++tZRJiycvPS5US533sAVQkAFKUUZoHtwKWwl4xigN9LMxb
	CjKKB5j+4Ca9AlrCBLQkPsMHZElJIkJKqoGxO0ckouy6tlOKwvpm3cVVlxoLlgQdZrwYe7M/
	Ln/vgVkP3h1IqdDgmNNQrNZiuuqN2wun/5+fFvBIzTv2WGXmS4nHminxLisuW0xU 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295964>

On 05/31/2016 08:41 AM, Johannes Schindelin wrote:
> Hi Michael,
> 
> On Tue, 31 May 2016, Michael Haggerty wrote:
> 
>> On 05/30/2016 02:13 PM, Johannes Schindelin wrote:
>>> [...]
>>>> @@ -38,7 +67,11 @@ char *strbuf_detach(struct strbuf *sb, size_t *sz)
>>>>  {
>>>>  	char *res;
>>>>  	strbuf_grow(sb, 0);
>>>> -	res = sb->buf;
>>>> +	if (sb->flags & STRBUF_OWNS_MEMORY)
>>>> +		res = sb->buf;
>>>> +	else
>>>> +		res = xmemdupz(sb->buf, sb->alloc - 1);
>>>
>>> This looks like a usage to be avoided: if we plan to detach the buffer,
>>> anyway, there is no good reason to allocate it on the heap first. I would
>>> at least issue a warning here.
>>
>> I think this last case should be changed to
>>
>>     res = xmemdupz(sb->buf, sb->len);
>>
>> Johannes, if this change is made then I think that there is a reasonable
>> use case for calling `strbuf_detach()` on a strbuf that wraps a
>> stack-allocated string, so I don't think that a warning is needed.
>>
>> I think this change makes sense. After all, once a caller detaches a
>> string, it is probably not planning on growing/shrinking it anymore, so
>> any more space than that would probably be wasted. In fact, since the
>> caller has no way to ask how much extra space the detached string has
>> allocated, it is almost guaranteed that the space would be wasted.
> 
> Ah, I did not think of that. (We could of course introduce
> strbuf_realloc_snugly() or some such, but I agree: why?) So the best
> counter-example to my objection might be something like this:
> 
> -- snip --
> Subject: git_pathdup(): avoid realloc()
> 
> When generating Git paths, we already know the maximum length:
> MAX_PATH. Let's avoid realloc()-caused fragmentation by using a
> fixed buffer.
> 
> As a side effect, we avoid overallocating the end result, too:
> previously, strbuf_detach() would not realloc() to avoid wasting
> the (sb->alloc - sb->len) bytes, while it malloc()s the precisely
> needed amount of memory when detaching fixed buffers.
> 
> diff --git a/path.c b/path.c
> index 2511d8a..64fd3ee 100644
> --- a/path.c
> +++ b/path.c
> @@ -426,7 +426,8 @@ const char *git_path(const char *fmt, ...)
>  
>  char *git_pathdup(const char *fmt, ...)
>  {
> -	struct strbuf path = STRBUF_INIT;
> +	char buffer[MAX_PATH];
> +	struct strbuf path = STRBUF_WRAP_FIXED(buffer);
>  	va_list args;
>  	va_start(args, fmt);
>  	do_git_path(&path, fmt, args);
> -- snap --

I like the idea, but apparently MAX_PATH is not a hard limit that OSs
must respect (e.g., see [1]). The existing implementation can generate
paths longer than MAX_PATH whereas your replacement cannot.

This would be easy to solve by using STRBUF_WRAP_MOVABLE() instead of
STRBUF_WRAP_FIXED() in your patch. We would thereby accept the
possibility that the strbuf might need to be expanded for really long
paths. However, if that happens, then strbuf_detach() is likely to
return the string in an overallocated memory area.

So if there are callers who *really* care about not having overallocated
memory, we might want a strbuf_detach_snugly().

Your (only half-serious) idea for strbuf_realloc_snugly() would have the
disadvantage that it couldn't work with a fixed strbuf, whereas
strbuf_detach_snugly() could. It would be sad for callers to have to
worry about the distinction.

Michael

[1] http://insanecoding.blogspot.de/2007/11/pathmax-simply-isnt.html
