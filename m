From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Applying patches from a patch set
Date: Sat, 20 Dec 2008 11:25:58 -0800 (PST)
Message-ID: <m3iqped4yi.fsf@localhost.localdomain>
References: <dac45060812200637m49c71aa5x3c25010fa00f4a63@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Mark Ryden" <markryde@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 20 20:27:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LE7Tu-0005tT-1B
	for gcvg-git-2@gmane.org; Sat, 20 Dec 2008 20:27:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752537AbYLTT0D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Dec 2008 14:26:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752580AbYLTT0C
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Dec 2008 14:26:02 -0500
Received: from ik-out-1112.google.com ([66.249.90.179]:21128 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752371AbYLTT0A (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Dec 2008 14:26:00 -0500
Received: by ik-out-1112.google.com with SMTP id c29so314955ika.5
        for <git@vger.kernel.org>; Sat, 20 Dec 2008 11:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=Sc0Rp2QvndK/JVwajb8o5PSjpWaZhoT4ttflSoXClOU=;
        b=KfKwX+aT7HlQDzy8Iqa+zOLt5VsMlWbHLY2Vl5/KcqEbniAqEG0tjbsMUBOzW686P6
         Lq2iDfjUbI15dO7tSb8bSIglTGrMWqivkv7PXkok+0PnRweQe5V3OB0fZsIYd7ML6kH9
         aLhLibF0UBBZRiHY1Vmskzqp6EiFG4rXDyj7k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=nQpA2F/6uW60kX5yK4cUkTXxwZuHc2+ytvYYZqI0qCFcCr/Zc7G2qBa2DGIMZYi8ED
         me/Spy+GCozlUopYmVOocMK2mU4zgRiCReBkbdMDkKLsnCom1E6GmBGPMS3MOWGnQD9X
         JxtXTyecKT4UsjVh0LHS+pXQJ4a9AIEeRxw30=
Received: by 10.66.250.1 with SMTP id x1mr5438170ugh.4.1229801158939;
        Sat, 20 Dec 2008 11:25:58 -0800 (PST)
Received: from localhost.localdomain (abwp146.neoplus.adsl.tpnet.pl [83.8.239.146])
        by mx.google.com with ESMTPS id o30sm10710545ugd.35.2008.12.20.11.25.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 20 Dec 2008 11:25:58 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mBKJPaWU011001;
	Sat, 20 Dec 2008 20:25:47 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id mBKJPQ2x010997;
	Sat, 20 Dec 2008 20:25:26 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <dac45060812200637m49c71aa5x3c25010fa00f4a63@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103654>

"Mark Ryden" <markryde@gmail.com> writes:

>   I am subscribed to some linux kernel subsystem mailing list; in this
> list there are sometimes patchsets with more than
> 30-40 patches.

I hope in proper patch series...

> I am using gmail web interface client.

Better use some standalone mail program. Patch series should be send
in thread, either as reply to the cover letter message, or threaded
each being reply to previous patch... beside being numbered; IIRC
GMail web interface doesn't have threading implemented...


> In order to apply a patch set I copy and paste each patch from the
> patchset into a file, and then apply that patch.

You use raw view, I assume? Otherwise you would fail afoul word
wrapping and other whitespace mangling, at least...

[...]

> (I remember there was something called git apply-mbox in the past).

You can use "git am" for that, which is modern equivalent, and which
can do (almost) everything git-apply-mbox did.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
