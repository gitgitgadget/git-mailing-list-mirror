From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Make the installation targets a little less chatty
Date: Tue, 5 Jun 2007 12:33:18 +0200
Message-ID: <81b0412b0706050333q41802373w5c3f315ae944f7f0@mail.gmail.com>
References: <20070603010044.GA4507@spearce.org>
	 <20070603130745.GC2495@steel.home>
	 <7vvee4jh24.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0706040700s667afe5ap14a8343a9313ef60@mail.gmail.com>
	 <Pine.LNX.4.64.0706041840460.4046@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 05 12:33:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvWLw-0006p1-QR
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 12:33:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762389AbXFEKdV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 06:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763179AbXFEKdV
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 06:33:21 -0400
Received: from hu-out-0506.google.com ([72.14.214.225]:5130 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762389AbXFEKdU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2007 06:33:20 -0400
Received: by hu-out-0506.google.com with SMTP id 19so694670hue
        for <git@vger.kernel.org>; Tue, 05 Jun 2007 03:33:18 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WrV8Vfl+esEUhtQNmSgzKwTqvi+3EIN8WKwl65IjwfL4UlRPPoiYM7r1hQGSkNg5x4z7dY2JeiejbRsHDxanwa+2vUuN62oMc8bmm2CIKgZLgob+japev1T2hj2Yr5BEw1/GZr+zky7II4ZjexwvmNQxWyH2mQvrObE5xqu1QMs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GIbFSub1hVjcSE3x/Zqf8T8JwpOArLTTuiBcFe7LjoRpMoRNW0XkCUHD6/ZK5FNp6YQ88heZv2qQOdW+oYLlFDJE5X5AxoZzPDTwTw+hW4lzRoS5lFqpR3SzssBZjCx/UksBwDOEjEKrEGSgx5GcP3Yiw/vSD5tFEVjMk/J//fA=
Received: by 10.78.21.7 with SMTP id 7mr2390893huu.1181039598366;
        Tue, 05 Jun 2007 03:33:18 -0700 (PDT)
Received: by 10.78.100.16 with HTTP; Tue, 5 Jun 2007 03:33:18 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0706041840460.4046@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49186>

On 6/4/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> So, are you sure you want to force everybody who wants to compile Git to
> use a recent GNU make?
>

Dunno. I just didn't want to slap more workarounds onto Git's Makefile.
