From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: Re: [PATCH] t6006-*.sh: Fix truncation tests
Date: Wed, 21 May 2014 08:11:00 +0400
Message-ID: <20140521041100.GA10495@dell-note>
References: <537B5E8C.3070803@ramsay1.demon.co.uk>
 <20140520141936.GA30187@ashu.dyn1.rarus.ru>
 <xmqqr43o1ill.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 21 06:11:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmxsD-0000WP-DF
	for gcvg-git-2@plane.gmane.org; Wed, 21 May 2014 06:11:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbaEUELJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 00:11:09 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:55574 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750982AbaEUELH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 00:11:07 -0400
Received: by mail-lb0-f174.google.com with SMTP id n15so1115264lbi.5
        for <git@vger.kernel.org>; Tue, 20 May 2014 21:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=O8C0T3SuY71AEQ5nTwC75sBpY7GiwD4VontPLBty7gc=;
        b=bdavxpMxmI+UP9TIY9Q9KPMoPmg6jK7iELlQLZXc6GZDz+HEmaW5vSCqi0sCf676GW
         taDTAMXs38pfAmRIrmIoNcIwo6Bhn69aFD0a4dUEUT6L7zTW4GZtTRzDSAhFFtm+PWDW
         +qH7YgIJAlByrDDzEiQLx2YLeE9UXpmVTJC8a+7lix0YRdC0Y10CSmmByILKd9CfcYmK
         aG5gjUh/t+3KBjBahwrR7z81Ziv3Fn0l9vUhDQee1yD/fW2RKJJhoGBqyuZ9OJaQIJ/5
         I2EGRMHE4bRE0SFymuuMLOgbCJrNdjXxG+aq0sj8qQ16YhDfkloa3pNDsD33kwFskEt5
         Nj/Q==
X-Received: by 10.152.29.66 with SMTP id i2mr996886lah.82.1400645466056;
        Tue, 20 May 2014 21:11:06 -0700 (PDT)
Received: from localhost (ppp91-77-214-38.pppoe.mtu-net.ru. [91.77.214.38])
        by mx.google.com with ESMTPSA id an10sm24470342lac.4.2014.05.20.21.11.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 May 2014 21:11:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqr43o1ill.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249773>

On Tue, May 20, 2014 at 10:10:46AM -0700, Junio C Hamano wrote:
> Alexey Shumkin <alex.crezoff@gmail.com> writes:
> 
> > AFAIU, Junio already applied my patches (existance of a branch
> > as/pretty-truncate tells us that). So, we can only send other patches that
> > fix errors brought with former patches.
> 
> No, NO, NOOOOO....
> 
> The existence of a branch merely means that I saw the patches, and
> that I thought that the series was not completely useless.  In other
> words, it indicates that I wanted to make sure that I won't forget
> about the topic, and it was worth my time to create the branch and
> apply there for that purpose.
Oh, I got it!
I'll fix my typo (ISO8895-1 vs ISO8859-1) and quotes issue then.
And will reroll patches.

Thanks!
> 
> Please do not read anything more than that.  Presense of a topic
> branch by itself does not say that I _read_ the patches or I thought
> they did not need reroll.
> 
> When such a branch is merged to 'next', that means I read the
> patches myself, or I saw somebody whose judgement I and others in
> the community trust read them and gave a positive response or an
> Ack, and that I decided that the topic is in a good enough shape to
> be worked on further with incremental updates.
> 
> You are talking about the latter state, but as/pretty-truncate is in
> the former state.
