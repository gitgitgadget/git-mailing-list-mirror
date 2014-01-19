From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH v2] safe_create_leading_directories(): on Windows, \ can
 separate path components
Date: Sun, 19 Jan 2014 21:26:38 +0100
Message-ID: <CAHGBnuMmutYqwZNw+VoZi=R_LaS_fowZrqaU2+JMYN53q6XQ2Q@mail.gmail.com>
References: <1390088444-11439-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Jan 19 21:27:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4yxV-0005t4-1u
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jan 2014 21:27:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751959AbaASU0k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jan 2014 15:26:40 -0500
Received: from mail-qc0-f181.google.com ([209.85.216.181]:33272 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751909AbaASU0j (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jan 2014 15:26:39 -0500
Received: by mail-qc0-f181.google.com with SMTP id e9so5393833qcy.12
        for <git@vger.kernel.org>; Sun, 19 Jan 2014 12:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=KPrLirTTQpChZvhgbuyoSmZFsKdgKyJy485O34qZ0U0=;
        b=ikiNA+IHIHIcL1U9dKXULJW/oJSYWxC11hm14mi+go8LE+WJXV7lo3dqxq3qy0Qlq7
         SB6C/DlfqwIbAbJsU8cdeS8RlM9P1MBznX2bOSBfcn+WXPiv78pXn6BrHb1z3qntcaKk
         Pe7dN3iMJt/Diq3gqYfvcAqvcxC6AD2p6WXczyfjm9KDGeYnbk4nWk3kDRUqFy4BGkNI
         xthQKGhv8iFZWyHl8RHZVlGQ1I1EN0ZynOujTuuPGHIdgJdN4kiQRUrWGNuAcroTFecy
         4SzhstnINjbX5OrQOT3WhQPfUqqlgLqZqT2WbwPxH72nNB+4SqiVWSM4+VSoFB8cH82J
         jpuA==
X-Received: by 10.224.88.3 with SMTP id y3mr22614535qal.80.1390163198517; Sun,
 19 Jan 2014 12:26:38 -0800 (PST)
Received: by 10.96.22.229 with HTTP; Sun, 19 Jan 2014 12:26:38 -0800 (PST)
In-Reply-To: <1390088444-11439-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240700>

On Sun, Jan 19, 2014 at 12:40 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:

> This patch applies on top of v3 of mh/safe-create-leading-directories.
>
> The only logical change from Sebastian's patch is that this version
> restores the original slash character rather than always restoring it
> to '/' (as suggested by Junio).

Thanks Michael. This is very similar to Junio's current merge conflict
resultion in pu between your original series and my patch (c2fec83). I
like this patch of yours slightly better, however, as it uses a
"while" instead of a "for" loop and the more conclusive
"slash_character" than the "was_slash" variable name.

-- 
Sebastian Schuberth
