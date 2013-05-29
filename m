From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH v2 4/8] rebase: cherry-pick: fix abort of cherry mode
Date: Wed, 29 May 2013 00:47:36 -0500
Message-ID: <CAMP44s1RWNVLWGFAR=MCdYF-uz4XS6-op9pY8Dc-DWXXva-17w@mail.gmail.com>
References: <1369801000-3705-1-git-send-email-felipe.contreras@gmail.com>
	<1369801000-3705-5-git-send-email-felipe.contreras@gmail.com>
	<CANiSa6g10XQJMCrvu1U-YG8OpZXOLA1A_fTYoPh=RHoBkHu2Mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 07:47:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhZEc-0001Jt-Al
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 07:47:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754419Ab3E2Fri (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 01:47:38 -0400
Received: from mail-we0-f173.google.com ([74.125.82.173]:34618 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753077Ab3E2Frh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 01:47:37 -0400
Received: by mail-we0-f173.google.com with SMTP id p57so6025171wes.32
        for <git@vger.kernel.org>; Tue, 28 May 2013 22:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=6S5bRTZXEDbvDiPZ7HAJHAiTHSxOKQR7JIiDlMIGzwY=;
        b=DgGb3LP8HSrWZm09QmmKcCHXKeo7MJgv9tl6ueuxUzmEasXOXZp/ACKFmbA1+OozGN
         3qOe4oAplZSSajPURF22ARqA9egxjiY0QFRlhsgOun3vPnTFos95Li7hrRS5yCLlwTXv
         hKYjqIz6TngSrmsRWhiM91ryJgSX750+2RD0XzbvSmhem+3gL0B7UpEbDrC3ZZubfAnW
         8x+vvlQA8j8SDZLI+bgp4ApIFN4VjNM/DWaPqv8mWUJ6RZy2Hi4JvlAvgkxMLFLob0sh
         A2qGSFv3hcw4S2CSFqKaWbUnNDY/Q6QIwLH9HKDrVzSx1qY9rZ1jQTuDL86n9/xqmIrw
         gPfg==
X-Received: by 10.194.216.136 with SMTP id oq8mr905001wjc.8.1369806456635;
 Tue, 28 May 2013 22:47:36 -0700 (PDT)
Received: by 10.194.47.4 with HTTP; Tue, 28 May 2013 22:47:36 -0700 (PDT)
In-Reply-To: <CANiSa6g10XQJMCrvu1U-YG8OpZXOLA1A_fTYoPh=RHoBkHu2Mw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225744>

On Wed, May 29, 2013 at 12:35 AM, Martin von Zweigbergk
<martinvonz@gmail.com> wrote:
> Same here: should this have been in the first patch? If not, do you
> know for how long it has been broken (since which commit)?

Since day 1 of --keep-empty:

90e1818 git-rebase: add keep_empty flag

-- 
Felipe Contreras
