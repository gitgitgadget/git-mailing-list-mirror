From: Michael Witten <mfwitten@gmail.com>
Subject: Re: understanding how remote tracking works
Date: Sun, 8 Aug 2010 21:13:07 -0500
Message-ID: <AANLkTi=usaZGfOM67acmdAWwvbHe_eHyjmRLGmdTYNaC@mail.gmail.com>
References: <AANLkTi=J3tDnZUg3k5bzDk2ydzYVVLKLwoW0gpBypYAs@mail.gmail.com> 
	<i3nlq0$8un$1@dough.gmane.org> <AANLkTinktpx-rXj1K0BSy0Qwo62SEGFAJWvhKo0nJq=i@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ralf Ebert <info@ralfebert.de>, git@vger.kernel.org
To: geoffrey.russell@gmail.com
X-From: git-owner@vger.kernel.org Mon Aug 09 04:13:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiHs1-0007H4-18
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 04:13:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755279Ab0HICNj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Aug 2010 22:13:39 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63117 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752917Ab0HICNi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Aug 2010 22:13:38 -0400
Received: by fxm14 with SMTP id 14so4723015fxm.19
        for <git@vger.kernel.org>; Sun, 08 Aug 2010 19:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=/jRe1QwtPs0S4xc9h1IAs+gCjG+wRm6E9b1+7AtUYdA=;
        b=WaPoWXPoPD52pcMrXMY/amWA1oTRr3O9YykUMbyagh7QB4gk1TvcOfpjKGVcM8eLFl
         Pc1e+ZV4D2c1xLbsddbVi8IIcyd9UULYV7tDm80+IV0xm11XE7YXWI6N8nwJsV0LBXHI
         GrAeQY7uL0TQ+LeYzwvmRUiHaPCMMrj0fTstc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=YxwukRjyNL1l9HEaqYe0ZyqirxIGAtvL4yzjaeNgXWXnpvC2qhfJSEOXGAos+DD45Z
         M0Um+YYxZ/DIE7FvuFlEa/jpiYSKlGu2m+ddSq4PSsdfUmicKICYMwGjwzs2Njp+U6IV
         NDZuYymAlb5Bi4hZ0XXuhfW6+VlswjBal+O3M=
Received: by 10.239.172.67 with SMTP id z3mr763224hbe.92.1281320017349; Sun, 
	08 Aug 2010 19:13:37 -0700 (PDT)
Received: by 10.239.186.139 with HTTP; Sun, 8 Aug 2010 19:13:07 -0700 (PDT)
In-Reply-To: <AANLkTinktpx-rXj1K0BSy0Qwo62SEGFAJWvhKo0nJq=i@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152945>

On Sun, Aug 8, 2010 at 20:53, Geoff Russell <geoffrey.russell@gmail.com> wrote:
> I'm working my way through Jon Loeliger's Git book and it's
> confusing when the actual behaviour differs from that in the book

This probably results from the git culture's conflation (or should I
say confusion?) of low-level and high-level representations and
commands.
