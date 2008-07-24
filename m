From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: [PATCH 7/9] builtin-checkout-index.c: use parse_options()
Date: Thu, 24 Jul 2008 22:35:05 +0200
Message-ID: <bd6139dc0807241335i3ab5280aq6a46325428ccc70f@mail.gmail.com>
References: <1216849332-26813-1-git-send-email-barra_cuda@katamail.com>
	 <1216849332-26813-8-git-send-email-barra_cuda@katamail.com>
	 <alpine.DEB.1.00.0807241543190.8986@racer>
	 <200807242208.37192.barra_cuda@katamail.com>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, gitster@pobox.com
To: "Michele Ballabio" <barra_cuda@katamail.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 22:36:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM7Xp-0002FA-8Q
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 22:36:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752248AbYGXUfJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 16:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751663AbYGXUfJ
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 16:35:09 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:52713 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751985AbYGXUfH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 16:35:07 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1310087ywe.1
        for <git@vger.kernel.org>; Thu, 24 Jul 2008 13:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=ZVbJKJ1IMxTwqxVZcWvUQ4k1dJsAVWxNf+CxBqkXLUw=;
        b=niDz+oJ01bUFEmfwQP2fxG4cJZTIEAC0QkB/1ALp7jYJ7ALKYlmoxSE4iRbXHcWXC6
         BzChLoRzcj1hXqii68MNoyzdbZStZsdwaAv3U8HThPbNiow3Fr0Xslau5b1zAuZ4S3ge
         l+Hh8t08oFnsQ5WM/TTC/BJDIZlkKbXDkrKsk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=TCgibqMquGEdDvUIr6sEtwv2OUYkyuQqzyI/re0IKuTPkq3h0ARFej6a7O8qqMy/w/
         +c1aHlFa0IynXhY6kiUBYq2CcGAwfi5OdrUNAvNbqlzmrdRQu9uCRw6tUIsl8ksIxuZ2
         xrjusRzN367CRGqQOOS8+3dtHgO3BiLSQM5NA=
Received: by 10.142.170.3 with SMTP id s3mr246625wfe.252.1216931705745;
        Thu, 24 Jul 2008 13:35:05 -0700 (PDT)
Received: by 10.143.38.17 with HTTP; Thu, 24 Jul 2008 13:35:05 -0700 (PDT)
In-Reply-To: <200807242208.37192.barra_cuda@katamail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89959>

On Thu, Jul 24, 2008 at 10:08 PM, Michele Ballabio
<barra_cuda@katamail.com> wrote:
> On Thursday 24 July 2008, Johannes Schindelin wrote:
>> On Wed, 23 Jul 2008, Michele Ballabio wrote:
>>
>> > +           { OPTION_CALLBACK, 'f', "force", &state, NULL,
>> > +             "force overwrite of existing files",
>> > +             PARSE_OPT_NOARG, parse_state_force_cb, 0 },
>>
>> I wonder if this could not be written as
>>
>>               OPT_BOOLEAN('f', "force", &state.force,
>>                       "force overwrite of existing files"),
>
> I did it that way because 'force' is a bitfield.

I thought there is an OPT_BIT?

-- 
Cheers,

Sverre Rabbelier
