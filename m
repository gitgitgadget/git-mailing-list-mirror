From: Paul Campbell <pcampbell@kemitix.net>
Subject: Re: [PATCH 1/4] contrib/subtree: Store subtree sources in .gitsubtree
 and use for push/pull
Date: Mon, 18 Feb 2013 20:50:22 +0000
Message-ID: <CALeLG_mfYwVow-A=10kXKHWn7HO311yy5smRcFY6Gx5W3qNDdg@mail.gmail.com>
References: <CALeLG_kuXdF_F4ScRLPLm5h5cV_9p=EZYrWdjoWBrO99WFyi2Q@mail.gmail.com>
	<87bobh4bmz.fsf@waller.obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: greened@obbligato.org
X-From: git-owner@vger.kernel.org Mon Feb 18 21:50:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7Xfk-0001jy-BL
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 21:50:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753499Ab3BRUuX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 15:50:23 -0500
Received: from mail-oa0-f48.google.com ([209.85.219.48]:50578 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752836Ab3BRUuX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 15:50:23 -0500
Received: by mail-oa0-f48.google.com with SMTP id j1so6227396oag.21
        for <git@vger.kernel.org>; Mon, 18 Feb 2013 12:50:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:x-originating-ip:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type:x-gm-message-state;
        bh=aTQmtFXAfcrj9rrhpHH1sGvvSDCV3Oad3XitvX2wqbA=;
        b=n9nrYrOlMevT/HHRCDSE5psdYXRArHh1EdVJ+Q0X0McKeMFshe9adh29ITWsmlCm3Z
         vd/OvrK41WMl/XsqcCh8Kx6YB755KuasiKyRPoDQfSZ1w4B/2KSXNYf8v8w4R8HCue/Z
         EbOCxj7KuCIg946+Bgt1CXry+4yBwJgqpbANuGRqGtu4uavgSXWxUH11yHvzBv1mZkS+
         HmxfTz+TEHJizRwYHtN9U9JZ6P6MkYFXPnmKtUbgOlo0RSVTKpePQVMaSQCssnQjsVZQ
         8Gu1mAbgZCPDxA4WN/javLSpwK53J/8sS4Ujb9CE9Zgr6/yLul+bA8zOhlXByKIq8RF3
         9ShQ==
X-Received: by 10.60.30.4 with SMTP id o4mr567008oeh.57.1361220622604; Mon, 18
 Feb 2013 12:50:22 -0800 (PST)
Received: by 10.76.143.67 with HTTP; Mon, 18 Feb 2013 12:50:22 -0800 (PST)
X-Originating-IP: [2.102.85.14]
In-Reply-To: <87bobh4bmz.fsf@waller.obbligato.org>
X-Gm-Message-State: ALoCoQnaf0OTJH2JTa9cGSxfl14dAwzoaatn6gFfJvwpaasyKvy6sgJjSV+7JQm2QWdPLR1D72SK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216518>

On Mon, Feb 18, 2013 at 8:20 PM,  <greened@obbligato.org> wrote:
> Paul Campbell <pcampbell@kemitix.net> writes:
>
>> Subsequent git subtree push/pull operations now default to the values
>> stored in .gitsubtree, unless overridden from the command line.
>>
>> The .gitsubtree file should be tracked as part of the repo as it
>> describes where parts of the tree came from and can be used to update
>> to/from that source.
>
> I agree with the basic idea but have some questions about the
> implementation.
>
> Is there precedent of git commands storing information in hidden files
> and requiring those files to be added to the repository and tracked?  It
> seems like a bit of a kludge.
>
> Could we use notes or something for this?
>
> I'm not necessarily against the patches, I just want to make sure we
> don't go down a road that won't be acceptable later on.
>
>                            -David

I'm not familiar with git notes. Adding that the my to-read list.

I took my inspiration from git submodules which uses the .gitmodules
file for a similar purpose.

-- 
Paul [W] Campbell
