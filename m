From: Michel Lespinasse <walken@google.com>
Subject: Re: [Ksummit-2013-discuss] [PATCH] commit: Add -f, --fixes <commit>
 option to add Fixes: line
Date: Sun, 27 Oct 2013 01:03:47 -0700
Message-ID: <CANN689HctBYZfU+OQ7movFFWNm6rwUdU7G-ExxhPcBPg1KF8Jw@mail.gmail.com>
References: <20131024122255.GI9378@mwanda>
	<20131024122512.GB9534@mwanda>
	<20131026181709.GB10488@kroah.com>
	<20131027013402.GA7146@leaf>
	<526CA7D4.1070904@alum.mit.edu>
	<20131027071407.GA11683@leaf>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	ksummit-2013-discuss@lists.linuxfoundation.org,
	LKML <linux-kernel@vger.kernel.org>,
	ksummit-attendees@lists.linuxfoundation.org,
	Git Mailing List <git@vger.kernel.org>,
	Dan Carpenter <dan.carpenter@oracle.com>
To: Josh Triplett <josh@joshtriplett.org>
X-From: linux-kernel-owner@vger.kernel.org Sun Oct 27 09:04:01 2013
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1VaLKK-0001ZT-LU
	for glk-linux-kernel-3@plane.gmane.org; Sun, 27 Oct 2013 09:04:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752587Ab3J0IDw (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Sun, 27 Oct 2013 04:03:52 -0400
Received: from mail-qe0-f48.google.com ([209.85.128.48]:35602 "EHLO
	mail-qe0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245Ab3J0IDs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Oct 2013 04:03:48 -0400
Received: by mail-qe0-f48.google.com with SMTP id d4so3278265qej.7
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2013 01:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=XQUPdU8wofHuIq92BgvStyTFqX39Ia5uWKzpNYEK1R0=;
        b=lJKl2BT/KGAcXoZVpbNfuxKC0SOrXTXr4sLtnzAXuyu1Y5jUX3ukl4rMBNy9Ass/id
         AXxvBKLw6WCfwjCjl1sF5CfwZGtrkX6sWjx9IoXjY7T2a+fbodUcNlLioK1pdedfqurs
         vlEyxqLYjN6irFvmsRLpYerJqE3zrgAay9NxAAOxzPWHJIdyaIu2NQGXfhi6WiF67Bcp
         3cPGCtrbLe/l46+4m4PpTuMS5ynddwSSxZ15LK7WUNhqRDuaZI28r1DolgYm00vxImkK
         iJaPD+YDCyjbglcV3YZZUSWVWoPLNKQcOytDp+OZ4JFN6fOems2QiXuLgCi4Li8zijxs
         tUCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=XQUPdU8wofHuIq92BgvStyTFqX39Ia5uWKzpNYEK1R0=;
        b=Ov6DOINTO/v54ilJ2uN8BjfrJcg4fy893BRklb2Hy25iN4Uh7WEAqlJZe1ywRrC+aL
         hj0KooNkVfj9qHtIy2v2jB2vG8hchGKA52AuncHiWqYp3iN5YO2FyxuBnDI97UqLjV17
         KO6O5fCuNFAeGw8n2B6/EX1zBAbN2AvlEHLEcihbKovcknd362OOOYCW8eWzrn3SzBe/
         MKzQJewmT5+ydBDPGWCPfzRO/5f64DtXoWvdXtdFrZt197P42j+nUV5oixfonRKBiT2s
         yQXGZx/KcANFP/j9EMlGIYl9HVVwneSI8KbyIauy2pd7yQa4QDQxzyENn7IMAaIZTh4a
         Tv3w==
X-Gm-Message-State: ALoCoQnLuXGllkeTOIOQKDYE0uRyDZ1+HmvyL7K8LF3rWkWOCGGCTrZytVYoZLXvn3eOXV6epCoEXciYi8nP9YlA1vp3COzIK1Aic1I5B1X/U8FPxMiT2exHhTkYqq5nLH5hnU8Djaw6vNar8xqPQ6dXJe+RgolcR7JXeoa+Yy+4lSB5d6tBIh6PEonZLV9EHG3dSbfK8OMkiLdRr+OTdABVSdicTy4Mmg==
X-Received: by 10.224.51.131 with SMTP id d3mr22624345qag.0.1382861027697;
 Sun, 27 Oct 2013 01:03:47 -0700 (PDT)
Received: by 10.229.203.5 with HTTP; Sun, 27 Oct 2013 01:03:47 -0700 (PDT)
In-Reply-To: <20131027071407.GA11683@leaf>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236791>

On Sun, Oct 27, 2013 at 12:14 AM, Josh Triplett <josh@joshtriplett.org> wrote:
>> > +-f <commit>::
>> > +--fixes=<commit>::
>> > +   Add Fixes line for the specified commit at the end of the commit
>> > +   log message.  This line includes an abbreviated commit hash for
>> > +   the specified commit; the `core.abbrev` option determines the
>> > +   length of the abbreviated commit hash used, with a minimum length
>> > +   of 12 hex digits.
>>
>> You might also mention that the "Fixes:" line includes the old commit's
>> subject line.
>
> I only mentioned the abbreviated commit hash because it was necessary to
> explain the factors affecting hash length.  -s, above, doesn't mention
> that the Signed-off-by line includes the name and email address of the
> committer.

I do wonder, if we're going to bake into git the idea that too-short
abbreviated sha1s don't make sense, why don't we just change the
core.abbrev default to 12 everywhere rather than just in this one
command ?

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
