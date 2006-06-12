From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] gitweb: Adding a `blame' interface.
Date: Tue, 13 Jun 2006 00:55:34 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606130053400.25682@wbgn013.biozentrum.uni-wuerzburg.de>
References: <11500407193506-git-send-email-octo@verplant.org>
 <20060612213826.GC4705@c165.ib.student.liu.se>
 <Pine.LNX.4.63.0606130041260.25422@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0606121546320.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Fredrik Kuivinen <freku045@student.liu.se>,
	Florian Forster <octo@verplant.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 13 00:55:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpvJu-0007th-VN
	for gcvg-git@gmane.org; Tue, 13 Jun 2006 00:55:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752078AbWFLWzg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Jun 2006 18:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752075AbWFLWzg
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jun 2006 18:55:36 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:31206 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1752078AbWFLWzf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jun 2006 18:55:35 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 6C06D221F;
	Tue, 13 Jun 2006 00:55:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 6036621CD;
	Tue, 13 Jun 2006 00:55:34 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 36B071D55;
	Tue, 13 Jun 2006 00:55:33 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606121546320.5498@g5.osdl.org>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21750>

Hi,

On Mon, 12 Jun 2006, Linus Torvalds wrote:

> On Tue, 13 Jun 2006, Johannes Schindelin wrote:
> > 
> > On Mon, 12 Jun 2006, Fredrik Kuivinen wrote:
> > 
> > > git-blame is a bit faster than git-annotate and, as far as I know, it 
> > > produces output which is correct.
> > 
> > Yeah: Bring It On(tm)! I already waited for ages for this war to begin!
> 
> Sadly, I don't think either of you can really do much about the fact that 
> annotate/blame is simply the wrong model for git.
> 
> The war _I_d like to see is the GUI thing which does the "show when this 
> section changed last" by following the history down only so far that the 
> selected section shows up in the diff against the most current thing.

But this is just the next step! Nothing prevents you -- once everybody 
agrees that blame/annotate does the right thing -- to restrict the lines 
of interest. And AFAICT both blame and annotate are good at stopping when 
all lines are accounted for.

Ciao,
Dscho
