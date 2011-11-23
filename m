From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] run-command.c: Accept EACCES as command not found
Date: Wed, 23 Nov 2011 19:04:58 +0700
Message-ID: <CACsJy8ATJ33i5YaM-APtUPq_fDkj9=JpKj9pmvqWK2QodgbexQ@mail.gmail.com>
References: <1321912387-4569-1-git-send-email-fransklaver@gmail.com>
 <7vbos5f7ix.fsf@alter.siamese.dyndns.org> <op.v5bjtk1r0aolir@keputer>
 <7v62idf2vy.fsf@alter.siamese.dyndns.org> <CAH6sp9MxbDhQ3RiA6jO1fswAZX3R6C2fv0gzJdpGp432ovWsjQ@mail.gmail.com>
 <CAH6sp9N2ycsoU=is3BVanH33CowD+sMNmWq=Z1MsPJX=HGYY+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Frans Klaver <fransklaver@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 23 13:05:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTBa5-0004bR-UV
	for gcvg-git-2@lo.gmane.org; Wed, 23 Nov 2011 13:05:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754214Ab1KWMFb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Nov 2011 07:05:31 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:47607 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753242Ab1KWMFa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2011 07:05:30 -0500
Received: by bke11 with SMTP id 11so1499538bke.19
        for <git@vger.kernel.org>; Wed, 23 Nov 2011 04:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=nWDBHJ3hr/5DqI3VX3zxRBIVRq26WPtrRtBShXp35lk=;
        b=jhtbMx9+crMPviyHKox1k/lpBKLY5cnGM9DBsSRnF3eBtE9+ulNAoGHW1Y3+Q/0E8s
         Jyq3EA/phFDKn8NXr83jDjY/arhJHXic0TCNCO2gdRpRwgGfDJNniMy2Zg0FeiiDd6E+
         i8L3JMEPh1/woRPpxcXczJmVHlAwowKVxU9kA=
Received: by 10.204.154.77 with SMTP id n13mr24222677bkw.83.1322049929161;
 Wed, 23 Nov 2011 04:05:29 -0800 (PST)
Received: by 10.204.23.2 with HTTP; Wed, 23 Nov 2011 04:04:58 -0800 (PST)
In-Reply-To: <CAH6sp9N2ycsoU=is3BVanH33CowD+sMNmWq=Z1MsPJX=HGYY+g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185844>

On Wed, Nov 23, 2011 at 3:17 PM, Frans Klaver <fransklaver@gmail.com> wrote:
> If there are no objections, I'm going to cook up a patch that
>
> - Keeps the current behavior (bail on EACCES)
> - Adds a more helpful diagnostic message somewhat like libexplain's,
> but more terse and if possible with slightly more domain knowledge

If you print diagnostic messages with trace_printf() and friends (only
showed when GIT_TRACE variable is set), then there's no need for being
terse.
-- 
Duy
