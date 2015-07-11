From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 05/10] ref-filter: add option to match literal pattern
Date: Sat, 11 Jul 2015 11:25:44 +0530
Message-ID: <CAOLa=ZT+59dcCW+QHhvK8Wp5Q_1YhkfCxV0=PirOWtVKWFCvCw@mail.gmail.com>
References: <CAOLa=ZQyHwza6L9r6iFX1GkVrC+F-XNwegO=bGyxafjY3JoYpw@mail.gmail.com>
 <1436437671-25600-1-git-send-email-karthik.188@gmail.com> <1436437671-25600-5-git-send-email-karthik.188@gmail.com>
 <xmqqfv4wklph.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 11 08:22:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDoB5-0007Hn-8F
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jul 2015 08:22:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752552AbbGKGWT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jul 2015 02:22:19 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:34773 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752327AbbGKGWT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jul 2015 02:22:19 -0400
Received: by obbkm3 with SMTP id km3so203109683obb.1
        for <git@vger.kernel.org>; Fri, 10 Jul 2015 23:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Dtfwvz1iB5NjTl4uYxBeVDXHK2OK3jYuTXDNV+/Bv4Y=;
        b=npjTDNtJGqKDPMRMQ16USAW9Wq4SmaOF2mVjAkf/t2TDuMbBxm7UHOZr/Q38825Ev2
         nTWUyKudqJKAKCrDt21V3KLfh2FdBlt3tqnOqWHrkA1nlYpt30cCoSDxZWPY/lAsSHpY
         Eg+0TihNwkwyAYJnrh+BQ1xOTxSOczdNqgFUD8FrxJK4EiUSg09kvjTBWbCmk+ElsPyV
         9fI43/D+bXKe5SNpSsUjEXyCkPfjL96gRt83m5Ts7PzlBp8eYr6Ik2VsXcp9tK/y2wrU
         Y5oE1oAZj3TDMu6kAgen1PCwpMbiUhLnpqCCkdJ6s3DM85iAkz08tkdlk7iRod02hdt+
         aWEQ==
X-Received: by 10.60.58.136 with SMTP id r8mr22013278oeq.30.1436594174137;
 Fri, 10 Jul 2015 22:56:14 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Fri, 10 Jul 2015 22:55:44 -0700 (PDT)
In-Reply-To: <xmqqfv4wklph.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273844>

On Fri, Jul 10, 2015 at 10:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Since 'ref-filter' only has an option to match path names
>> add an option for regular pattern matching.
>
> There is nothing "regular" about the pattern matching you are
> adding.
>
> Everywhere else we use patterns on refs we call wildmatch(), which
> is an enhanced implementation of fnmatch(3), and you are doing the
> same in this new codepath.
>
> Just drop that word from here (and if you said something similar in
> the documentation, drop "regular" ffrom there as well).  It would
> invite confusion with regular expression matching, which we will not
> do for refs.

Ok, will do. Thanks

-- 
Regards,
Karthik Nayak
