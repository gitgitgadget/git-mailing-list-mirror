From: Valentin Haenel <valentin@fsfe.org>
Subject: Re: question about interactive.singlekey
Date: Tue, 6 Sep 2011 23:33:26 +0200
Message-ID: <20110906213326.GD1747@kudu.in-berlin.de>
References: <20110906205011.GC1747@kudu.in-berlin.de> <7vsjo9743o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git-List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 06 23:33:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R13HC-0008GL-Ae
	for gcvg-git-2@lo.gmane.org; Tue, 06 Sep 2011 23:33:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750958Ab1IFVda (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Sep 2011 17:33:30 -0400
Received: from kudu.in-berlin.de ([192.109.42.123]:36347 "EHLO
	kudu.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744Ab1IFVd3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2011 17:33:29 -0400
Received: from kudu.in-berlin.de (localhost [127.0.0.1])
	by kudu.in-berlin.de (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id p86LXQ3w017939;
	Tue, 6 Sep 2011 23:33:26 +0200
Received: (from esc@localhost)
	by kudu.in-berlin.de (8.14.3/8.14.3/Submit) id p86LXQNL017938;
	Tue, 6 Sep 2011 23:33:26 +0200
X-Authentication-Warning: kudu.in-berlin.de: esc set sender to valentin@fsfe.org using -f
Content-Disposition: inline
In-Reply-To: <7vsjo9743o.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180839>

* Junio C Hamano <gitster@pobox.com> [110906]:
> Valentin Haenel <valentin@fsfe.org> writes:
> 
> > i have recently installed debian on my laptop. I discovered that the
> > 'interactive.singlekey' setting does not seem to work. On my desktop,
> > which has been debian for a while it does work. These are both debian
> > stable and have the exact same version of git v1.7.2.5, but
> > perhaps slightly different packages of other software installed. Does
> > the 'interactive.singlekey' setting perhaps need additional libraries
> > which were forgotten in the debian package dependencies?
> 
> I see this:
> 
>         eval {
>                 require Term::ReadKey;
>                 Term::ReadKey->import;
>                 $use_readkey = 1;
> 
> so perhaps...
> 
>     $ apt-cache search term.*readkey
>     libterm-readkey-perl - A perl module for simple terminal control

Bingo! Thanks! Should i send this downstream somewhere?

V-
