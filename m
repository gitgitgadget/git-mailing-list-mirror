From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Amusement: ASCII Art generator
Date: Sun, 4 Mar 2007 02:49:26 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703040245540.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0703040240190.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 04 02:49:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNfqt-00072V-BS
	for gcvg-git@gmane.org; Sun, 04 Mar 2007 02:49:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932632AbXCDBt2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Mar 2007 20:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932647AbXCDBt2
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Mar 2007 20:49:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:50548 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932632AbXCDBt2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2007 20:49:28 -0500
Received: (qmail invoked by alias); 04 Mar 2007 01:49:26 -0000
X-Provags-ID: V01U2FsdGVkX19EX+oIPa5Ea8G+Q3y0KCU9onWhVXtKC3XtZcg9kO
	Yh3cBTHGNmLJwQ
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.63.0703040240190.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41343>

Hi,

On Sun, 4 Mar 2007, Johannes Schindelin wrote:

> Hi,
> 
> a few days ago, I posted an ASCII representation of a commit graph. This 
> was really tedious, so I wrote a simple script to generate it (and also to 
> prove that I am not making everything a builtin). It takes revision range 
> arguments, so if you call it with '-25 229ed74' on the git repository, you 
> will get this:
> 
> A---C-----F---------------------Q---------------Y
>    /     /                     /               /
>   B   D-E   G-------K-------O-P---R---T-U-V-W-X
>                            /         ,-----'
>               H-I-J---L-M-N---------S

Sidenote: this script is really dumb, and checks collisions only 
occasionally, but it works sometimes. Obviously, I chose an example where 
it works :-)

Ciao,
Dscho
