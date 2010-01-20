From: Jamie Wellnitz <jwellnitz@gmail.com>
Subject: Re: git equivalent to clearcase wink-in
Date: Wed, 20 Jan 2010 16:05:46 -0500
Message-ID: <7938b46a1001201305j499e05bg2654d634d7b26d76@mail.gmail.com>
References: <810256.84037.qm@web45111.mail.sp1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Richard Assal <richard_assal@yahoo.com>
X-From: git-owner@vger.kernel.org Wed Jan 20 22:06:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXhkV-0008Dt-I2
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 22:05:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754086Ab0ATVFz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Jan 2010 16:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754180Ab0ATVFz
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 16:05:55 -0500
Received: from mail-ew0-f209.google.com ([209.85.219.209]:41678 "EHLO
	mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754078Ab0ATVFy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jan 2010 16:05:54 -0500
Received: by ewy1 with SMTP id 1so3489275ewy.28
        for <git@vger.kernel.org>; Wed, 20 Jan 2010 13:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xuQiahlPcrLWtsY0akSGw5yP+bWGON1eES0IH2B/9mg=;
        b=qGvIYwFUbUI6P/0ArpoKQboUM3ZhfFg2rtiyPK4YJ9k0wbB4VXJ4GREv83aYdjkcG8
         epqARH4X/0kbWRna5aoBMLoiNeIcfU1UP2cVq263ios9Xkf1E8RhcO87lOBprKY1WjqM
         te8o2SLXqZz8NHyLC1SoblYjha8LB2zyKh5T8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XxEyZmnPbd9DE30Sj1xWLoraf4xIoGLc2C1zWUytSMm5caurkFGbtrtOEz3hpv6CAv
         yKUiZQ7TGIJPzH+StJcSVZS0OtKzMh7r/uhwJJb970ABSyTZXyDovfiRdoS79CKZCViA
         i6E/GRzz98qSVoFmQyu++ASI7mFaL3NGCV1PI=
Received: by 10.216.87.197 with SMTP id y47mr190129wee.202.1264021546776; Wed, 
	20 Jan 2010 13:05:46 -0800 (PST)
In-Reply-To: <810256.84037.qm@web45111.mail.sp1.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137581>

Would something like ccache (compiler cache) help you out?  It's not
the same as wink-in (which, as I understand it, copies an already
built object file from someone else who has built it).  Instead each
user has their own cache, so everyone has to pay the expensive build
price at least once.

It also only works for C/C++, I think.

-- Jamie

On Wed, Jan 20, 2010 at 3:20 PM, Richard Assal <richard_assal@yahoo.com=
> wrote:
> To whom it may concer,
>
> I have been playing with git recently, and I like it very much.=A0 I =
was wondering if you can tell me if git has something that is equivalen=
t to clearcase wink-in functionality.=A0 The reason I ask, if it takes =
1 hour to build my repository, then every=A0clone of my repository will=
 also take one hour to build at the remote location.=A0 In clearcase yo=
u can wink in objects that have already been built.=A0 time to wink in =
could just be minutes rather than waiting a full hour for all the binar=
ies to build.
>
> Can you help me out here?=A0 I would like to know if git has somethin=
g similar.
>
> Richard.
>
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
