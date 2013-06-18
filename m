From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] send-email: allow use of basic email list in --cc --to
 and --bcc
Date: Tue, 18 Jun 2013 15:51:36 +0530
Message-ID: <CALkWK0=2t7mv9t1xLOG8X5HMRhcamf3LjC+Qny1cX5mJGJdE_A@mail.gmail.com>
References: <1371549079-19291-1-git-send-email-Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
 <CALkWK0mTWC87Z1E3eZ_gzjXrmtFb9ir6aY7mXVBfe9oHHXCHcQ@mail.gmail.com> <f1cbf11015d6ebd9640b2b59ab4631e1@ensibm.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jorge-Juan.Garcia-Garcia@ensimag.imag.fr, git@vger.kernel.org,
	gitster@pobox.com,
	Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: =?UTF-8?Q?Mathieu_Li=C3=A9nard=2D=2DMayor?= 
	<mathieu.lienard--mayor@ensimag.fr>
X-From: git-owner@vger.kernel.org Tue Jun 18 12:22:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uot3N-0001c3-3r
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 12:22:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754407Ab3FRKWR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Jun 2013 06:22:17 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:61579 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751905Ab3FRKWQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Jun 2013 06:22:16 -0400
Received: by mail-ie0-f179.google.com with SMTP id c10so9033830ieb.24
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 03:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=hgWUaAu8oIjqfCaBfmYlCpPjGfNXVDTlvAeNt0FaEhM=;
        b=PSVH/EletZFIU6PQKp6lBCrT8pDEE0xUAN2g7Xz9q1RkDJA0er8xzjMrMcaiTHkNf+
         SxBV2BcEmzobrMzneSDRQs9nxClm7GNJYUFVxt0dkes7ZNONLP75oizR7ZF/KqAEvBBD
         bGmUOUqM9VKkYDzju0nwRAxDD1jVxLlPzejHPS4CVwJGAnJJykvonnHZx3I05vSvxNap
         DWo6K3JE1we3XgWiGsIHlwRFjjbquzur/PEAmlzyMYPMxr5LWnqAKp0MY9aemsTO/2ky
         1OinxRY+0o8uyObvP5k7jwiEg/gfCb5o3EyyR1N20JwXe41T63W7XPA6/yc4tsPJq97b
         r7xQ==
X-Received: by 10.50.3.37 with SMTP id 5mr7231243igz.0.1371550936329; Tue, 18
 Jun 2013 03:22:16 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Tue, 18 Jun 2013 03:21:36 -0700 (PDT)
In-Reply-To: <f1cbf11015d6ebd9640b2b59ab4631e1@ensibm.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228188>

Mathieu Li=C3=A9nard--Mayor wrote:
>> Is this a regression?  I can't send emails to a recipient whose name
>> contains a comma?
>
> It is not. Previously the input would be considered incorrect:

Right.  It dies with

  Comma in --to entry: ...

This artificial limitation is imposed by 79ee555b (Check and document
the options to prevent mistakes, 2006-06-21).

Perhaps include this information in the commit message?
