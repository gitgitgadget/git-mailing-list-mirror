From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: t3010 broken by 2eac2a4
Date: Fri, 23 Aug 2013 05:19:52 -0400
Message-ID: <CAPig+cRumXHk-30yvS8Q2xvOxA0qEEXaD7=iJo_X26HL-YRRJg@mail.gmail.com>
References: <82078845-3AB9-4B36-9130-039CC33C8A7A@gernhardtsoftware.com>
	<xmqqbo4qu3g4.fsf@gitster.dls.corp.google.com>
	<CAPig+cQHTvmTWvGfg1Z3KfBrPD+QbSEbYBYz6XWT3KKu3-+jyQ@mail.gmail.com>
	<xmqqbo4pqvde.fsf@gitster.dls.corp.google.com>
	<CAPig+cQmvRDDc3BHbta_UhCQe9QvbtAm0RJgt6HbtgFAKgo0Vg@mail.gmail.com>
	<xmqq7gfdqumd.fsf@gitster.dls.corp.google.com>
	<CAPig+cSEQLk2M+X5QP7mkm846wqqHRCjPHgO7O3URvNcsYO6+w@mail.gmail.com>
	<xmqq38q1qu3l.fsf@gitster.dls.corp.google.com>
	<CAPig+cSgM-kO0Mk9qbGfLR8DZkYQt60Va4N2wfRBVqmReTPowQ@mail.gmail.com>
	<CAPig+cQ15Qq7pJ0sLmnuQt_EERn9fkzCa-Gr-pb6a_zf1MLcGQ@mail.gmail.com>
	<xmqqwqndpbfc.fsf@gitster.dls.corp.google.com>
	<CAPig+cSqtMOYvxbvXstm9nqQD9sQ378NKCHSK7Ec6GrK5VJiGA@mail.gmail.com>
	<CAPig+cR0Z0gghUH5C6+XCuGQ3gz5JoWrnObVbbA5_ahPmC8G2Q@mail.gmail.com>
	<7vsiy1j7dd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Brian Gernhardt <brian@gernhardtsoftware.com>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 23 11:19:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCnXD-0005bu-11
	for gcvg-git-2@plane.gmane.org; Fri, 23 Aug 2013 11:19:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753353Ab3HWJTz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Aug 2013 05:19:55 -0400
Received: from mail-la0-f41.google.com ([209.85.215.41]:41103 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752372Ab3HWJTy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Aug 2013 05:19:54 -0400
Received: by mail-la0-f41.google.com with SMTP id ec20so303003lab.28
        for <git@vger.kernel.org>; Fri, 23 Aug 2013 02:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=aRbn9+Y+dZlkXKDe+tgQy0cRkDgKfDBPejwSAfmzt/U=;
        b=sBo+LLbd1UnXR3l2j57HbzJzKrHBiVrWctEMvbYB85JQKPLropxPW7CHh7I5ZHYndT
         ocqC5cO875kjuSrS5g1gPN3BjiYlDv05J54CBElBP0y9xkdTfhV01Hs43DIih9vgoCKa
         rTdwY1vvMz4od8k1i28b9DMzFtzCdmhICjnnQBZI31WBGEjAuMeIMIeM8HfFWTBA77hY
         2xAm+efN4JATy+MBGYoPSWsWd+LmMe1LSxD13QmrbqLrYk9Xps/QmbAwaSkjGdt9wIMn
         oJeTSK7x4m5Rfi2YyZhES/+BEZzIW9aeTeasO5jxSBQef9pU8xCHPegQPh/6JpUsbGqq
         dUkw==
X-Received: by 10.112.156.166 with SMTP id wf6mr15163233lbb.13.1377249592547;
 Fri, 23 Aug 2013 02:19:52 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Fri, 23 Aug 2013 02:19:52 -0700 (PDT)
In-Reply-To: <7vsiy1j7dd.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: SGE90wuYHdzGjSQc9sfnNk5Yflk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232804>

On Fri, Aug 23, 2013 at 1:36 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> I sent a patch [1] which resolves the problem, although the solution
>> is not especially pretty (due to some ugliness in the existing
>> implementation).
>
> Yeah, thanks.
>
> I tend to agree with you that fixing the "icase" callee not to rely
> on having the trailing slash (which is looking past the end of the
> given string), instead of working that breakage around on the
> caller's side like your patch did, would be a better alternative,
> though.

My concern with fixing directory_exists_in_index_icase() to add the
'/' itself was that it would have to copy the string to make space for
the '/', which could be expensive. However, I reworked the code so
that the existing strbufs now get passed to
directory_exists_in_index_icase(), which allows it to add its needed
'/' without duplicating the string. So, the trailing '/' requirement
of directory_exists_in_index_icase() is now a private implementation
detail, placing no burden on the caller.

I'll send the revised patch series later today since the commit
message needs a rewrite. Also, I'd like to try to split the change
into a couple patches -- one to pass around strbufs, which has a noisy
diff, and one to fix the actual bug -- though I fear that splitting
may not be possible.
