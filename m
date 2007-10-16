From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: RE: Is there any plan to support partial checkout or submoudule
 improvement?
Date: Tue, 16 Oct 2007 12:02:38 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710161158350.25221@racer.site>
References: <20071016082720.E5EDA7E6F@mail.kooxoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: 'Lars Hjemli' <hjemli@gmail.com>, git@vger.kernel.org
To: franky <yinping@kooxoo.com>
X-From: git-owner@vger.kernel.org Tue Oct 16 13:03:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhkCR-0004x6-1I
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 13:02:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbXJPLCs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 07:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755190AbXJPLCs
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 07:02:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:35555 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755001AbXJPLCr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 07:02:47 -0400
Received: (qmail invoked by alias); 16 Oct 2007 11:02:45 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp017) with SMTP; 16 Oct 2007 13:02:45 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19swZ9Y+LFs5fjfnRaP4BoGk4MORL4JgQQD+BVgdb
	8jize0udJtKRk2
X-X-Sender: gene099@racer.site
In-Reply-To: <20071016082720.E5EDA7E6F@mail.kooxoo.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61145>

Hi,

[please do not top post.  Only keep the parts of the original message that 
you are responding to, and put your answers just below.  It is a matter of 
simple economy: it takes you just a couple of minutes, but spares those 
"millions" of readers the minutes to understand what you're talking about.  
In addition, it is a matter of politeness.]

On Tue, 16 Oct 2007, franky wrote:

> I want a single "git-pull" to deploy a new version and a
> single "git-reset" to back to versions before [on partial checkouts]

You are talking as if your partial checkout was a project in its own 
right.  Then make it so.  Do not use a partial checkout, but make that a 
submodule.

One reason _not_ to support partial checkouts is exactly to avoid people 
falling into that mousetrap of thinking that they can sensibly merge 
_parts_ of the HEAD.

Ciao,
Dscho
