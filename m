From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] Move sequencer to builtin
Date: Sun, 9 Jun 2013 13:11:16 -0500
Message-ID: <CAMP44s33wC0p_K8zhovWrgMua9qzZ3064BFxJ+m00Lt39ZPPQQ@mail.gmail.com>
References: <CACsJy8A-qc0tHcsp5=syxv_7FjixahU7fGcZuUV=cGn_-qyWwg@mail.gmail.com>
	<CAMP44s2fP4_=HtOsuwmxXG8qmp8CmpgEhz=BJFOFZxsTf_3gcQ@mail.gmail.com>
	<CACsJy8CQRWU0mFLVD6RrpzJiHBH=9zFwf5xDo7UhGW6A-OAzuw@mail.gmail.com>
	<CALkWK0mLoeO5fKezE5S1LEC2LNH9qCwxHnNi_ZJpYzC7rVTqmg@mail.gmail.com>
	<CACsJy8B=m95mpRn1dAwQZAvHRUeJVjKy1hKXv43EKX08ZODsDw@mail.gmail.com>
	<CALkWK0mw8=CMuyw5-E0fzh+c6Om_NCgHohqa_p=J_kw3UfJCJQ@mail.gmail.com>
	<CACsJy8AtH6PQ06_-UgumV0dRdq28qKn-Oj7EAy3g+eOTGhOyYw@mail.gmail.com>
	<CAMP44s2uV6CwdyadnJXSd+3mhOdApDxqdtjNyOPj3CbdsEyG0Q@mail.gmail.com>
	<20130609043444.GA561@sigill.intra.peff.net>
	<CALkWK0kkGO8zoLSpZkaYgVr5eBX6AovYFxQZkgJKugSw0CmdXQ@mail.gmail.com>
	<20130609175554.GA810@sigill.intra.peff.net>
	<CALkWK0n0kkNZo_Xt1oT5GL-TxZP0faDExxyH3vU-+hy4uEUEtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 20:11:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ulk5K-0000iJ-T9
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 20:11:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752000Ab3FISLT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 14:11:19 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:38674 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751667Ab3FISLS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 14:11:18 -0400
Received: by mail-lb0-f179.google.com with SMTP id w20so5639472lbh.38
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 11:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=IP5oxk4NzUSBZkSmBPzaJ7tBxnrRLML2uSJWiUTp8lQ=;
        b=WnUHngym1FArx7TopCrj27cs2X94Ub7XH2HvNHytPYZjlLz/PdGw50uPMGGX7QQvGk
         iWPp+QaZTGjQGQmjSyhd/C4o9E92b0xm6MSBS9OvIiqZO4h5kxcn7qDIv26hEiRC3Uzr
         n9W3a71Cnb8unkum9oC2AF/rqzmPSW4M6GeAPyAscu44Z3ZRnlntdX+5t9w2NVXStpUs
         RE9jwbgruNq8ST8o+lwqBtLOe4pPb98FBKF8Vi6y0ZPpKVwqwNm/P0n0zTKyaep5l7a8
         I+F4hRdwTpd7zCCJfBHMWgF7Y4IiZEA87OkzsvPQHcPciVoOw27VLCst1CWWBIRDWpJ+
         ZIXg==
X-Received: by 10.152.22.130 with SMTP id d2mr2852333laf.33.1370801476989;
 Sun, 09 Jun 2013 11:11:16 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Sun, 9 Jun 2013 11:11:16 -0700 (PDT)
In-Reply-To: <CALkWK0n0kkNZo_Xt1oT5GL-TxZP0faDExxyH3vU-+hy4uEUEtQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227079>

On Sun, Jun 9, 2013 at 1:06 PM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> Jeff King wrote:
>> I already mentioned elsewhere that I think it would be fine to massage
>> libgit.a in that direction. I even joined the conversation pointing out
>> some cases where Felipe's ruby module would break. But I do not think
>> that moving code in and out of libgit.a is an important first step at
>> all. That is simply code that no library users would want to call, and
>> is easy to deal with: move it out. The hard part is code that users
>> _would_ want to call, and is totally broken. Patches dealing with that
>> are the hard obstacle that people working in this direction would need
>> to overcome. But I do not see any such patches under discussion.
>
> Forget the rest; this makes it clear.  Thanks, and sorry for all the confusion.
>
> So, reorganization is not the first step.  Can you please post an
> example patch illustrating what needs to be done, so we can follow?

If you have a code-base with 100 functions, 10 of which make sense in
a public library, instead of going ahead to fix those 10 functions, it
makes sense to *first* separate those 10 functions, and *then* clean
them up for public usage.

But let's assume that Jeff is right and this is not the first step. It
doesn't matter; I already started that step and created builtin/lib.a.
Are you going to throw away that because it's not "the first step"?

-- 
Felipe Contreras
