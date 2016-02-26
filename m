From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 01/16] bisect: write about `bisect next` in documentation
Date: Fri, 26 Feb 2016 00:02:06 -0800
Message-ID: <CA+P7+xqRFvzvD3dX+WM9vuJ1mmSdMeoQQTat+4be0gfsLXfSJw@mail.gmail.com>
References: <1456452282-10325-1-git-send-email-s-beyer@gmx.net> <1456452282-10325-2-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Fri Feb 26 09:02:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZDM6-0004QF-SD
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 09:02:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753577AbcBZIC1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 03:02:27 -0500
Received: from mail-ig0-f172.google.com ([209.85.213.172]:36573 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753235AbcBZIC0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 03:02:26 -0500
Received: by mail-ig0-f172.google.com with SMTP id xg9so29970170igb.1
        for <git@vger.kernel.org>; Fri, 26 Feb 2016 00:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OxB0ngNpxdu7mxjQnC7n6RSvp0SdSN2GpO/O3qoDXd0=;
        b=hBj9UUNddT4GDwG44T+82/+ob5nXSiAaUX9/z6mVis9XRefgwZliOTcL9vlWtL/hi4
         AGDNKEM9sbHhjQlOmw7BKtPH5Bpu0wsajNnV4HW4FfERcXKLRr1ikiL7s7ojaDM5vVvt
         m7/hwm60DkIrYbYCwMwvwWBVUi2YW0INIl50lRMPAXh7TQtpxVwvmKhmrwprHgE1lAsJ
         1YjWpZZzbLIRs6uan7aCfwvpjgIVZd7MonqU/4dj1jYjQv+JNt7G6atrK5KQG7eCzbWT
         GNcNqRyWn20BPRw5jX+MmkUQhrjiFiDo0Y6P7/e60WASpO53sPL/IJ4mEShG9nmu7gD/
         PEvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OxB0ngNpxdu7mxjQnC7n6RSvp0SdSN2GpO/O3qoDXd0=;
        b=ijynPr6xhKhd33rAiREDiZE9o4DJmLiqHoL6M01cxHsmRGjQCM10xyn8Z8sk26HhJT
         MwDih2mpmI+nDXKJHY6Z0f+78Ff7PwntaL45MZFcfPuHe+NrNGFwDvs++kwsToZ8gcp+
         nUGQwJ61EpNGqdr5c5sdh0y8VmChQQIi5cG/k7DcCQrIyeBP7Lwo0oWZwII6Lhe8kw0H
         B5W2fCT2/kD5jLzxfNm00X1Yilgo1HE3Npnf4vnmmwiKt9jDwF1NzJ0G+yuC9awWnsOl
         E57JxClzrKqcml4fgKiyVJR2wvoozjN1nMW3az1TCvAMnAWcsZ+Gr4rzzUOxgjxM8IAM
         LidA==
X-Gm-Message-State: AD7BkJIsnyAi32zUZyNHDVAAzdH6RsPeA+PR5NIfW3IjzNOZwqOqSpphROQAwSzpsgIvl3cFTlppVxUxEmGwMw==
X-Received: by 10.50.108.112 with SMTP id hj16mr1559090igb.35.1456473746079;
 Fri, 26 Feb 2016 00:02:26 -0800 (PST)
Received: by 10.107.20.76 with HTTP; Fri, 26 Feb 2016 00:02:06 -0800 (PST)
In-Reply-To: <1456452282-10325-2-git-send-email-s-beyer@gmx.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287547>

On Thu, Feb 25, 2016 at 6:04 PM, Stephan Beyer <s-beyer@gmx.net> wrote:
> This patch considers the source code comment that says to be
> "not sure we want 'next' at the UI level anymore", and replies with
> "Yes, we want it!". Therefore, the "git bisect next" functionality
> is explicitly motivated and documented.
>

I did not know about this, but I definitely would have found it useful
in the past.

Thanks,
Jake
