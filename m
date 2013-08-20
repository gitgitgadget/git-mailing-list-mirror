From: Nazri Ramliy <ayiehere@gmail.com>
Subject: Re: Does Git now have any C struct version history tracking mechanism?
Date: Tue, 20 Aug 2013 11:55:17 +0800
Message-ID: <CAEY4ZpM6U38piim_uY5KgaZX=1KkYF4WaMxR9HeywAp4AO9igw@mail.gmail.com>
References: <CAHz2CGW_xR4Q193h2itCELdXEpoAxetj324ATstALHM03cSvFg@mail.gmail.com>
	<CAEY4ZpO3x-B7SKQa+Djtt_AfQ7y=nNBZ1sR9Gvv8d3FvQLK1PA@mail.gmail.com>
	<87y57y84a1.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Zhan Jianyu <nasa4836@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Aug 20 05:55:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBd2S-0002dK-VG
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 05:55:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751959Ab3HTDzU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Aug 2013 23:55:20 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:52659 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751804Ab3HTDzT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Aug 2013 23:55:19 -0400
Received: by mail-la0-f43.google.com with SMTP id ep20so3925653lab.16
        for <git@vger.kernel.org>; Mon, 19 Aug 2013 20:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=PmVMwc4wVTuZyL4hGnjETFmOuLPpWRCpqEgpT1t43is=;
        b=pNZJOoj91bdsMNiPNfH2dcKzaDmoAaSTre4W3Ed3ZXMlk5YXbDKoqjKp8JaooE3EKN
         X6Zf5yVjKdVP/C9k+6+8X6/P2649gj8KsP/S2UdDWenHmkJ6fgQOPYu8+Zb/XJbvkHtM
         i4mjzKrkp4gy0afwoMsUmlzHsXi/tG3KDuhsrge9yW3B+xvRwrcimQccr0eOCmNc5E91
         8aQmiip0vIujbYIGz7aeRy9nif7xftTbD843Be1f3bZpTHvqoOT98JK8bwWYQ6hXbJ/a
         C6JPq1o1bLUEZSGgyyxutbYFNkARpzs7Xq06mC2Jwf3P6S2og0/t6iXckmpLTU50sIwk
         4Qsg==
X-Received: by 10.112.35.52 with SMTP id e20mr1015258lbj.11.1376970917943;
 Mon, 19 Aug 2013 20:55:17 -0700 (PDT)
Received: by 10.112.150.162 with HTTP; Mon, 19 Aug 2013 20:55:17 -0700 (PDT)
In-Reply-To: <87y57y84a1.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232581>

On Mon, Aug 19, 2013 at 4:37 PM, Thomas Rast <trast@inf.ethz.ch> wrote:
> Hmm, IIUC that's actually not a bug or even a roughness; it's an
> artifact of how the :pattern:file syntax is defined.  It takes the first
> _funcname line_ matching 'pattern', up to (but excluding) the next
> funcname line.
>
...
> Or is there an issue that I'm missing?

No you're correct. I should have used the following instead for the demo:

    $ git log -L /struct\ rev_cmdline_info/,/^}/:revision.h

Moral: You'd hit your target better if you work on your aim.

nazri
