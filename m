From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: receive.denyNonNonFastForwards not denying force update
Date: Tue, 21 Aug 2012 06:22:36 +0530
Message-ID: <CAMK1S_hMTGhiKDow3x-UZ7eNnTtpLd2=QUf6-YoQF1-O1ywi2w@mail.gmail.com>
References: <CAHgXSop42qWcAEGn6=og8Pistv_Jrwhgcnv3B_ORVtSMi1fCHA@mail.gmail.com>
	<CAHgXSooFj2PJtcOWqsVNHUzMBQnH0cYzPjfs1CkzVuufwRVrog@mail.gmail.com>
	<7vzk5pjxy3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Arthorne <arthorne.eclipse@gmail.com>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 02:52:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3ci4-0005Us-Kx
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 02:52:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754161Ab2HUAwk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 20:52:40 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:42819 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754143Ab2HUAwi (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Aug 2012 20:52:38 -0400
Received: by lagy9 with SMTP id y9so3615001lag.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 17:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=R0hihPA4MCA0NadqfYlG+uVTj8J6B6iPUZ0eVNH1/8Q=;
        b=RiOXaZXX0bRGd7/1jPGHQJ3GnL3AkhI181RdRMQUNrENMQzf3JK3KDrLiSzSt4zKjP
         7FLxvxpyFhb8oe5kds4RCDJ52MntBjLt41dPEMWr3BI35PCcvN8cULrms0cQcCn131mQ
         Hk/RxTPDKFJpyE19LxIqakDSa1ZoM6qqK/aEjHzjh1w75vGbMF3dXYl2VGCyoiIUw45i
         sANnwuCL5AZ/iD1jl9/3VBzulYLBn1WcMiI1L51j9xQaxbOiocTAUg6uLL4bYtWScxzB
         8azRzCXooG3qu6ISy5hVxQJ6I0qQOyX05LNKjUg7Ksv1VGbEFovfBqCUVesQ/IDukFd6
         Sf0Q==
Received: by 10.152.125.116 with SMTP id mp20mr15588793lab.19.1345510356980;
 Mon, 20 Aug 2012 17:52:36 -0700 (PDT)
Received: by 10.112.32.4 with HTTP; Mon, 20 Aug 2012 17:52:36 -0700 (PDT)
In-Reply-To: <7vzk5pjxy3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203911>

On Mon, Aug 20, 2012 at 10:35 PM, Junio C Hamano <gitster@pobox.com> wrote:
> John Arthorne <arthorne.eclipse@gmail.com> writes:
>
>> For all the details see this bugzilla, particularly comment #59 where we
>> finally narrowed this down:
>>
>> https://bugs.eclipse.org/bugs/show_bug.cgi?id=343150
>
> What does "at the system level" in your "does *not* work at the
> system level." exactly mean?

"git config --system receive.denynonfastforwards true" is not honored.
 At all.  (And I checked there was nothing overriding it).

"--global" does work (is honored).

Tested on 1.7.11
