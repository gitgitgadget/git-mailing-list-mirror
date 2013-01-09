From: Adam Spiers <git@adamspiers.org>
Subject: Re: [PATCH] t0008: avoid brace expansion
Date: Wed, 9 Jan 2013 23:56:27 +0000
Message-ID: <CAOkDyE_EuuV04KxkkLuHMV+VbDWsDMN1q3YShLtKaimaXH40Sg@mail.gmail.com>
References: <50EC8025.8000707@lsrfire.ath.cx>
	<7vr4lvcstt.fsf@alter.siamese.dyndns.org>
	<50EC8BE7.2010508@lsrfire.ath.cx>
	<7vboczcq5a.fsf@alter.siamese.dyndns.org>
	<50EE01F8.1070109@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	git discussion list <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu Jan 10 00:56:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tt5Vq-0000mo-FC
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jan 2013 00:56:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758182Ab3AIX43 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jan 2013 18:56:29 -0500
Received: from mail-we0-f177.google.com ([74.125.82.177]:50770 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758148Ab3AIX42 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Jan 2013 18:56:28 -0500
Received: by mail-we0-f177.google.com with SMTP id x48so1336221wey.36
        for <git@vger.kernel.org>; Wed, 09 Jan 2013 15:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ehIOygHEQL16CdPY4kXYrIm+B5nDUNGbpI8SoAgWzzE=;
        b=zDdAXPA/SotUFhFXy9CaHLjndFIhtUstm3RrWYwYPt1Iq+Hb0YzW0itisCrmrDf+5x
         2hOldtaZoYQIZDB8xIsvIdmVKj4O4oOyVH/0jN7rXiS0nUa6vzRPTDW3S4k83/FnXRL2
         w6nlasexAf6h5f8/4vtfg1UMvhGOLpe+xcehHW3HiMoOm+dvhqkIgl8s4+ukVvPD6YCo
         IyJEzU0tBn484TrGnCXbkHO/iqYjrTTrbXWjdHVYrgZh/WgZcSYmwEOnT0dedtk0D+Mf
         UBQMkYyooC8TClZHrPOYo4sNkR3T5IiTHEziTwma+j5rRU5l+qEjEtPEI9JJd741SUMf
         uisA==
Received: by 10.194.88.98 with SMTP id bf2mr111548127wjb.49.1357775787552;
 Wed, 09 Jan 2013 15:56:27 -0800 (PST)
Received: by 10.194.84.97 with HTTP; Wed, 9 Jan 2013 15:56:27 -0800 (PST)
In-Reply-To: <50EE01F8.1070109@lsrfire.ath.cx>
X-Google-Sender-Auth: yrQWfgnomF-9uBqzuEUkLQgb4pc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213112>

On Wed, Jan 9, 2013 at 11:49 PM, Ren=E9 Scharfe
<rene.scharfe@lsrfire.ath.cx> wrote:
> Brace expansion is not required by POSIX and not supported by dash no=
r
> NetBSD's sh.  Explicitly list all combinations instead.

Good catch, thanks!
