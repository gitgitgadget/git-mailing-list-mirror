From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git smart protocol via WebSockets - feedback wanted
Date: Tue, 5 Jun 2012 11:36:28 -0700
Message-ID: <CAJo=hJtUbuWrVjVMAZirgD2O3f4TXa8YSYURSLUB5t3AD8Czig@mail.gmail.com>
References: <jqlim2$6vt$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Stephan Peijnik <stephan@peijnik.at>
X-From: git-owner@vger.kernel.org Tue Jun 05 20:36:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sbycg-0006QD-JY
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 20:36:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755636Ab2FESgu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 14:36:50 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:33597 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754680Ab2FESgt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2012 14:36:49 -0400
Received: by dady13 with SMTP id y13so7656100dad.19
        for <git@vger.kernel.org>; Tue, 05 Jun 2012 11:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=62lQw3vCGDP3kfGx72wKKcAcldCCf8WEJHpl9USPdx0=;
        b=T9eQe47CS7rRbaZVU2Cg7wqWf3SD5gkFt2oq9qiFT87t37KBxgnRhPzcGHiHy7kgdU
         p9dUssaV0w2cY8u26G/AkPDrhOyBha5hlzC3N6scXYhq7asUYGLMjm4eFkZqC9HRtx0n
         aM0f5jmJwgfuv7QRnQ9/gh0eyc5kK9hRBwQsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=62lQw3vCGDP3kfGx72wKKcAcldCCf8WEJHpl9USPdx0=;
        b=KIzUNpwb0NQtJ5J435FaWYF1o3ChnM5veKv6GWLhQHLXVFaiy45ILKUFzurntnIiZE
         IvW1VQiiOHEwYbszUriUUu75XdVlEqW8UG+cHP7fnd5Fr5iVLmk7n7S0Jh+UMqY0f7a8
         EIfaBmII6Bsh1TJIrM9eOSk1ZzlH/Amv+LFVc+DtlhK/GCbzaXbrVF8ngA7mZcV2XZv7
         RbiObCMXuclLMVoC4r16QpQP6D/ofyWG0k2Z9xhvB2MpJTdN9rvxXQ8g+5/5PtkeBU4S
         GOA1PdBT22RLUDKCzuQcd6B+JoNR3TJMEWLWJULalR1QtVI60x/mxae0GsuJRQVuZnnH
         mhhg==
Received: by 10.68.219.7 with SMTP id pk7mr36905925pbc.36.1338921409203; Tue,
 05 Jun 2012 11:36:49 -0700 (PDT)
Received: by 10.68.52.169 with HTTP; Tue, 5 Jun 2012 11:36:28 -0700 (PDT)
In-Reply-To: <jqlim2$6vt$1@dough.gmane.org>
X-Gm-Message-State: ALoCoQm5WI0uGmXO83N5AT+b2DOM/UZZgF7QEEu92YlksOsSiZB7pjJXB7xl297du3bQQTjVlr7p
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199278>

On Tue, Jun 5, 2012 at 11:20 AM, Stephan Peijnik <stephan@peijnik.at> wrote:
> Since I have been working on a proof of concept showing that git's smart
> protocol can be tunneled via WebSocket connections quite easily [0] I wanted
> to ask for some feedback on the idea in general and on my implementation
> [1].
>
> So, basically, what do you think about tunneling git's smart protocol via
> WebSockets (and thus HTTP)?
...
> [0]
> http://blog.sp.or.at/2012/06/git-smart-protocol-via-websockets-proof.html
> [1] https://github.com/speijnik/gitws

How does this compare with the smart HTTP protocol that has been
supported since Git 1.6.6, and uses the git-http-backend CGI at the
server side?
