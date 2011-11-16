From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 0/3] avoiding unintended consequences of git_path() usage
Date: Wed, 16 Nov 2011 15:42:37 +0700
Message-ID: <CACsJy8A8U130gzsd5ZdcW2gt8FvE=zFk34mRbp+T-R+mvn0TRw@mail.gmail.com>
References: <1320510586-3940-1-git-send-email-artagnon@gmail.com>
 <1320510586-3940-4-git-send-email-artagnon@gmail.com> <20111106002645.GE27272@elie.hsd1.il.comcast.net>
 <CALkWK0nGhUshwJM1vmAUhBG9foH+=6+_KFhfTTF6+kNS0Hm2JA@mail.gmail.com>
 <7v7h33oifq.fsf@alter.siamese.dyndns.org> <CALkWK0nUuzn2_itdACHLQBpUaVv97tFAjNGdVBEhWC7a6Rp75w@mail.gmail.com>
 <20111115095225.GB23139@elie.hsd1.il.comcast.net> <7v7h31wduv.fsf@alter.siamese.dyndns.org>
 <CALkWK0kOrGzjcGNcf2qPahJSgkvCsQwSrEfAA3wj6PqnMzDBVQ@mail.gmail.com>
 <20111116075955.GB13706@elie.hsd1.il.comcast.net> <CACsJy8Di3ZrPdXh1Jf=PbLYRWwx-TEV78NzUukwaxA0xW=rSNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 16 09:43:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQb5O-0004g5-VL
	for gcvg-git-2@lo.gmane.org; Wed, 16 Nov 2011 09:43:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755199Ab1KPInK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Nov 2011 03:43:10 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55864 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755100Ab1KPInI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2011 03:43:08 -0500
Received: by fagn18 with SMTP id n18so1169219fag.19
        for <git@vger.kernel.org>; Wed, 16 Nov 2011 00:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=IVameHiOI/eDxPHjtvLHSL75JxjzpyJa6y0fpBtNMpM=;
        b=fW9vxHSfC3/hxwf8cuQQGwR1tbM0/xKeYxvSI5MO7bGaRZ6DKYP/VMe/GWUyYNJkgu
         hukMZZ5FbGLGUxabnxxsuhfCsO5onJx3lk+4XLaQv3eemjszHZmApr5tc8hp/VjMqT9S
         NEELwsf0AUcx0c6iFy6zZeegTY8qwveI2KjZI=
Received: by 10.204.130.208 with SMTP id u16mr27493387bks.47.1321432987166;
 Wed, 16 Nov 2011 00:43:07 -0800 (PST)
Received: by 10.204.23.2 with HTTP; Wed, 16 Nov 2011 00:42:37 -0800 (PST)
In-Reply-To: <CACsJy8Di3ZrPdXh1Jf=PbLYRWwx-TEV78NzUukwaxA0xW=rSNg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185527>

On Wed, Nov 16, 2011 at 3:37 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> I suspect
> with some macro magic, we can keep track of generated strings without
> a hash table.

I misremembered. There is an operator to convert symbol to string, not
the other way around.
-- 
Duy
