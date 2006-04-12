From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Adding color to git diff output.
Date: Wed, 12 Apr 2006 09:38:55 +0200
Message-ID: <81b0412b0604120038q2e4aef8cn55ba4cfa68e18b34@mail.gmail.com>
References: <BAYC1-PASMTP08B0DB32592225AAD0838AAECD0@CEZ.ICE>
	 <7virpf4sg4.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0604111725590.14565@g5.osdl.org>
	 <BAYC1-PASMTP119CAD2588D00764DB3EA3AEC20@CEZ.ICE>
	 <Pine.LNX.4.64.0604111801270.14565@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: sean <seanlkml@sympatico.ca>, junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 12 09:39:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FTZwR-0004ZE-Lb
	for gcvg-git@gmane.org; Wed, 12 Apr 2006 09:39:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbWDLHi5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Apr 2006 03:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932095AbWDLHi5
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Apr 2006 03:38:57 -0400
Received: from pproxy.gmail.com ([64.233.166.181]:32210 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932090AbWDLHi4 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Apr 2006 03:38:56 -0400
Received: by pproxy.gmail.com with SMTP id i49so1616550pye
        for <git@vger.kernel.org>; Wed, 12 Apr 2006 00:38:55 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JsCDEQwTsDuSyoyDdf/lW/gOIGr+entGBKiPBGH8/4vdEVSs42zzxUJw+4Bp+iFmZQf/6IaB5H1f0XKjU7oL0lvJeq0UHsQ1tq2EfbY7AWZoVqsuFNXuovHJ2yaTV+9tMZ40W6R22KFx6qhUqmDfixM/EvFbiX40ghDoS0t0KXA=
Received: by 10.35.96.11 with SMTP id y11mr492255pyl;
        Wed, 12 Apr 2006 00:38:55 -0700 (PDT)
Received: by 10.35.41.18 with HTTP; Wed, 12 Apr 2006 00:38:55 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604111801270.14565@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18627>

On 4/12/06, Linus Torvalds <torvalds@osdl.org> wrote:
> +if [ "$GIT_DIFF_PAGER" ] && tty -s <&1; then

Maybe use "-t" here? I have at least one system which has no tty installed.
Like this:

  if [ -n "$GIT_DIFF_PAGER" -a -t ]; then
...
