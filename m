From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] git-remote-helpers.txt: explain how import works with
 multiple refs
Date: Thu, 1 Sep 2011 13:24:07 +0200
Message-ID: <CAGdFq_jfCzy71AL3XSJ9q8LVNPUCYEY=yrwpJppP1asW1GoXmg@mail.gmail.com>
References: <CAGdFq_gooPGQMa5D19-wag=X+mDntHF1MwXiYF0zovB=L-Sybw@mail.gmail.com>
 <1314809222-30528-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 01 13:24:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qz5O9-0005FG-98
	for gcvg-git-2@lo.gmane.org; Thu, 01 Sep 2011 13:24:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757160Ab1IALYs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Sep 2011 07:24:48 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:46433 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752944Ab1IALYr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Sep 2011 07:24:47 -0400
Received: by pzk37 with SMTP id 37so2881846pzk.1
        for <git@vger.kernel.org>; Thu, 01 Sep 2011 04:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=OeDneb2W1AYOzFQUNXDmKb3FmIEB7xCiE3prp+pvVg4=;
        b=RB3k7kkzSRtPMAPuezU3iPZUl0eIOxW+oSVKNDeNKDMsOUFl0K9Ksslp8CrKRKaGum
         UJZhkRSX0toHDUDoJWRBDFowkP59t+zc4EiG7IaQFHwe4r/xaPLEpu7ZFlFA8Q0vIKX4
         fvs8hWro7/jP8Hb6M1A29x4HGTFM8O+peWpQk=
Received: by 10.68.56.199 with SMTP id c7mr130326pbq.495.1314876287250; Thu,
 01 Sep 2011 04:24:47 -0700 (PDT)
Received: by 10.68.43.9 with HTTP; Thu, 1 Sep 2011 04:24:07 -0700 (PDT)
In-Reply-To: <1314809222-30528-1-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180528>

Heya,

[+Jonathan Nieder]

On Wed, Aug 31, 2011 at 18:47, Matthieu Moy <Matthieu.Moy@imag.fr> wrot=
e:
> This is important for two reasons:
>
> * when two "import" lines follow each other, only one "done" command
> =C2=A0should be issued in the fast-import stream, not one per "import=
".
>
> * The blank line terminating an import command should not be confused
> =C2=A0with the one terminating the sequence of commands.
>
> While we're there, illustrate the corresponding explanation for push
> batches with an example.

Thank you!

Acked-by: Sverre Rabbelier <srabbelier@gmail.com

--=20
Cheers,

Sverre Rabbelier
