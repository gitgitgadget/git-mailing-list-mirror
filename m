From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/3] Refactor useful notes functions into notes-utils.[ch]
Date: Wed, 12 Jun 2013 15:11:59 -0500
Message-ID: <CAMP44s3jnyds45UGfbig1=evbqP-rztcn7GTZ8puVa2zzA7HGg@mail.gmail.com>
References: <7vehc8a05n.fsf@alter.siamese.dyndns.org>
	<1370995981-1553-1-git-send-email-johan@herland.net>
	<7vzjuv14ir.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	jrnieder@gmail.com, pclouds@gmail.com, artagnon@gmail.com,
	john@keeping.me.uk, vfr@lyx.org, peff@peff.net,
	torvalds@linux-foundation.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 12 22:12:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmrOo-0004CR-RL
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 22:12:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753764Ab3FLUMB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Jun 2013 16:12:01 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:50343 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999Ab3FLUMA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jun 2013 16:12:00 -0400
Received: by mail-la0-f43.google.com with SMTP id gw10so8235752lab.2
        for <git@vger.kernel.org>; Wed, 12 Jun 2013 13:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=AkQgHQr0Wtiy++s2HGxrbC36k3A7GNvLymuM9W+wSy0=;
        b=icqgM2VEV4lOltpjyhSfEw/8dmMrB7BvriYxDfpea0Kq9RQsqAw+nBWLfuSxjMYmkg
         +P4rJv1ELuXZkJRJFaOOOR4kyB/H/QqOc4HCBBzVwpGKIN/WtMppX/16JKFeS2BzRjOy
         MdLSHxBDUKG0GCI9+54/t9E2xElN5SFmQdDAf1q6u2CR8fhXHFws6v6eXGnq/ZdFv70R
         PWziynNyS5F5nQLc23OmltEfLcD1yrmq08gaIY7cf6IfOG5sMjYy6g0OpSD4zb0629EO
         aMR0/gUEwl/LOFOASRTsJJQ9agQ0Ev6OHVPRoFXBh9nRINmwQygAqGfZSmHEHuwRa9uc
         x6mQ==
X-Received: by 10.112.166.67 with SMTP id ze3mr11765135lbb.25.1371067919360;
 Wed, 12 Jun 2013 13:11:59 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Wed, 12 Jun 2013 13:11:59 -0700 (PDT)
In-Reply-To: <7vzjuv14ir.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227674>

On Wed, Jun 12, 2013 at 3:02 PM, Junio C Hamano <gitster@pobox.com> wrote:

>> ... Alas, this
>> simple solution reject on the basis that we shouldn't organize the
>> code, because the code is not meant to be organized.
>
> The proposed patch was rejected on the basis that it was organized
> the code in a wrong way.  And your patch shows how it should be
> done.

In your opinion.

The fact that nobody outside of 'git' will ever use
init_copy_notes_for_rewrite() still remains. Therefore this
"organization" is wrong.

-- 
Felipe Contreras
