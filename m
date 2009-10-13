From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [RFC/PATCH] gitweb: linkify author/committer names with search
Date: Tue, 13 Oct 2009 21:41:42 +0200
Message-ID: <cb7bb73a0910131241t7220a3c2q16e99a8fc62dd29a@mail.gmail.com>
References: <1255328340-28449-1-git-send-email-bebarino@gmail.com> 
	<1255429615-4402-1-git-send-email-giuseppe.bilotta@gmail.com> 
	<4AD4C94A.9010909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 13 21:49:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxnMz-0002YX-2y
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 21:49:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbZJMTmk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 15:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760893AbZJMTmk
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 15:42:40 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:63091 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753869AbZJMTmk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 15:42:40 -0400
Received: by fxm27 with SMTP id 27so10623464fxm.17
        for <git@vger.kernel.org>; Tue, 13 Oct 2009 12:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=87ItcPV+TEsnE4T3JD6S1ssY258Ypfc0piTbks5knhM=;
        b=tspNfP2dvh0GBGUjvaqZ4OwTU9rUh7BSwbrpnbMoTCcGfx1N3Sy2wJxv1wwBvGTP5O
         Zrxl4MjwttX+8qigUb39oNV/Dltmyp1qoUG6S0MlihgyFCrFCsEegWTKmHvLfAn3ph/N
         ufqhFPpK3YilBnuBDy5YFQP+gspAhjJ+piyWg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=STgQp8i/2EFttL3MHHYIykhHYVY8MFQsXP2KwtRYW7pnqyTzfcGMAT+7lMKPhC3QNf
         j/hE6Rp4p3J1VNX+iUbcPvRwrKhOJK+ZwpzclvITn3H7jtjOivuelo5rJnQ3fpPMcjY7
         T9kHM2UVXbt5EWWEk6jXk/6xXN+kLPAvpM6FY=
Received: by 10.204.151.209 with SMTP id d17mr6567201bkw.120.1255462922186; 
	Tue, 13 Oct 2009 12:42:02 -0700 (PDT)
In-Reply-To: <4AD4C94A.9010909@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130193>

On Tue, Oct 13, 2009 at 8:39 PM, Stephen Boyd <bebarino@gmail.com> wrote:
> Giuseppe Bilotta wrote:
>> On Monday 12 October 2009 08:19, Stephen Boyd wrote:
>>> The problem is I can't get it to work with UTF-8 characters. I'm not sure
>>> if it's my system or not, so I'm just posting here to see if others
>>> experience the same problem and if there's interest.
>>
>> Does it work if you use CGI::escape() on the author names when filling
>> the searchtext?
>
> This doesn't seem to work. Now I get %25 in front of the escaped
> characters. For example, a space is now %25%20.
>
> Can you reproduce my problem locally?

Reproduced, debugged, patch incoming (the problem is not in your patch
but in esc_param).


-- 
Giuseppe "Oblomov" Bilotta
