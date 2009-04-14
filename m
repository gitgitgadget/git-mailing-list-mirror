From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH RFC3 09/13] send-email: Remove horrible mix of tabs and spaces
Date: Tue, 14 Apr 2009 02:03:54 -0500
Message-ID: <27f7c25b-7bdc-40d1-a601-bd162ebbe2f2@gmail.com>
References: <1239647037-15381-1-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-3-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-4-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-5-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-6-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-7-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-8-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-9-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-10-git-send-email-mfwitten@gmail.com>
 <7vab6ke0ip.fsf@gitster.siamese.dyndns.org>
 <b4087cc50904131549sec5acc4m7201b1411245b95f@mail.gmail.com>
 <49E41F99.6010409@op5.se>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Apr 14 09:09:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ltcm8-0000xq-4a
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 09:09:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751827AbZDNHIL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2009 03:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751035AbZDNHIJ
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 03:08:09 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:15697 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512AbZDNHII (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2009 03:08:08 -0400
Received: by yx-out-2324.google.com with SMTP id 31so2552096yxl.1
        for <git@vger.kernel.org>; Tue, 14 Apr 2009 00:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:date:subject
         :message-id:references:in-reply-to;
        bh=kWivEpx37NXLn+1txCgTD9x45sApR6h598w6/1BUvFE=;
        b=V/QHh6HJtCkJ6pFnnqcbLx4xFHmDViwk9yx9FNL5QqBEFAruZ+Mn9yypIJvoMLLhAS
         M6M+/TZXZbM7XDDuxtpTBl/v1AcKxTd/ZmVpNjTqFZVl2xPP5sjm8DR69b74IOlofP4Z
         8S8j88sQMs8mAWHERU38qesqH+t0QuTBgw4fo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:date:subject:message-id:references:in-reply-to;
        b=ul/wyi+bEAj6ayIFJVbjIZ0hEEu77tTTKjR42uXrvNDOQmcj+nnHuGcOF0N021sRpq
         8PN4Pe+7nVTbx80ZDwfZDlsBJOssKk0xLSOGNboZsTvn7I6L8R8w0tH57tJUMfpkofYl
         bPywfI0v0Evqq2wXSbS41zepkbU9NZVZztP5s=
Received: by 10.100.122.12 with SMTP id u12mr8961349anc.9.1239692886255;
        Tue, 14 Apr 2009 00:08:06 -0700 (PDT)
Received: from gmail.com (97-116-116-167.mpls.qwest.net [97.116.116.167])
        by mx.google.com with ESMTPS id 6sm10672574ywp.51.2009.04.14.00.08.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 14 Apr 2009 00:08:05 -0700 (PDT)
In-Reply-To: <49E41F99.6010409@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116524>

On Tue, Apr 14, 2009 at 00:31, Andreas Ericsson <ae@op5.se> wrote:
> Michael Witten wrote:
>>
>> On Mon, Apr 13, 2009 at 15:55, Junio C Hamano <gitster@pobox.com> wrote:
>>>
>>> Michael Witten <mfwitten@gmail.com> writes:
>>>
>>>> Currently, no lines match the following:
>>>>
>>>>    [\t]+[ ]+
>>>>    [ ]+[\t]+
>>>
>>> I understand the latter but what's wrong with the former?  The width of a
>>> HT is by definition 8 columns throughout the git codebase.
>>
>> Ah, well, the width of a HT has been a free variable in my
>> calculations; I was operating under the assumption that whitespace
>> used for indentation can float freely according to the user's
>> settings. A few of the lines were aligning function arguments via tabs
>> and a few extra spaces, which is not reliable in my model.
>>
>> Frankly, I don't like tabs and spaces sharing the same contiguous
>> block. I don't like it all. ;-B
>
> Using tabs to align stuff to indentation level and spaces to align
> line continuation is the only possible way to let users choose
> whichever indentation depth they want while preserving the continuation
> alignment. What's not to like about that? Especially if you think a
> horizontal tab can be any size at all, you should be all agog.

However, nobody ever gets that right, because they don't understand
what you mean by indentation level. For most code that people write,
indentation whitespace overlaps with non-whitespace (from the
previous line). Therefore, the spaces used for continuation alignment
with the previous line are left 'sitting on shaky ground'. For
instance, consider this fine piece of code, given by lines 609-612 in
builtin-log.c. If you're viewing this code with a monospace font and
HT set to 8 columns, then the tab->spaces expansion should give the
following result (monospace font required to view this properly):

static void make_cover_letter(struct rev_info *rev, int use_stdout,
                              int numbered, int numbered_files,
                              struct commit *origin,
                              int nr, struct commit **list, struct commit *head)

Beautiful, isn't it?

In this case, we're at indentation level ---> 0 <---, and this means
that to form the continuation alignment, 0 tabs should be used
followed by however many spaces are needed to achieve the alignment.
However, whoever wrote that code actually used indentation level 3:

<HT><HT><HT><SP><SP><SP><SP><SP><SP>

The problem is that variable-width characters (HTs) are being aligned
with fixed-width characters. For shame!

To be explicit, if the HT width is set to 4, the result would be
(after HT->spaces expansion):

static void make_cover_letter(struct rev_info *rev, int use_stdout,
                  int numbered, int numbered_files,
                  struct commit *origin,
                  int nr, struct commit **list, struct commit *head)

Clearly, this is never a problem if you declare HTs to be fixed-width
(which, I believe, Linus did do: 8 columns per HT), or if you can
remember that HTs should never be used to align against non-HTs.

What I like to do is provide a more regular structure that removes the
juxtaposition of indentation and alignment whitespace. Basically, HTs
and spaces should never be contiguous, and the first use of a non-HT
prohibits HTs from being used anywhere further down the line. Also,
the structure of the code should facilitate identation levels:

static void make_cover_letter
(
	/* These are all at indentation level 1 */

	struct rev_info* rev            ,
	int              use_stdout     ,
	int              numbered       ,
	int              numbered_files ,
	struct commit*   origin         ,
	int              nr             ,
	struct commit**  list           ,
	struct commit*   head
)
{
	/* Code at indentation level 1 */
}

Yeah, yeah, I know it's crazy, but it makes code wildly readable---to me.

Sincerely,
Michael Witten
