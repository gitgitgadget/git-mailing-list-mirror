From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 1/3] log: Show reflog date with --date=normal
Date: Tue, 28 Jul 2009 13:53:06 +0200
Message-ID: <200907281353.07590.trast@student.ethz.ch>
References: <1e2f7d731286d99b74cc9af37beb5fe187e9d460.1248770042.git.trast@student.ethz.ch> <alpine.DEB.1.00.0907281248040.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 28 13:53:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVlFG-0002Ox-9I
	for gcvg-git-2@gmane.org; Tue, 28 Jul 2009 13:53:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753303AbZG1LxS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2009 07:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753257AbZG1LxR
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 07:53:17 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:39282 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752776AbZG1LxR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2009 07:53:17 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 28 Jul 2009 13:53:16 +0200
Received: from thomas.localnet ([129.132.153.233]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 28 Jul 2009 13:53:15 +0200
User-Agent: KMail/1.12.0 (Linux/2.6.27.25-0.1-default; KDE/4.2.98; x86_64; ; )
In-Reply-To: <alpine.DEB.1.00.0907281248040.8306@pacific.mpi-cbg.de>
X-OriginalArrivalTime: 28 Jul 2009 11:53:15.0984 (UTC) FILETIME=[FDF82D00:01CA0F79]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124241>

Johannes Schindelin wrote:
> Hi,
> 
> On Tue, 28 Jul 2009, Thomas Rast wrote:
> 
> > This means that 'git log -g --date=normal' shows the date, whereas 'git 
> > log -g --date=default' shows the reflog entry number.
> 
> I find this highly unintuitive, sorry.  I'd prefer it if it showed the 
> date whenever I specify a date format.

So you'd rather have a toggle --[no-]reflog-date?  Which would make a
lot of sense, but probably not be backwards compatible in the sense
that log.date suddenly stops affecting the reflog date display.

> And I'd prefer not to have a distinction between "default" and
> "normal".

I actually had to change that because I wanted to allow the user to
override the log.date config.  Saying --date=unspecified doesn't make
a lot of sense :-)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
