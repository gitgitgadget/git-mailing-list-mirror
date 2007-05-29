From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: GIT on MinGW problem
Date: Tue, 29 May 2007 11:28:42 -0400
Message-ID: <fcaeb9bf0705290828j3703cfa9g11f2f7afb17a8c91@mail.gmail.com>
References: <1dbc01c79432$b4400a80$0200a8c0@AMD2500> <464534EE.30904@xs4all.nl>
	 <4656A304.AF39A0B6@eudaptics.com> <f3a2ke$9s7$1@sea.gmane.org>
	 <465C064F.B9CE9379@eudaptics.com> <465C1252.9020801@trolltech.com>
	 <Pine.LNX.4.64.0705291305540.4648@racer.site>
	 <465C2516.7040607@trolltech.com>
	 <Pine.LNX.4.64.0705291446170.4648@racer.site>
	 <465C3502.BE134BC9@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Marius Storm-Olsen" <marius@trolltech.com>, git@vger.kernel.org
To: "Johannes Sixt" <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Tue May 29 17:28:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ht3cx-00047N-9K
	for gcvg-git@gmane.org; Tue, 29 May 2007 17:28:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750876AbXE2P2p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 May 2007 11:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbXE2P2p
	(ORCPT <rfc822;git-outgoing>); Tue, 29 May 2007 11:28:45 -0400
Received: from an-out-0708.google.com ([209.85.132.244]:4059 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876AbXE2P2o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2007 11:28:44 -0400
Received: by an-out-0708.google.com with SMTP id d31so540822and
        for <git@vger.kernel.org>; Tue, 29 May 2007 08:28:43 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=X1KKOoEqZlfrkPlsYLRSj/mOq/Q0oZmkVZFnSlQ7CHTsnaXvFiyZbE6i9Jro8JE0FHNEwpwOfnhrOUH+uPqJcwJqNMXY+UfAtERQhJV5h2tuXTTgQKxerS56y3uD3637plfDTpTn0TzQv4wA7obYKyJMpTyOLPFxjMHzBj6utc0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=J6ekStiUq+QKN3ngN9PL33h010UFUEtJLVbAJCWnplLSK6W58jg+4F1/k79Hp+tz4mK0XEkhmYBspWamwZopzJbP6GnihiDcYxIm93gGHD9g/btSCela/flhjghR8wnYo5J5Turu1mjYXVghYuv87uWLbXldIhCwQBUYRVEtNN8=
Received: by 10.100.138.2 with SMTP id l2mr5232541and.1180452522942;
        Tue, 29 May 2007 08:28:42 -0700 (PDT)
Received: by 10.100.127.2 with HTTP; Tue, 29 May 2007 08:28:42 -0700 (PDT)
In-Reply-To: <465C3502.BE134BC9@eudaptics.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48697>

On 5/29/07, Johannes Sixt <J.Sixt@eudaptics.com> wrote:
> Johannes Schindelin wrote:
> > There are at least three different cmd.exe that _I_ encountered: NT4.0,
> > 2000 and XP. All of them have different features. None of my scripts
> > worked without _heavy_ workarounding on all of them.
> >
> > But I think a .lnk file would be easier to create, and more portable,
> > right?
>
> If:
>
> 1. there is a .lnk file named gitk.lnk with target for example:
>
>     D:\MSYS\1.0\mingw\bin\wish84.exe D:\MSYS\1.0\git\bin\gitk
>
> 2. you change PATHEXT to include '.LNK'.
>
> then gitk can be invoked with varying arguments from CMD. I've tested
> this only on W2k. Point 2 looks hackish and dangerous to me.

I'd suggest create a small C wrapper to launch gitk. It would be much
easier that way IMHO.

-- 
Duy
