From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 08/10] tag.c: use 'ref-filter' APIs
Date: Fri, 10 Jul 2015 15:11:49 +0530
Message-ID: <CAOLa=ZTonG-TVwxdcmt3rc_5c5Vm+uGgXo_Mc4mNe6n_VKb7KA@mail.gmail.com>
References: <CAOLa=ZQyHwza6L9r6iFX1GkVrC+F-XNwegO=bGyxafjY3JoYpw@mail.gmail.com>
 <1436437671-25600-1-git-send-email-karthik.188@gmail.com> <559E5333.7080901@gmail.com>
 <vpqa8v58pka.fsf@anie.imag.fr> <CAOLa=ZSp-X0Mo5BGWghdk56sM2AEAmnXZt7Y3VkfXWvf8rh96w@mail.gmail.com>
 <vpqvbdt5tv6.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jul 10 11:42:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDUpA-00014C-IJ
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jul 2015 11:42:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753868AbbGJJmY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2015 05:42:24 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:32815 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753861AbbGJJmT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2015 05:42:19 -0400
Received: by obbgp5 with SMTP id gp5so75848039obb.0
        for <git@vger.kernel.org>; Fri, 10 Jul 2015 02:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=BDUhxewXAFGaNDpb9UCpgnCEE15oGQ6YyQW5en5cWPY=;
        b=qO4l6r3MP9q0AiZcLhucOzZUChBcUsZGvsVi80CsCaFUcyscpMTTdD3rFqcsZPY7ov
         WHe9yn+ma+9mwXtHKoUXqXhQv4ZqDH8dD+LM70VFL1hdOOIZBkMh511/4YuoIixmF2T4
         FRytr5TJvJWHDSARGoJg172DZdlQtwZTgZbO7oc+v7kUTCCttjhX/CcQrbS9F9n97ZJ+
         2Aoo4Y7ER5oTUrkgn22rGukoM9x6ZXs8vcj3gnXiE6bq/gNKhRw8rQII0Ewce5BsIPnY
         7oQ8v6hYJ25jgYBkDnaeG0o+AJWJ6Cs08leY5NSPV/D0oS/SZUy3VcbWyRCnluXFB6QG
         kD+A==
X-Received: by 10.182.153.161 with SMTP id vh1mr18124118obb.34.1436521339050;
 Fri, 10 Jul 2015 02:42:19 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Fri, 10 Jul 2015 02:41:49 -0700 (PDT)
In-Reply-To: <vpqvbdt5tv6.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273810>

On Thu, Jul 9, 2015 at 7:13 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> If anyone can help, this is what it's saying.
>> "[Net::SMTP::SSL] Connection closed at
>
> Perhaps your SMTP server thought you were sending too many emails to too
> many people and closed the connection thinking you were a spammer.
>
> If you're having this kind of issues, it may make sense to run
> "format-patch" and "send-email" as two separate steps. This way, you can
> re-run "send-email" on the pieces which failed manually (adjusting
> --in-reply-to).
>

I'm guessing the same. That's what I usually do, separate format-patch and
send-email.

>Spaces around +.

Thanks :)

-- 
Regards,
Karthik Nayak
