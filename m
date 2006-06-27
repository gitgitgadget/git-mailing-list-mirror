From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: CFT: merge-recursive in C
Date: Tue, 27 Jun 2006 13:53:57 +0200
Message-ID: <81b0412b0606270453m15d65e9ap5f47071331cd3280@mail.gmail.com>
References: <20060626233838.GA3121@steel.home>
	 <Pine.LNX.4.63.0606270936520.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	 <81b0412b0606270158i16ebee20me81ca2b9fa71db5c@mail.gmail.com>
	 <Pine.LNX.4.63.0606271248270.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <junkio@cox.net>,
	"Fredrik Kuivinen" <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Tue Jun 27 13:54:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvC99-0004uL-7o
	for gcvg-git@gmane.org; Tue, 27 Jun 2006 13:54:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbWF0LyG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Jun 2006 07:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbWF0LyF
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jun 2006 07:54:05 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:31935 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932342AbWF0Lx7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jun 2006 07:53:59 -0400
Received: by ug-out-1314.google.com with SMTP id a2so2538001ugf
        for <git@vger.kernel.org>; Tue, 27 Jun 2006 04:53:58 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=h/d7JBtSOswweDAojc53OfiBhGjxQLG/VnUtjKLFirPHIp0anTsg0HgCcfPUqq0VaHG9l9a7jUcKI/suAYwEPHmgXHh52aXKDfYju1Cd7zop5YNLzCmut/955QoTKBD9ZcewUn8POcV1sldfQ3ZM936tjYhJAGhwk1qQgOKPOao=
Received: by 10.78.160.2 with SMTP id i2mr2464330hue;
        Tue, 27 Jun 2006 04:53:58 -0700 (PDT)
Received: by 10.78.37.7 with HTTP; Tue, 27 Jun 2006 04:53:57 -0700 (PDT)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0606271248270.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22732>

On 6/27/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > - have you considered using run-command() instead of system()?
> >
> > No. What run-program?
>
> run-command.c:run_command(). Call it like this:
>
> int return_code = run_command("git-read-tree", sha1_to_hex(sha1), NULL);
>

Oh, I see. Will convert right away.
