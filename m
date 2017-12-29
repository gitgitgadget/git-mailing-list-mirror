Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A164C1F404
	for <e@80x24.org>; Fri, 29 Dec 2017 13:01:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751322AbdL2NBV (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Dec 2017 08:01:21 -0500
Received: from mout.web.de ([217.72.192.78]:60110 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751108AbdL2NAM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Dec 2017 08:00:12 -0500
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lpezi-1f6yNR2M5O-00fVOm; Fri, 29
 Dec 2017 13:59:55 +0100
Date:   Fri, 29 Dec 2017 13:59:54 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Lars Schneider <lars.schneider@autodesk.com>,
        Git List <git@vger.kernel.org>, gitster@pobox.com,
        peff@peff.net, patrick@luehne.de
Subject: Re: [PATCH v1] convert: add support for 'encoding' attribute
Message-ID: <20171229125954.GA9772@tor.lan>
References: <20171211155023.1405-1-lars.schneider@autodesk.com>
 <20171217171404.GA18175@tor.lan>
 <BF5C58AC-C1E6-4AD5-A4F8-C4CC5C9108F7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BF5C58AC-C1E6-4AD5-A4F8-C4CC5C9108F7@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:TQpUXNH7t059QZpKrgTy9U1O4ekSJLLfnw0jDQUPYD0ffPTr4z9
 2WWUKqQVRFe2EloDRN51gGJkiIkQnu4+mIh9p6LlX7038JIZtdEQIck6HyO9RVh8Z0unI4U
 wBSxG2QVAEYsegJlToZ722+dAM09y1Jq88mMakpk9YOsPLOE9qmqNnwcMsiUd+eLuIFw03P
 ameV6K5M5C8UBdUJ02Uow==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9DUe3K1oiKQ=:5kdTf4KmKulb7ALJJBSzrn
 fPrWN/sUkDSikkTTvW7ChaIwwmZ/KMd8VdQRMaJQbSIi5ug4L+2Nh6YH9LuSHQZHjDMZgvMHc
 6Je04tTsbfGbt6l2uKR4i5KfR/JykmhFDq5wMrDFMzR79dAwkQ9eYMLneUbmk1GPtQM1swUvS
 711zFwoJJuk/EDj/z+VJkbp+6mwW15cp9auiuTP5V8FwZ/7NLB4oiILN0hVxbBfgxwx3sTqzQ
 S9EAjDVV0JLFLRmHdMw8K2bZhGJU3HXNrAvhFXRxgot/xZRTxwIaLGpZyWaEoELxboxPHGuY+
 poRI0I38nhvhba48CJ1k2gtueipw81RvkXUomjaKvGtw7GkPgNT9uOY3hxau9uXt71xxYfOwQ
 4/+9LHcDcyIBNbkg+d7s0Kl2/ZFctU+/Rw43aJBLpwtN9hK4PL4vMiaTJ2gTF2/OMd68W54ms
 4oKI9afV3p4VqWX6gHTjPtIPG4anYrbdytpm8WKcJQRMQbQuibmRUMFh5FsYXn/W1JW+F2ID7
 slLiV8L4jNu1hF3gBqt4yO0Y9ys8xXfhEtQwEIPRLOKKKxLHKxR7y8eP6EhwJLs8oc4ZBE+bV
 F/pdlVcV38DZwlqiuuu+nFtt5Kxm+RRn7X8E3CbZMlfgCGDvDRIkkCB7bwIkS8VXGagr09Zre
 TKmxdL8Z/TtjJLSDhb5MwcA1iFUhLdSQnc7hcOA4hNTLEdal5CntYGJd5YYEXUgSSb3P6SIOE
 +oDZhdPg2nIoGP47JcXd2kwdabgl5lYt4hZ4ctlnIvTNPStGkN38lKe6lvHD7hPRlc8ixZr0m
 w3vGEmTLXxAmGC5kH5i7Wp8A0SOgA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-12-28 17:14, Lars Schneider wrote:> 
>> On 17 Dec 2017, at 18:14, Torsten Bögershausen <tboegi@web.de> wrote:
>>
>> On Mon, Dec 11, 2017 at 04:50:23PM +0100, lars.schneider@autodesk.com wrote:
>>> From: Lars Schneider <larsxschneider@gmail.com>
>>>
> 
>>> +`encoding`
>>> +^^^^^^^^^^
>>> +
>>> +By default Git assumes UTF-8 encoding for text files.  The `encoding`
>>
>> This is probably "ASCII" and it's supersets like ISO-8859-1 or UTF-8.
> 
> I am not sure I understand what you want to tell me here.
> Do you think UTF-8 encoding is not correct in the sentence above?

Git itself was designed to handle source code in ASCII.
Text files which are encoded in ISO-8859-1, UTF-8 or any
super-set of ASCII are handled as well, and what exactly to do
with bytes >0x80 is outside the responsibility of Git.
E.g. the interpretation and rendering on the screen may be
dependent on the locale or being guessed.
All in all, saying that Git expects UTF-8 may be "overdriven".
Any kind of file that uses an '\n' as an end of line
and has no NUL bytes '\0' works as a text file in Git.
(End of BlaBla ;-)

We can probably replace:
"By default Git assumes UTF-8 encoding for text files"

with something like
"Git handles UTF-8 encoded files as text files, but UTF-16 encoded
 files are handled as binary files"

>>
>>> +attribute sets the encoding to be used in the working directory.
>>> +If the path is added to the index, then Git encodes the content to
>>> +UTF-8.  On checkout the content is encoded back to the original
>>> +encoding.  Consequently, you can use all built-in Git text processing
>>> +tools (e.g. git diff, line ending conversions, etc.) with your
>>> +non-UTF-8 encoded file.
>>> +
>>> +Please note that re-encoding content can cause errors and requires
>>> +resources. Use the `encoding` attribute only if you cannot store
>>> +a file in UTF-8 encoding and if you want Git to be able to process
>>> +the text.
>>> +
>>> +------------------------
>>> +*.txt		text encoding=UTF-16
>>> +------------------------
>>
>> I think that encoding (or worktree-encoding as said elsewhere) must imply text.
>> (That is not done in convert.c, but assuming binary or even auto
>> does not make much sense to me)
> 
> "text" only means "LF". "-text" means CRLF which would be perfectly fine
> for UTF-16. Therefore I don't think we need to imply text.
> Does this make sense?
Yes and now.

"text" means convert CRLF at "git add" (or commit) into LF,
And potentially LF into CRLF at checkout,
depending on the EOL attribute (if set), core.autocrlf and/or core.eol.

"-text" means don't touch CRLF or LF at all. Files with CRLF are commited
with CRLF.
Running a Unix like "diff" tool will often show "^M" to indicate that there
is a CR before the LF, which may be distracting or confusing.

If someone ever wants to handle the UTF-16 files on a Linux/Mac/Unix system,
it makes sense to convert the line endings into LF before storing them
into the index (at least this is my experience).

(Not specifying "text" or "-text" at all will trigger the auto-handling,
 which is not needed at all).
So if we want to be sure that line endings are CRLF in the worktree we
should ask the user to specify things like this:

*.ext worktree-encoding=UTF-16 text eol=CRLF

It may be enough to give this example in the documentation.
and I would rather be over-careful here, to avoid future problems.

> 
>>
>>
>>> +
>>> +All `iconv` encodings with a stable round-trip conversion to and from
>>> +UTF-8 are supported.  You can see a full list with the following command:
>>> +
>>> +------------------------
>>> +iconv --list
>>> +------------------------
>>> +
>>> `eol`
>>> ^^^^^
>>>
>>> diff --git a/convert.c b/convert.c
>>> index 20d7ab67bd..ee19c17104 100644
>>> --- a/convert.c
>>> +++ b/convert.c
>>> @@ -7,6 +7,7 @@
>>> #include "sigchain.h"
>>> #include "pkt-line.h"
>>> #include "sub-process.h"
>>> +#include "utf8.h"
>>>
>>> /*
>>>  * convert.c - convert a file when checking it out and checking it in.
>>> @@ -256,6 +257,149 @@ static int will_convert_lf_to_crlf(size_t len, struct text_stat *stats,
>>>
>>> }
>>
>> I would avoid to use these #ifdefs here.
>> All functions can be in strbuf.c (and may have #ifdefs there), but not here.
> 
> I'll try that. But wouldn't it make more sense to move the functions to utf.c?

May be.
Originally utf8.c was about encoding and all kind of UTF-8 related stuff.
Especially it didn't know anything about strbuf.
I don't know why strbuf.h and other functions had been added here,

I once moved them into strbuf.c without any problems, but never send out
a patch, because of possible merge conflicts in ongoing patches.

In any case, if it is about strbuf, I would try to put it into strbuf.c

>>
>>>
>>> +#ifdef NO_ICONV
>>> +#ifndef _ICONV_T
>>> +/* The type is just a placeholder and not actually used. */
>>> +typedef void* iconv_t;
>>> +#endif
>>> +#endif
>>> +
>>> +static struct encoding {
>>> +	const char *name;
>>> +	iconv_t to_git;       /* conversion to Git's canonical encoding (UTF-8) */
>>> +	iconv_t to_worktree;  /* conversion to user-defined encoding */
>>> +	struct encoding *next;
>>> +} *encoding, **encoding_tail;
>>
>> This seems like an optimazation, assuning that iconv_open() eats a lot of ressources.
>> I don't think this is the case. (Undere MacOS we run iconv_open() together with
>> every opendir(), and optimizing this out did not show any measurable improvements)
> 
> True, but then I would need to free() the memory in a lot of places.How many ?

> Therefore I thought it is easier to keep the object. OK for you?

My first impression was that this optimization made the review hard to do.
I would rather see a clean alloc/free open/close scheme in one patch.
This allows to follow the logic.
And, if needed, an optimizing patch on top of that, saying now
we saved 30 lines of code.

> 
> 
>>> +static const char *default_encoding = "utf-8";
>>
>> The most portable form is "UTF-8" (correct me if that is wrong)
> 
> It shouldn't matter. But I've changed it to uppercase to be on the safe side.Good.

For the interested reader, see utf8.c:
static const char *fallback_encoding(const char *name)
{
	/*
	 * Some platforms do not have the variously spelled variants of
	 * UTF-8, so let's fall back to trying the most official
	 * spelling. We do so only as a fallback in case the platform
	 * does understand the user's spelling, but not our official
	 * one.
	 */

 
> 
>>> +static iconv_t invalid_conversion = (iconv_t)-1;
>>> +
>>> +static int encode_to_git(const char *path, const char *src, size_t src_len,
>>> +			 struct strbuf *buf, struct encoding *enc)
>>> +{
>>> +#ifndef NO_ICONV
>>> +	char *dst, *re_src;
>>> +	int dst_len, re_src_len;
>>> +
>>> +	/*
>>> +	 * No encoding is specified or there is nothing to encode.
>>> +	 * Tell the caller that the content was not modified.
>>> +	 */
>>> +	if (!enc || (src && !src_len))
>>> +		return 0;
>>> +
>>> +	/*
>>> +	 * Looks like we got called from "would_convert_to_git()".
>>> +	 * This means Git wants to know if it would encode (= modify!)
>>> +	 * the content. Let's answer with "yes", since an encoding was
>>> +	 * specified.
>>> +	 */
>>> +	if (!buf && !src)
>>> +		return 1;
>>> +
>>> +	if (enc->to_git == invalid_conversion) {
>>> +		enc->to_git = iconv_open(default_encoding, encoding->name);
>>> +		if (enc->to_git == invalid_conversion)
>>> +			warning(_("unsupported encoding %s"), encoding->name);
>>> +	}
>>
>> 	/* There are 2 different types of reaction:
>> 	      Either users  know what that a warning means: You asked for problems,
>> 	      	        and do the right thing. Other may may ignore the warning
>> 			       - in both cases an error is useful */
> 
> Agreed!
> 
> 
>>> +	if (enc->to_worktree == invalid_conversion)
>>> +		enc->to_worktree = iconv_open(encoding->name, default_encoding);
>>> +
>>> +	/*
>>> +	 * Do nothing if the encoding is not supported. This could happen in
>>> +	 * two cases:
>>> +	 *   (1) The encoding is garbage. That is no problem as we would not
>>> +	 *       encode the content to UTF-8 on "add" and we would not encode
>>> +	 *       it back on "checkout".
>>> +	 *   (2) Git users use different iconv versions that support different
>>> +	 *       encodings. This could lead to problems, as the content might
>>> +	 *       not be encoded on "add" but encoded back on "checkout" (or
>>> +	 *       the other way around).
>>> +	 * We print a one-time warning to the user in both cases above.
>>> +	 */
>>
>> Isn't an error better than "garbage in -> garbage out" ?
> 
> Agreed. I changed the warning to an error.
> 
> 
>>> diff --git a/t/t0028-encoding.sh b/t/t0028-encoding.sh
>>
>> (I didn't review the test yet)
>>
>> Another comment for a possible improvement:
>> "git diff"  could be told to write the worktree-encoding into the diff,
>> and "git apply" can pick that up. 
> 
> Yes, we could do that. However, I would tackle that in a separate series.
> 
> 
> Thanks,
> Lars
> 


