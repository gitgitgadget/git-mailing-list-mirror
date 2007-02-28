From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-remote and remotes with '.' in their names
Date: Wed, 28 Feb 2007 16:10:51 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702281607220.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <87k5y5tlol.fsf@briny.internal.ondioline.org> <45E597CF.9000009@lu.unisi.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paul Collins <paul@briny.ondioline.org>, git@vger.kernel.org
To: Paolo Bonzini <paolo.bonzini@lu.unisi.ch>
X-From: git-owner@vger.kernel.org Wed Feb 28 16:10:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMQSF-0000bT-R6
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 16:10:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933006AbXB1PKy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 10:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933007AbXB1PKy
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 10:10:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:60601 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933006AbXB1PKx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 10:10:53 -0500
Received: (qmail invoked by alias); 28 Feb 2007 15:10:52 -0000
X-Provags-ID: V01U2FsdGVkX18WJLxgiyYWnCYLG+Om9xi3C4KC69qLU35kVbPfHh
	Uj2Q==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45E597CF.9000009@lu.unisi.ch>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40932>

Hi,

On Wed, 28 Feb 2007, Paolo Bonzini wrote:

> Hello,
> 
> >  	for (@remotes) {
> > -		if (/^remote\.([^.]*)\.(\S*)\s+(.*)$/) {
> > +		if (/^remote\.(.*)\.(\S*)\s+(.*)$/) {
> 
> You probably want either
> 
> +		if (/^remote\.(\S*)\.(\S*)\s+(.*)$/) {
> 
> or
> 
> +		if (/^remote\.(\S*)\.([^.]*)\s+(.*)$/) {

Did you mean to prevent the remote starting with a dot? IMHO that would be 
a good change, but AFAIS both your proposals don't do that.

Ciao,
Dscho
