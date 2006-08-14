From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Compression and dictionaries
Date: Mon, 14 Aug 2006 09:48:47 +0200
Message-ID: <81b0412b0608140048s2dae66edj4af76a6cd564af7d@mail.gmail.com>
References: <9e4733910608132037t4297c3bbq9b0cd6ebaa03b979@mail.gmail.com>
	 <20060814035603.GB18667@spearce.org>
	 <9e4733910608132107j7bca0271g360de3447febbf51@mail.gmail.com>
	 <20060814041705.GD18667@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Jon Smirl" <jonsmirl@gmail.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 14 09:49:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCXBz-0001ae-Nl
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 09:49:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751921AbWHNHsz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 03:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751892AbWHNHsu
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 03:48:50 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:8970 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751882AbWHNHst (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 03:48:49 -0400
Received: by nf-out-0910.google.com with SMTP id a4so1639328nfc
        for <git@vger.kernel.org>; Mon, 14 Aug 2006 00:48:47 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=X2zsDMNtcfe+evR8wHV+MLqK4XTwjRWw/F/AWg8PuNuKiEqw4ufVHgrOV0kT/w1ogLtuIZPal1ksaxvv8nfYFOPFVmaBznL/W088sYwtGtrhBLvoaWDqGtraKveUV5eH/nMRGTj0kg9Vgwmf8iBhKHwpCdEwx2bbAd+2fDrr0DM=
Received: by 10.78.140.17 with SMTP id n17mr3141657hud;
        Mon, 14 Aug 2006 00:48:47 -0700 (PDT)
Received: by 10.78.160.12 with HTTP; Mon, 14 Aug 2006 00:48:47 -0700 (PDT)
To: "Shawn Pearce" <spearce@spearce.org>
In-Reply-To: <20060814041705.GD18667@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25330>

On 8/14/06, Shawn Pearce <spearce@spearce.org> wrote:
> > A fixed dictionary could conceivably take 5-10% off the size of each entry.
>
> Could be an interesting experiment to see if that's really true
> for common loads (e.g. the kernel repo).  I don't think anyone has
> tried it.

BTW, kenel repo rapidly becomes "less than common load" for git ;)
