From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 0/2] notes: allow read only notes actions on refs outside
 of refs/notes
Date: Wed, 16 Sep 2015 16:01:29 -0700
Message-ID: <CA+P7+xqxajmGysjyenMv=UeS3DdofKvMTDXtDzrnGnBAQwzyBQ@mail.gmail.com>
References: <1442441194-5506-1-git-send-email-jacob.e.keller@intel.com> <20150916223602.GA4197@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Git List <git@vger.kernel.org>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Thu Sep 17 01:01:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcLi5-0007i4-Of
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 01:01:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752960AbbIPXBu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 19:01:50 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:38665 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752920AbbIPXBt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 19:01:49 -0400
Received: by igxx6 with SMTP id x6so2575106igx.1
        for <git@vger.kernel.org>; Wed, 16 Sep 2015 16:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=wB6H9ZkKOrmP5pjP9kVQtamDmt6z9h4JgTdBHOeqEDw=;
        b=ArI1GlJMGmyWmKFERaQqM823sPqOymphLYBEeZmiM/PxeReSYxop/n+LJIWl0XjXbv
         32lgcJT/BluIJoKzcXHcjL8F4C7StNmCP0nmkGlsIFk/gcznU3aZ1mO36BdGsugOoqDd
         9gfUEQofjvMxKsPT1kZn1Rv8ARCOAL4VJ38IZ7VY4KQA5U/tuoys23bGqmNdgjekPUhn
         WJueKd0wC4ZzukLfWxuPkeObdl09+34yAvDjoZgAmTtGWfC7XBE2rSYVjADtt79T3XJr
         /WxOhpRdRV/5Whr2euLbzpqjZgEqTX8Gqmu8NCeam4N5LEezLbdHVyMcL9fHLWedrFhY
         vrpw==
X-Received: by 10.50.78.161 with SMTP id c1mr20272076igx.35.1442444509126;
 Wed, 16 Sep 2015 16:01:49 -0700 (PDT)
Received: by 10.107.132.155 with HTTP; Wed, 16 Sep 2015 16:01:29 -0700 (PDT)
In-Reply-To: <20150916223602.GA4197@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278088>

On Wed, Sep 16, 2015 at 3:36 PM, Mike Hommey <mh@glandium.org> wrote:
> On Wed, Sep 16, 2015 at 03:06:32PM -0700, Jacob Keller wrote:
>> This topic depends on mh/notes-allow-reading-treeish and actually
>> expands what this topic allowed before. Previously, treeishes such as
>> notes@{1} were made allowable, but the ref still had to be found under
>> refs/notes.
>
> I haven't found the time to finish that topic yet, but I haven't
> forgotten it. Sorry about that.
>
> Mike

That's ok. I don't think any of the remaining re-works left for your
patch impact mine..? I haven't really read it, but I know I make use
if NOTES_INIT_WRITABLE is the main reason.

Regards,
Jake
