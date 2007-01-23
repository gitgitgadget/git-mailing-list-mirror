From: Bill Lear <rael@zopyra.com>
Subject: Re: [Announce] GIT v1.5.0-rc2
Date: Tue, 23 Jan 2007 14:31:43 -0600
Message-ID: <17846.28847.436225.732284@lisa.zopyra.com>
References: <7v64b04v2e.fsf@assigned-by-dhcp.cox.net>
	<eovccc$usc$1@sea.gmane.org>
	<Pine.LNX.4.63.0701211207500.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<17846.20498.635623.173653@lisa.zopyra.com>
	<Pine.LNX.4.63.0701232012120.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<17846.27694.845530.663964@lisa.zopyra.com>
	<20070123202231.GA2765@cepheus>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 23 21:32:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9SK0-00066Y-FZ
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 21:32:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933128AbXAWUcA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 23 Jan 2007 15:32:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933132AbXAWUcA
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 15:32:00 -0500
Received: from mail.zopyra.com ([65.68.225.25]:61768 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933128AbXAWUb7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Jan 2007 15:31:59 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l0NKVo232726;
	Tue, 23 Jan 2007 14:31:50 -0600
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
In-Reply-To: <20070123202231.GA2765@cepheus>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37567>

On Tuesday, January 23, 2007 at 21:22:32 (+0100) Uwe Kleine-K=F6nig wri=
tes:
>> % export PAGER=3Dless
>> % unset LESS
>> % git diff
>>=20
>> I get 30 lines of output in my current repository, as I should.
>>=20
>> If I then do this:
>>=20
>> % LESS=3D-FRS git diff
>What about:
>
>	LESS=3D-FRSX git diff

Well, I see output when there is output to show, yes, but it still
blanks the screen --- or, I should say, scrolls all the way to the
bottom --- when there is no difference to show.

I do note that if LESS is not set, git sets it (in pager.c) to just
what you have above (FRSX).


Bill
