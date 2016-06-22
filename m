Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8965A20189
	for <e@80x24.org>; Wed, 22 Jun 2016 12:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752672AbcFVMS2 (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 08:18:28 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:44789 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752437AbcFVMS1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Jun 2016 08:18:27 -0400
Received: (qmail 15390 invoked from network); 22 Jun 2016 12:11:45 -0000
Received: (qmail 2945 invoked from network); 22 Jun 2016 12:11:45 -0000
Received: from unknown (HELO linux-omuo.localnet) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPSA
          for <davvid@gmail.com>; 22 Jun 2016 12:11:43 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:	Vasco Almeida <vascomalmeida@sapo.pt>
To:	David Aguilar <davvid@gmail.com>
Cc:	git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 11/11] i18n: difftool: mark warnings for translation
Date:	Wed, 22 Jun 2016 12:11:42 +0000
Message-ID: <5354555.yybFPhJLf8@linux-omuo>
User-Agent: KMail/4.14.10 (Linux/4.1.26-21-default; KDE/4.14.18; x86_64; ; )
In-Reply-To: <20160622043329.GA31643@gmail.com>
References: <20160621114413.9467-1-vascomalmeida@sapo.pt> <20160621114413.9467-11-vascomalmeida@sapo.pt> <20160622043329.GA31643@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

A Terça, 21 de Junho de 2016 21:33:29 David Aguilar escreveu:
> I'm assuming that the i18n infrastructure is prepared to deal
> with perl's . dot syntax for string concatenation, though, and
> I don't know whether that's true.  Does that work?

Yes, dot syntax does work. xgettext is able to extract those string to pot 
file.
There is an example using it in gettext manual [1].
> 
> What do you think?

I think that is a good suggestion. It is easier on the eyes. Thank you.
I'll include this in the next re-roll.

[1] https://www.gnu.org/software/gettext/manual/html_node/Long-Lines.html#Long-Lines
