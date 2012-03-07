From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH/RFC] Change t0204-gettext-reencode-sanity.sh to pass under
 Mac OSX
Date: Wed, 7 Mar 2012 22:43:10 +0100
Message-ID: <CACBZZX4q0Da=H=-fO86f2YN+CmE25QfEgAp8Efmdyf65CGckiQ@mail.gmail.com>
References: <201203052039.16893.tboegi@web.de> <7vzkbuzss7.fsf@alter.siamese.dyndns.org>
 <CACBZZX4P=JSdP_vLOMx5r3R+YO8SMSs5W8+vf2DMibKMwBx_Vg@mail.gmail.com> <7vfwdkm6xs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 07 22:43:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5Oe2-0003eA-5U
	for gcvg-git-2@plane.gmane.org; Wed, 07 Mar 2012 22:43:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755718Ab2CGVnc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Mar 2012 16:43:32 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:51456 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752753Ab2CGVnb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2012 16:43:31 -0500
Received: by eaaq12 with SMTP id q12so2402354eaa.19
        for <git@vger.kernel.org>; Wed, 07 Mar 2012 13:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=hssCjcii+1Z5SZBwIvbVX4IjOvd9llqd9+6oAOFMO7A=;
        b=ivrDCnBOh3J5pyOSlGnKNUWWsPSr1ZY3o2VcI7l7l9rHtzMChCVAZSjUTujx9ZuOZW
         dvR3YVF/LGrO8KqXkUVnWhiMGk5M+SUepR+hdoiEX7bwHC0z1hqPQH3/retiY8Y/H+bh
         W4ngSnrK+GuMaxgdSfmoZvZ4eJTAg/W/6ZRFxsk8HB5LzCM48ynMOHbWl5c4TciwLHqT
         gMQdctHOUoXv1I7+ezOHbYhhewpKBszjAjTmb1Tfx7EYHVat0yQk22Y7HaSLzDbEobu8
         MJ9AvrT6rLahIaGJjVP0Cm8bi3xJeOewfCw4EEB80jVVhOVsG5W8H073s5lBeFNGZJ3X
         yADA==
Received: by 10.14.127.76 with SMTP id c52mr1621317eei.37.1331156610457; Wed,
 07 Mar 2012 13:43:30 -0800 (PST)
Received: by 10.213.2.147 with HTTP; Wed, 7 Mar 2012 13:43:10 -0800 (PST)
In-Reply-To: <7vfwdkm6xs.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192487>

On Wed, Mar 7, 2012 at 22:34, Junio C Hamano <gitster@pobox.com> wrote:
>> I think it's important to be pro-active about trying to spot
>> any issues that might affect end users before they happen.
>
> The goal is noble, but asking the platform to perform an impossible
> task and subjectively judging if the failure mode is acceptable is
> not the way to do so, I would have to say.

I leave it up to you whether you want to accept the patch to remove
it, but with it included we at least *know* what the failure modes
are, since we get user reports about it.

That's the reason I put it in there to begin with. Because I have no
idea how all these pieces play together with systems in the wild, and
I'd like to pro-actively find out about that.
