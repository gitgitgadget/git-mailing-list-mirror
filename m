From: Johan Herland <johan@herland.net>
Subject: Re: [PATCHv3 1/8] Introduce commit notes
Date: Thu, 30 Jul 2009 02:42:38 +0200
Message-ID: <200907300242.38844.johan@herland.net>
References: <1248834326-31488-1-git-send-email-johan@herland.net>
 <1248834326-31488-2-git-send-email-johan@herland.net>
 <81b0412b0907290152w27c1b5b5l9efbd6980d4f904e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: Alex Riesen <raa.lkml@gmail.com>, gitster@pobox.com,
	johannes.schindelin@gmx.de, trast@student.ethz.ch,
	tavestbo@trolltech.com, git@drmicha.warpmail.net,
	chriscool@tuxfamily.org, spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 30 02:42:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWJjL-0004JI-92
	for gcvg-git-2@gmane.org; Thu, 30 Jul 2009 02:42:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754897AbZG3Amk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 20:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754802AbZG3Amk
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 20:42:40 -0400
Received: from mx.getmail.no ([84.208.15.66]:55466 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754752AbZG3Amk (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jul 2009 20:42:40 -0400
Content-disposition: inline
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KNK008QEKN3A4B0@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 30 Jul 2009 02:42:39 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KNK00IK4KN3T210@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 30 Jul 2009 02:42:39 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.7.30.2717
User-Agent: KMail/1.11.4 (Linux/2.6.30-ARCH; KDE/4.2.4; x86_64; ; )
In-reply-to: <81b0412b0907290152w27c1b5b5l9efbd6980d4f904e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124426>

On Wednesday 29 July 2009, Alex Riesen wrote:
> On Wed, Jul 29, 2009 at 04:25, Johan Herland<johan@herland.net> wrote:
> > +void get_commit_notes(const struct commit *commit, struct strbuf *sb,
> > +               const char *output_encoding)
> > +{
> > +       static const char *utf8 = "utf-8";
>
> Using an array
>
>   const char utf8[] = "utf-8";
>
> costs you less BSS (no separate storage for the pointer).

Thanks, will be fixed in the next iteration of this topic.

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
