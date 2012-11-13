From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH nd/wildmatch] Correct Git's version of isprint and isspace
Date: Tue, 13 Nov 2012 11:40:58 -0800
Message-ID: <CA+55aFwsjpOop=4mVkx4e=zw5LH41sD9x-b_WMo4Hvo7ygjEtQ@mail.gmail.com>
References: <507E9FDE.7080706@cs.tu-berlin.de> <1352803572-14547-1-git-send-email-pclouds@gmail.com>
 <50A29C3A.1070000@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, schnhrr@cs.tu-berlin.de
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Nov 13 20:41:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYMMZ-0002Y1-EN
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 20:41:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754585Ab2KMTlW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Nov 2012 14:41:22 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:40151 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754303Ab2KMTlV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Nov 2012 14:41:21 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so601058obb.19
        for <git@vger.kernel.org>; Tue, 13 Nov 2012 11:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=zfoLKvTa7sKOZ/xATrqfeyC7CnYUgJJ7cPIsD9bNUP4=;
        b=oAD7vetBzkeBIyLJ4hIoTv54HY20u2CV5aXIjqfCqK5BD2vVlknAlQR/UCsVKARWQV
         MufdhA8f11vDDVboOV34KJaIyR/r/5IxiNzlqrG2UhTXVp7uUQmwbk+SIlawhxL93/mk
         i5h4u8Z/00yOBWj0BKfGatmnj/oGxP4h5Q6HqJPdtQVm2/wSjKhO97LHudRDqBgEbRVp
         5iJwlYcn5cg2vfUUyPutJHrjFbNoNKfAycqrqBuH+dtIdjntapJTxopXDoh6A2e3Ap7z
         lufTMD3ZEPg42rGwF65sJtRGdnkdyyb1W9jJ+zllrGNIKiMj9JwD+5eq3D0erZK+DJIP
         ah6Q==
Received: by 10.60.29.34 with SMTP id g2mr3679871oeh.112.1352835679472; Tue,
 13 Nov 2012 11:41:19 -0800 (PST)
Received: by 10.76.2.242 with HTTP; Tue, 13 Nov 2012 11:40:58 -0800 (PST)
In-Reply-To: <50A29C3A.1070000@lsrfire.ath.cx>
X-Google-Sender-Auth: v0m33xKAbrQTTdvs2AphyAgRYO8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209662>

On Tue, Nov 13, 2012 at 11:15 AM, Ren=E9 Scharfe
<rene.scharfe@lsrfire.ath.cx> wrote:
>
> Linus, do you remember if you left them out on purpose?

Umm, no.

I have to wonder why you care? As far as I'm concerned, the only valid
space is space, TAB and CR/LF.

Anything else is *noise*, not space. What's the reason for even caring?

                  Linus
