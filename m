From: Geoff Russell <geoffrey.russell@gmail.com>
Subject: Re: understanding how remote tracking works
Date: Mon, 9 Aug 2010 11:23:58 +0930
Message-ID: <AANLkTinktpx-rXj1K0BSy0Qwo62SEGFAJWvhKo0nJq=i@mail.gmail.com>
References: <AANLkTi=J3tDnZUg3k5bzDk2ydzYVVLKLwoW0gpBypYAs@mail.gmail.com>
	<i3nlq0$8un$1@dough.gmane.org>
Reply-To: geoffrey.russell@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Ralf Ebert <info@ralfebert.de>
X-From: git-owner@vger.kernel.org Mon Aug 09 03:54:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiHZ2-00028O-Q8
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 03:54:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755236Ab0HIByD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Aug 2010 21:54:03 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:46040 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752917Ab0HIByB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Aug 2010 21:54:01 -0400
Received: by wwf26 with SMTP id 26so1845152wwf.1
        for <git@vger.kernel.org>; Sun, 08 Aug 2010 18:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:reply-to
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :content-type;
        bh=I2xZPvoHh3lSlvhmHEuYbY4m9XkyI6PMOFSqf9JJe6U=;
        b=qqCghwD2ep1wFdFJLzzx1Ql3Myosk+sIYAegGjjg9YtSDELJOLZ+Ow+AB+ckAhSyzm
         pZ0yV8V3Hyx/IFiSvhtjRzNIEpTPEmL5tq9lkm/eYHDaEGaGanNC2LZRD7NJH2HuQWI1
         pwPIyZMDqsU6g8OCZgd/tCKXBN7/86CWfIHTQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        b=uoECTzduihHRwFGKEo0rvALZQ/3FyI4DgESAIU+dr7u4ZERmUxhcAanUY/cDEE+O6B
         2gNearklE4eB4P2529GaW9xlYHbay0ef9dzjHwZvAvQRhZUg0LyzsmZybWLeLvqzC7aI
         rsKb4xY/vX8NFUczsUlnLDwK8NhP07lPQYcms=
Received: by 10.216.11.130 with SMTP id 2mr13219979wex.100.1281318840154; Sun, 
	08 Aug 2010 18:54:00 -0700 (PDT)
Received: by 10.216.80.82 with HTTP; Sun, 8 Aug 2010 18:53:58 -0700 (PDT)
In-Reply-To: <i3nlq0$8un$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152944>

Hi Ralf,

On Mon, Aug 9, 2010 at 11:01 AM, Ralf Ebert <info@ralfebert.de> wrote:
> Hi Geoff,
>
>> Why does "git show-ref" show me far more than in
>> in .git/refs/remotes/origin?
>
> probably the other refs come from .git/packed-refs . See
> http://www.kernel.org/pub/software/scm/git/docs/git-pack-refs.html .

Yes. Many thanks. I'm working my way through Jon Loeliger's Git book and it's
confusing when the actual behaviour differs from that in the book :)

Cheers,
Geoff
