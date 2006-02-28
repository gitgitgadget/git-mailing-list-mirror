From: Ryan Anderson <ryan@michonline.com>
Subject: Re: [PATCH] Add git-annotate, a tool for assigning blame.
Date: Tue, 28 Feb 2006 03:47:37 -0500
Message-ID: <20060228084737.GA13537@mythryan2.michonline.com>
References: <11404323692193-git-send-email-ryan@michonline.com> <20060220234054.GA7903@c165.ib.student.liu.se> <7vlkw57f63.fsf@assigned-by-dhcp.cox.net> <20060228082736.GA4593@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 28 09:49:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FE0XL-00036t-SF
	for gcvg-git@gmane.org; Tue, 28 Feb 2006 09:48:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964AbWB1Isj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Feb 2006 03:48:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750977AbWB1Isj
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Feb 2006 03:48:39 -0500
Received: from mail.autoweb.net ([198.172.237.26]:27053 "EHLO
	mail.internal.autoweb.net") by vger.kernel.org with ESMTP
	id S1750964AbWB1Isi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2006 03:48:38 -0500
Received: from c-68-60-186-73.hsd1.mi.comcast.net ([68.60.186.73] helo=h4x0r5.com)
	by mail.internal.autoweb.net with esmtp (Exim 4.50)
	id 1FE0X3-0001mF-KS; Tue, 28 Feb 2006 03:48:35 -0500
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by h4x0r5.com with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1FE0Ww-0004DE-VP; Tue, 28 Feb 2006 03:48:26 -0500
Received: from ryan by mythical with local (Exim 4.60)
	(envelope-from <ryan@mythryan2.michonline.com>)
	id 1FE0WY-0005UE-4t; Tue, 28 Feb 2006 03:48:02 -0500
To: Fredrik Kuivinen <freku045@student.liu.se>
Content-Disposition: inline
In-Reply-To: <20060228082736.GA4593@c165.ib.student.liu.se>
User-Agent: Mutt/1.5.9i
X-h4x0r5.com-MailScanner: Found to be clean
X-h4x0r5.com-MailScanner-From: ryan@michonline.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16924>

On Tue, Feb 28, 2006 at 09:27:36AM +0100, Fredrik Kuivinen wrote:
> On Mon, Feb 20, 2006 at 04:01:56PM -0800, Junio C Hamano wrote:
> > Fredrik Kuivinen <freku045@student.liu.se> writes:
> > 
> > > I have also been working on a blame program.
> 
> ...
> 
> > BTW, these days I always compile things with 
> > 
> > 	-Wall -Wdeclaration-after-statement
> > 
> > which caught quite a many.
> 
> Just out of curiosity, why do you prefer declarations before
> statements?

I won't speak for Junio, but the explanations I've heard in the past are
basically:

1) It keeps all declarations in one spot.
2) If your function is complicated enough to not need a variable until
fairly far into the function, it probably should be two (or more) functions.

Basically, I think that there's not wrong with doing it that way, per
se, just that it's sometimes a symptom of other problems, so fi you look
for the symptom, the problem sometimes is more obvious.


-- 

Ryan Anderson
  sometimes Pug Majere
