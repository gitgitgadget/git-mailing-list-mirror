From: Mikael Magnusson <mikachu@gmail.com>
Subject: Re: [RFC PATCH] diff: use $COLUMNS if available for default stat_width
Date: Fri, 26 Aug 2011 13:20:30 +0200
Message-ID: <CAHYJk3Rw0i5uNW1vyd--OS4G6Pp2kNOA3aKUucWNrDgfQkYRkA@mail.gmail.com>
References: <1314337647-29270-1-git-send-email-kris@shannon.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Kris Shannon <kris@shannon.id.au>
X-From: git-owner@vger.kernel.org Fri Aug 26 13:20:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwuSi-0000pu-PK
	for gcvg-git-2@lo.gmane.org; Fri, 26 Aug 2011 13:20:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360Ab1HZLUc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Aug 2011 07:20:32 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:45645 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843Ab1HZLUb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2011 07:20:31 -0400
Received: by vxi9 with SMTP id 9so2484739vxi.19
        for <git@vger.kernel.org>; Fri, 26 Aug 2011 04:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=vrqXEl+ErE3e4LrpXHTrajipWBm7y128RF5FI4FQMs0=;
        b=TsQnlmL5ecdPqWhE51WRb4IbiRrwyltu/VoeVbwv7hp7nsQUIMHmhj54FUuDb38xjy
         BoTOr62I0ke4IRzshsytaMFoo0Lb+IRcrvLyoloJ5GTg5/llyW7xCwTj7X03igqbaYwG
         +UHg4dESVJFDdFkj/ocYjEgVBO6Q6nxSjHj0k=
Received: by 10.52.21.65 with SMTP id t1mr994229vde.183.1314357630718; Fri, 26
 Aug 2011 04:20:30 -0700 (PDT)
Received: by 10.52.166.136 with HTTP; Fri, 26 Aug 2011 04:20:30 -0700 (PDT)
In-Reply-To: <1314337647-29270-1-git-send-email-kris@shannon.id.au>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180162>

On 26 August 2011 07:47, Kris Shannon <kris@shannon.id.au> wrote:
> If the COLUMNS environment variable is set use it's value
> as the default stat_width.
>
> Also set the stat_name_width default to 2/3 of the full width.
>
> This does change the default from 50 to 53 when using the
> original 80 column stat_width fallback.

You probably only want to do this when stdout is a terminal.

-- 
Mikael Magnusson
