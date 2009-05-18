From: Geoff Russell <geoffrey.russell@gmail.com>
Subject: Re: [PATCH] Documentation: clarify / requirement in 'git 
	check-ref-format'
Date: Mon, 18 May 2009 12:06:34 +0930
Message-ID: <93c3eada0905171936u2e6d67d5mc7eb80936b710a6b@mail.gmail.com>
References: <alpine.LNX.2.00.0905131051240.2147@iabervon.org>
	 <1242229386-27486-1-git-send-email-git@drmicha.warpmail.net>
Reply-To: geoffrey.russell@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon May 18 04:36:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5siZ-0002lV-2A
	for gcvg-git-2@gmane.org; Mon, 18 May 2009 04:36:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754200AbZERCgf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 May 2009 22:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753021AbZERCge
	(ORCPT <rfc822;git-outgoing>); Sun, 17 May 2009 22:36:34 -0400
Received: from mail-qy0-f180.google.com ([209.85.221.180]:40026 "EHLO
	mail-qy0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751580AbZERCge convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 May 2009 22:36:34 -0400
Received: by qyk10 with SMTP id 10so860480qyk.33
        for <git@vger.kernel.org>; Sun, 17 May 2009 19:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=DepWNnL8jJ1WGG3NYk7p2rJCQOpYy039w5F4Pr9l/ic=;
        b=mFUko+a4htJuJdMGM51Jg0wJ4HyQOXDg05UMkypfLqWfd6y+RI36GhXJD5k1XEWq4c
         z4mpJADDupjkH1o0Hr2MIBWNWC2ooAd+L+Vep7bWu+/2iiuaJ2Cnv5yU/Tv7hUv5GVAA
         E3K9lMVWx5m89nFVr901vIMismOoXLtr6krpg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=dh6GEsmulQUfi4q1i+5rWQnhTZDRKJD7fQVaOOfTZMqwofZyUyFf6HO4Db8FlFfqmt
         tdnwewtP9K0x77Q9rINEKQNDXjZY/5SeZwajOPwBu5YYI+W/7PlyHgJxGs7yUgjNDYvi
         fR89NP3vX51hYPo0TnrAZVm9Qtjsy3Q/Ryg/o=
Received: by 10.220.84.202 with SMTP id k10mr6433463vcl.77.1242614194753; Sun, 
	17 May 2009 19:36:34 -0700 (PDT)
In-Reply-To: <1242229386-27486-1-git-send-email-git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119412>

On Thu, May 14, 2009 at 1:13 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> 'git check-ref-format' checks for the presence of at least one '/', t=
he
> idea being that there should be no refs directly below 'refs/', so th=
ere
> should be a category like 'heads/' or 'tags/' in a refname.
>
> Try and make this clearer in the man page.
>
> [....snip]
> +. They must contain at least one `/`. This enforces the presence of =
a
> + =A0category like `heads/`, `tags/` etc. but the actual names are no=
t
> + =A0restricted.
> +
> =A0. They cannot have two consecutive dots `..` anywhere.
>
> [ ...snip]

Ah, okay. This is clear. Many thanks.

Cheers,
Geoff
