From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH] Add --show-size to git log to print message size
Date: Sun, 15 Jul 2007 20:45:38 +0200
Message-ID: <e5bfff550707151145w587c4c35l259516844c68e9aa@mail.gmail.com>
References: <e5bfff550707140952hb60735bi95a4f03636c4aa99@mail.gmail.com>
	 <7vodiehko7.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550707141346q2eba4ab8ka1c85e8b5a2c1b1d@mail.gmail.com>
	 <20070715093529.GD2568@steel.home>
	 <e5bfff550707150306t3196f723ia3071ac301fb3f24@mail.gmail.com>
	 <20070715104858.GG2568@steel.home>
	 <e5bfff550707150432v780d8361yba2fc729504d5b73@mail.gmail.com>
	 <e5bfff550707150529l7e9bdd9fu253d38f99d4d2ed7@mail.gmail.com>
	 <alpine.LFD.0.999.0707151110520.20061@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Alex Riesen" <raa.lkml@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Jul 15 20:45:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IA96C-0004YB-Tm
	for gcvg-git@gmane.org; Sun, 15 Jul 2007 20:45:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756066AbXGOSpk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 14:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755579AbXGOSpk
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 14:45:40 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:61836 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755568AbXGOSpj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 14:45:39 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1332109wah
        for <git@vger.kernel.org>; Sun, 15 Jul 2007 11:45:38 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YzZrdiZYjbiK9FaRdWpaG8VexpjLtOIybxlXe12b4Mew8gGYBRJsLZLW5qFOgWEcxqpHtQ0rKV3UBT35kGJPrfzPJ03+/g5h6gH0OLoLe3lShGkdlyVhv9NbMd1vaxETQqSexO8LY4J0qgTZQBQ2H8Dvfz0XxaNqyltJe8nTTbE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NuafmByTrnC/Ym+WM/6kxA7Dy/RS5efgEMxADHZBJHAUpDkhqq54t7VYgJMZlpVmaeX+mphIu41xnlK2ftWluYnz20bvLUu6ETfXgDt7deMjht46LzTL/MB4H3TZVuQVI62tykE31QRzpKUk3YnycGRRar3sYmYjmm1XpoHMO4w=
Received: by 10.114.144.1 with SMTP id r1mr3475064wad.1184525138608;
        Sun, 15 Jul 2007 11:45:38 -0700 (PDT)
Received: by 10.114.56.6 with HTTP; Sun, 15 Jul 2007 11:45:38 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.999.0707151110520.20061@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52576>

On 7/15/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
> So you could actually make the parsing really strict, and look for the
> sequence
>
>         '\n\0commit '
>
> and that's a very trustworthy delimeter.
>

Thanks to you and Sean for the hint, anyhow I would wish the message
size patch applied if it is possible and there are no drawbacks. Tool
that parses git-log output would benefit form that and the impact (in
code lines) is very low and also does not change anything if not
activated.

Thanks
Marco
