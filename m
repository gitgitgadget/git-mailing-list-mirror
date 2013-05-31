From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v8 0/6] New git-related helper
Date: Fri, 31 May 2013 02:48:43 -0500
Message-ID: <CAMP44s3+QnXiSs3pPsMFdphMe-MDw5iD5+Sb1F=B0s+kTDipHw@mail.gmail.com>
References: <1369985864-31922-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 31 09:48:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UiK4v-0004b8-DI
	for gcvg-git-2@plane.gmane.org; Fri, 31 May 2013 09:48:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753762Ab3EaHsq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 May 2013 03:48:46 -0400
Received: from mail-lb0-f181.google.com ([209.85.217.181]:57062 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753655Ab3EaHsp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 May 2013 03:48:45 -0400
Received: by mail-lb0-f181.google.com with SMTP id w20so1375033lbh.26
        for <git@vger.kernel.org>; Fri, 31 May 2013 00:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=brIqGd5jcTeKyGQmIBlnPAaCIWD39ol+oRllu0lmjc8=;
        b=qI0EPEOs8YzBPe71csycjDRX+I17ki6A9bWtbBk4FzUu9SSXBCv6A1GdbFu6nah19S
         jkxSAkdR9QYgnj1ZZMMA5NHPE7omMkZ4SWWYXCmI8NBCnk/4Fy7i0GqWszz75lWBQ2We
         ECx8VS3B1BWFVOdEKsdR+poJBTr6atxac664MAT5nMIQMbsfjy+bLrQrvXbgFg0ImHyo
         WlIW7xPqJQdCNLkWuOTdc+5jQKlN+VOMrTTzSSdNjHUKDsTPg+Nryqa0U28rUo3QnYR0
         5498MXzMp65idA0b+f+vmQXxTuFu7Q4k9QsZin8I+TLxKrIpMKj7Iw3dTdb6OD5JvKLO
         xtqA==
X-Received: by 10.152.170.194 with SMTP id ao2mr5201706lac.48.1369986523113;
 Fri, 31 May 2013 00:48:43 -0700 (PDT)
Received: by 10.114.177.164 with HTTP; Fri, 31 May 2013 00:48:43 -0700 (PDT)
In-Reply-To: <1369985864-31922-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226070>

On Fri, May 31, 2013 at 2:37 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:

> Since there hasn't been any comments of importance this is basically the same
> as v7, plus a few other patches to make it actually usable (for me).
>
> Unfortunately it turns out Ruby's optparse is not suitable for our needs, so I
> implemented a very small parser that is.

Nevermind, we can drop the option parsing changes for later, it's not
important at the moment.

-- 
Felipe Contreras
