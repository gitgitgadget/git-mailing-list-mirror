From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 4/7] remote-bzr: update working tree
Date: Thu, 13 Dec 2012 18:52:00 -0600
Message-ID: <CAMP44s2RrPDv=8s8bWUk7oWQ7D_P15E+-ShcFzYCjOP-ik6v6w@mail.gmail.com>
References: <1352643598-8500-1-git-send-email-felipe.contreras@gmail.com>
	<1352643598-8500-5-git-send-email-felipe.contreras@gmail.com>
	<7vtxs9vda3.fsf@alter.siamese.dyndns.org>
	<CAMP44s1ZdMK+0_pP3qkZUepOvkfMaXeY2BV0MFu5YOSV=40Dcw@mail.gmail.com>
	<7vobhxwm3n.fsf@alter.siamese.dyndns.org>
	<7vhanpwllh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 01:52:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjJVl-0001lr-0M
	for gcvg-git-2@plane.gmane.org; Fri, 14 Dec 2012 01:52:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755837Ab2LNAwD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2012 19:52:03 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:62422 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755257Ab2LNAwB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2012 19:52:01 -0500
Received: by mail-ob0-f174.google.com with SMTP id ta14so2750703obb.19
        for <git@vger.kernel.org>; Thu, 13 Dec 2012 16:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=z2ql9vfA0Y1D9VY6k3CSNOX6mjyl76w5MxHyL4txDxU=;
        b=lth5AoXgfQPORoG8UtGjMe8Ot+lolc05UI4YkDSo3LLZ5amWACYh50BKhiQjOyGnFa
         vxcMjxL9UbVNdCRWmN6btAgYUNAFKdpPgGNL8ufkEegXvX3wSisljUdzwIjn1kP6S7ki
         dkqEs3D5MC8L8+3k7b1+ofRi7R3Hrv+JY4/zHiTknsMcwjIVvgkK0QWzJ/US4Jvt0GzO
         Pdze3myjVUPIl2jcfbJ1UFeulsn/WARac8619vC5BTMMRzXHAdTzyapIGwuEK7RaGfic
         pOqdtE1J6nBzCXR/Ace+heaRgZRHdW0LK/pVy40tyO+jCSG8OgQYU3OPuFIk2zJj1eTN
         mIYg==
Received: by 10.60.7.199 with SMTP id l7mr3113138oea.136.1355446321015; Thu,
 13 Dec 2012 16:52:01 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Thu, 13 Dec 2012 16:52:00 -0800 (PST)
In-Reply-To: <7vhanpwllh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211483>

On Thu, Dec 13, 2012 at 5:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>>> Perhaps. It's not really clear if we should update the working tree at
>>> all. A 'git push' doesn't update the working directory on the remote,
>>> but a 'bzr push' does. I thought it was better to leave this
>>> distinction clear, in case this becomes an issue later on.
>> ...
>> ...  I don't mind rephrasing that four lines and amend the
>> log message of what I have in 'pu', if that is what you want.
>
> ... which may look like this.
>
>     remote-bzr: update working tree upon pushing
>
>     A 'git push' doesn't update the working directory on the remote, but
>     a 'bzr push' does.  Teach the remote helper for bzr to update the
>     working tree on the bzr side upon pushing via the "export" command.
>
> Let me know if I grossly misinterpreted/misrepresented what you
> wanted to do in this patch.

Looks good to me.

Cheers.

-- 
Felipe Contreras
