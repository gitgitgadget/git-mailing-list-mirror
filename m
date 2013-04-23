From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: Premerging topics
Date: Tue, 23 Apr 2013 17:36:21 +0200
Message-ID: <CALWbr2xosv9pM3yTRvZAhAoR_1DS6fS0jX2ud4=1VeJPSn+5iA@mail.gmail.com>
References: <CALWbr2wocjqs1mpa+yuQ_Zw8m+SX24q6Pby3E3v3-jd-0w1pvQ@mail.gmail.com>
	<CALKQrgfO9fd+EEA=Vwe94tJbxkX89uDmMHm9rj6L=d4x7JJjaQ@mail.gmail.com>
	<7vwqrtl2mk.fsf@alter.siamese.dyndns.org>
	<CALWbr2xAxkNMedbuS-+pPy+Zc5MEhoCWk3oW8BXS9db63DoGAg@mail.gmail.com>
	<7vsj2hjme3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 23 17:36:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUfGe-00060O-JP
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 17:36:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756321Ab3DWPgY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 11:36:24 -0400
Received: from mail-qa0-f54.google.com ([209.85.216.54]:58568 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756027Ab3DWPgX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Apr 2013 11:36:23 -0400
Received: by mail-qa0-f54.google.com with SMTP id j8so197863qah.6
        for <git@vger.kernel.org>; Tue, 23 Apr 2013 08:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=H77/QYV6mD5qrfS0A6mgZDKJBRDXeDFzWopne+X6tGw=;
        b=cnv7WjAuGGhsDtYvJ+3cAkgCTPvo5oWdAifpsSB/DawXoi3u6G9OSrYel9TMi+Etc/
         BpYEl3d/Zy01lDNnSahAaYrtdJ0LUTTLlgDncnXkxiRu93p9rhuLSqtcZC/mtHWZxo7M
         zWbXKkks6876IjWvTkooablORmef82C4YYRCCwaadgl4fab4ylu3vTU5+3QQ2f8e2Bfj
         CQPV14ZuTrtCmxIxKmuWs4nskOXCij3XHGp6GKWvqkcie3pHXhaLN+eDky4YVfzj1ZMg
         iVFT695ZGw+EkYZS9qI9uG4lTvxB7jG5I9tYppEyJWm3F9ALFPoODsedVdX2U5Kq/jWC
         kbeQ==
X-Received: by 10.229.146.69 with SMTP id g5mr8020991qcv.131.1366731381791;
 Tue, 23 Apr 2013 08:36:21 -0700 (PDT)
Received: by 10.49.30.9 with HTTP; Tue, 23 Apr 2013 08:36:21 -0700 (PDT)
In-Reply-To: <7vsj2hjme3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222182>

On Tue, Apr 23, 2013 at 5:29 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Antoine Pelisse <apelisse@gmail.com> writes:
>
>> And I
>> have the feeling that "merge-fix/B" or "merge-fix/A" doesn't hold
>> enough information to do that accurately.
>
> Oh, you do not have to resort to feeling; these names do _not_ hold
> enough information, period.  We already know that, that was why I was
> unhappy, and that was why I sent the "annotating a pair of commit
> objects" RFD in the first place ;-).

:)

>> The idea is then to store the <A, B> pair as a note, and to associate
>> a "merge" to that (solving the semantic conflict).
>
> OK, and as the datastore for <A, B> pair you were thinking about
> using a specially-formatted blob and Johan suggested to use a
> regular tree object?

Exactly. But as I said, it should associate the pair to a merge. And
trees contain other trees or blobs, not commits. I'm wondering if this
is a problem.
