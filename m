From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH] Documentation/git-rerere: document 'remaining' command
Date: Wed, 7 Mar 2012 22:08:16 -0500
Message-ID: <CABURp0run5zYLBkUsNQEJq3h_1y7bQ44XZb9BPja+RjX8OLyfg@mail.gmail.com>
References: <1331036512-7626-1-git-send-email-vfr@lyx.org> <7vwr6xsfbn.fsf@alter.siamese.dyndns.org>
 <CABURp0rOFgwLu0pX0W5txOH=CH6Yb4NchYLaj91m1nMve_zjDg@mail.gmail.com> <7vvcmgkq20.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Vincent van Ravesteijn <vfr@lyx.org>, git@vger.kernel.org,
	martin.von.zweigbergk@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 04:08:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5Tie-0007Zs-60
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 04:08:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752408Ab2CHDIi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Mar 2012 22:08:38 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:65154 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750982Ab2CHDIh convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 7 Mar 2012 22:08:37 -0500
Received: by lahj13 with SMTP id j13so44276lah.19
        for <git@vger.kernel.org>; Wed, 07 Mar 2012 19:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=HvsgC/3LE7Vz3m/8OK7xdG17kZUtBnra6m88DKCL3Ng=;
        b=ns7M2S5qPQO07svrHovmmAR0XhhEB7UujH7BqO+2Aeop0IFIs8OsyWbzKThhkIZ0xI
         zJzJs9Z7+TLpqcrl8LYNn7FSQlM2zhcHyFXTtS4h4j1OTJpoz7HtGG8bxAwYgPfBdd83
         d73EjctjCZssem7ic/TkwahOZm+Ou05GELibUfp7YMITH1Qxa5W9JPcsYpVSpcp8yH0/
         yVl/7QIRT1CL1PD4wt3DUc4BULElXouggDAZp6WEZRsK2hz/Gg8X/5pcWn8FKs4zsieb
         S2IHom9LJsN+AEE6mVL47Wm8WxtbROOILlmA1cHYyzxsIE1qpl4mS0D1yiJv8iex7x31
         xW3A==
Received: by 10.112.11.5 with SMTP id m5mr1532972lbb.66.1331176116317; Wed, 07
 Mar 2012 19:08:36 -0800 (PST)
Received: by 10.112.8.133 with HTTP; Wed, 7 Mar 2012 19:08:16 -0800 (PST)
In-Reply-To: <7vvcmgkq20.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192516>

On Wed, Mar 7, 2012 at 5:24 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Phil Hord <phil.hord@gmail.com> writes:
>
>> On Tue, Mar 6, 2012 at 2:24 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> ...
>>> =A0 =A0 =A0 =A0'remaining'::
>>>
>>> =A0 =A0 =A0 =A0Print paths with conflicts that are not resolved.
>>>
>>> Should be sufficient, I think.
>>
>> .... =A0'mergetool' uses this command to
>> avoid asking the user to resolve files which git rerere already
>> resolved for her.
>
> Ok, so "Print paths with conflicts that are not resolved." indeed is
> sufficient.

If you goal is to say as little as possible, then yes.  But I had to
read the related commit messages several times before it dawned on me
what the distinction was.  The main problem was that I didn't
understand that I was missing 'rerere.autoupdate=3Dtrue' in my config,
or why it mattered.  I only know that rerere was letting me down
sometimes, and 'rerere remaining' seemed to be missing some
clearly-still-unresolved files.

Thanks to this proposal, I understand it better now.  But not from
reading this email thread.

Phil
