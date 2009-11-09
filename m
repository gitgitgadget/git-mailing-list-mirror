From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v3 08/12] Allow helper to map private ref names into 
	normal names
Date: Mon, 9 Nov 2009 18:10:31 +0100
Message-ID: <fabb9a1e0911090910g4745325l842cdb91e4d9485c@mail.gmail.com>
References: <1257547966-14603-1-git-send-email-srabbelier@gmail.com> 
	<1257547966-14603-5-git-send-email-srabbelier@gmail.com> <1257547966-14603-6-git-send-email-srabbelier@gmail.com> 
	<1257547966-14603-7-git-send-email-srabbelier@gmail.com> <1257547966-14603-8-git-send-email-srabbelier@gmail.com> 
	<1257547966-14603-9-git-send-email-srabbelier@gmail.com> <alpine.LNX.2.00.0911061755360.14365@iabervon.org> 
	<fabb9a1e0911061519j6d64ff50v9b0cefe61965fbbc@mail.gmail.com> 
	<fabb9a1e0911082242k5950d780i584a4714e384e007@mail.gmail.com> 
	<7vhbt3y7fb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 18:11:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7Xm7-0002NN-Av
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 18:11:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755513AbZKIRKr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2009 12:10:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755327AbZKIRKr
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 12:10:47 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:63789 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755222AbZKIRKq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2009 12:10:46 -0500
Received: by ey-out-2122.google.com with SMTP id 4so925eyf.19
        for <git@vger.kernel.org>; Mon, 09 Nov 2009 09:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=++VAwpLInslj2lN7sCMsJQAEL85DnZaG1Z3FGFzjRyo=;
        b=hDH0Cys2zDwKxqT/Qgd950o41Tq7Raff0IM2eCe5Ny7QEYDaoNzYslCYSE3+kDikR7
         F7YJOQW6UQw0aaHbf3KH9ByIoo6I7HsXqRSfIRckmVrsv7qhos9IU9xkupur7zPthusa
         rGUWK+gsqj0OcIXBI8idS4zm1V4SHm4YqpQfg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=Ma/tELpbe9A2sGfzroaCEUDKpIhNXXs6Jmx3tmDwz29jU4sTcLTj5syovYoC316jZl
         hW01ZmyTf9BjDgq8PqDfWtMlHNJvJDR+YkCqK91RQ4dh4QXFTOtT/aOKNZTHtR7j7JUt
         JgpBWxgSg7a9mfSeSbdoqOPzo7/iBRE8uhHCs=
Received: by 10.216.87.209 with SMTP id y59mr2558284wee.21.1257786651103; Mon, 
	09 Nov 2009 09:10:51 -0800 (PST)
In-Reply-To: <7vhbt3y7fb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132497>

Heya,

On Mon, Nov 9, 2009 at 17:44, Junio C Hamano <gitster@pobox.com> wrote:
> Sverre Rabbelier <srabbelier@gmail.com> writes:
>> It's in next now, so please send follow-ups against sr/vcs-helper.
>
> Do you mean 'pu' or 'next'?

Sorry, my hands did not type what my mind intended, I meant to say
'pu', apologies!

-- 
Cheers,

Sverre Rabbelier
