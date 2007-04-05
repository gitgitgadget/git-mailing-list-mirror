From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Fix passing of TCLTK_PATH to git-gui
Date: Thu, 5 Apr 2007 15:10:25 +0200
Message-ID: <81b0412b0704050610m19a72984u34888af00d70eeab@mail.gmail.com>
References: <81b0412b0704050049u746842ebn270998c5732927d3@mail.gmail.com>
	 <7v8xd7tdl0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Eygene Ryabinkin" <rea-git@codelabs.ru>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Apr 05 15:10:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZRjb-0008Tt-Pd
	for gcvg-git@gmane.org; Thu, 05 Apr 2007 15:10:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1766985AbXDENKa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 09:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1766983AbXDENK3
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 09:10:29 -0400
Received: from an-out-0708.google.com ([209.85.132.243]:45901 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1766982AbXDENK1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 09:10:27 -0400
Received: by an-out-0708.google.com with SMTP id b33so653039ana
        for <git@vger.kernel.org>; Thu, 05 Apr 2007 06:10:26 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RxeoKYOZTOrKihQcApgDfU5V9XrD+6TI4oSsB0cdGu6blGbNhJaicy3seaVEAmz9iA/N1JKV9tKebTln2JJUv2v5ba7a+39faUgxGddH01KJJuFlmcrgvlIP/1BWG5qIkL8p8YhKpL30D8t04QYv9nVE9JAoVYNnc0573PZcJts=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cw6pKU/JAhQiyXpVFVnH66V70/gI+1w2h7fw2b313QRrysQfKWSThvCtpMtv57oSxJYIYp4HEfbCmNygYUe8mFWiJX28mCNbX+xvZ9RLguStybCVXdSH0pNfofFWeY3xwrE+hpzeXeznb4w1XP3rFN+bl6ANiGo8m0h6hxkeZtA=
Received: by 10.100.31.2 with SMTP id e2mr1239385ane.1175778625856;
        Thu, 05 Apr 2007 06:10:25 -0700 (PDT)
Received: by 10.100.86.14 with HTTP; Thu, 5 Apr 2007 06:10:25 -0700 (PDT)
In-Reply-To: <7v8xd7tdl0.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43824>

On 4/5/07, Junio C Hamano <junkio@cox.net> wrote:
> "Alex Riesen" <raa.lkml@gmail.com> writes:
>
> > Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
> > ---
> >
> > GNU make does not include environment variables by default
> > in its namespace.
>
> Shouldn't this be part of proposed commit log message?

Err... yes.

> Also I'd appreciate if you did not attach the format-patch
> output, but send a properly formatted e-mail.  I would not be so
> picky to non-regulars, but I expect I'd be getting many more
> patches from you, so...

I'll resend as soon as I get home.
