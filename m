From: "Vegard Nossum" <vegard.nossum@gmail.com>
Subject: Re: about c8af1de9 (git status uses pager)
Date: Sun, 22 Jun 2008 11:49:36 +0200
Message-ID: <19f34abd0806220249u6586c981hb1a31e7a67bad696@mail.gmail.com>
References: <alpine.LNX.1.10.0806212319410.22036@fbirervta.pbzchgretzou.qr>
	 <19f34abd0806211430x3d7195d8idc61b7103f899947@mail.gmail.com>
	 <7vzlpe8nyo.fsf@gitster.siamese.dyndns.org>
	 <alpine.LNX.1.10.0806212343560.18093@fbirervta.pbzchgretzou.qr>
	 <alpine.LNX.1.10.0806221107540.15126@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Bart Trojanowski" <bart@jukie.net>, git@vger.kernel.org
To: "Jan Engelhardt" <jengelh@medozas.de>
X-From: git-owner@vger.kernel.org Sun Jun 22 11:50:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAMDT-0006dr-8l
	for gcvg-git-2@gmane.org; Sun, 22 Jun 2008 11:50:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495AbYFVJtk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2008 05:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751468AbYFVJtk
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 05:49:40 -0400
Received: from rv-out-0506.google.com ([209.85.198.225]:13658 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751370AbYFVJtj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2008 05:49:39 -0400
Received: by rv-out-0506.google.com with SMTP id k40so6451314rvb.1
        for <git@vger.kernel.org>; Sun, 22 Jun 2008 02:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=s66NxDY2PfReyVKAhHeBanAY50epCxzVmlyvvUj6xao=;
        b=u5au2PQVu3KUTLMefZkTNNJEXdobLpo+Dj1Cm+QGbQ2NafN8e4NcBQBWLXY/L5RFZ1
         BR+f9mAWjKtTYq+Lfgvkn2cOfYQ1JUzniBtRrLaWJcYmyO1yItjyMJ4w6Y82+yd3qek3
         w3OovQBKC9xftRX3UH6UD7if/D0gGpe651lwI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=UNjHko5Dbl0Yoce8YBQyNceyGNJFuYM4sWdDg8of+6+Ite+vWn8kqM8dNf+f8DGg9J
         HbsQsTczJQlJe97iWqVpFzhv5kGscZFUzUxF5nW6AcTk+hjJWNEI5yIp28vZvhTAgpv7
         mGl8uF7zYPHicEAewu06V0QdiZmhoNvVu1/oI=
Received: by 10.141.20.7 with SMTP id x7mr10548168rvi.207.1214128176919;
        Sun, 22 Jun 2008 02:49:36 -0700 (PDT)
Received: by 10.140.136.1 with HTTP; Sun, 22 Jun 2008 02:49:36 -0700 (PDT)
In-Reply-To: <alpine.LNX.1.10.0806221107540.15126@fbirervta.pbzchgretzou.qr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85762>

On Sun, Jun 22, 2008 at 11:09 AM, Jan Engelhardt <jengelh@medozas.de> wrote:
> I've played with `less -F` for a while now, and there is an inherent
> problem with that. Or should I say, xterm.
> When less quits, the xterm "screen" blits back to the shell output
> that was previously visible, so
>        git status
> with less -F as a pager displays practically *nothing*.
> I am aware that this is a less / xterm issue, but I wanted to let
> you know.
>

Option -X should do the trick :-)


Vegard

-- 
"The animistic metaphor of the bug that maliciously sneaked in while
the programmer was not looking is intellectually dishonest as it
disguises that the error is the programmer's own creation."
	-- E. W. Dijkstra, EWD1036
