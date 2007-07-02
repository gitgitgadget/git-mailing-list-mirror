From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: why does git perpetually complain about include/asm-blackfin/macros.h?
Date: Mon, 2 Jul 2007 16:25:37 +0200
Message-ID: <81b0412b0707020725t2e95b972y2d52ec902a31a616@mail.gmail.com>
References: <Pine.LNX.4.64.0707020800010.1972@localhost.localdomain>
	 <4688EF9B.8020405@garzik.org>
	 <9a8748490707020658t5e6542ag6edb435dbc4499ab@mail.gmail.com>
	 <4689073D.1020802@garzik.org>
	 <81b0412b0707020722q25e8eb41t456e7316fe4a7b40@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Jesper Juhl" <jesper.juhl@gmail.com>,
	"Robert P. J. Day" <rpjday@mindspring.com>,
	"Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Linus Torvalds" <torvalds@linux-foundation.org>
To: "Jeff Garzik" <jeff@garzik.org>
X-From: git-owner@vger.kernel.org Mon Jul 02 16:25:47 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5MqY-0005mZ-0T
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 16:25:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756867AbXGBOZl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 10:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753695AbXGBOZk
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 10:25:40 -0400
Received: from ik-out-1112.google.com ([66.249.90.180]:31855 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753895AbXGBOZj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 10:25:39 -0400
Received: by ik-out-1112.google.com with SMTP id b32so1106532ika
        for <git@vger.kernel.org>; Mon, 02 Jul 2007 07:25:38 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Z9ik9a/+u6Sv66xeHWgdqJCWhr1gJvljlTR2ua4Hr0/i16h9mamDNfWvXYHtOk7cTuvv5vXvfvpWn92m8P0M1n5uZGSY+DQ49znuUcKukydYLfTqsOPZsPIqcD33MnXoOS2afVOGCs7ajIRHHObGYhlQWnSZiCL0ACGvUbrR+lQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GL8DGEXFI/OOxh+k4t3IXebfsTTzIcv65TcY4FJU2M4i0jWap68jwqgMU3VnRqDz+uiYFIUEgNWdg3MbeAfn7qxUGTyrgWw6tjmFOtvRFaBz3wIzohWI2Wtb2r0mjQBfAdbbfc9H5/QA66UNMqHEJhc+lWhP5GFSuPia7ZQcR80=
Received: by 10.78.159.7 with SMTP id h7mr2959992hue.1183386337697;
        Mon, 02 Jul 2007 07:25:37 -0700 (PDT)
Received: by 10.78.100.16 with HTTP; Mon, 2 Jul 2007 07:25:37 -0700 (PDT)
In-Reply-To: <81b0412b0707020722q25e8eb41t456e7316fe4a7b40@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51369>

On 7/2/07, Alex Riesen <raa.lkml@gmail.com> wrote:
> In that second case I can only suspect that all your branches point
> at the same commit, which is just before the one the file was removed
> in...

_Not_ the same. Just some commit before the file was removed, of course.
