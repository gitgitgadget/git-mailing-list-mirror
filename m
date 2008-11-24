From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH 4/4] Make git fetch verify signed tags
Date: Mon, 24 Nov 2008 11:44:40 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811241143410.30769@pacific.mpi-cbg.de>
References: <1227497000-8684-1-git-send-email-deskinm@umich.edu> <1227497000-8684-2-git-send-email-deskinm@umich.edu> <1227497000-8684-3-git-send-email-deskinm@umich.edu> <1227497000-8684-4-git-send-email-deskinm@umich.edu>
 <1227497000-8684-5-git-send-email-deskinm@umich.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Deskin Miller <deskinm@umich.edu>
X-From: git-owner@vger.kernel.org Mon Nov 24 11:37:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4YpE-0008Fg-FH
	for gcvg-git-2@gmane.org; Mon, 24 Nov 2008 11:37:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913AbYKXKgh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2008 05:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbYKXKgh
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Nov 2008 05:36:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:50637 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750806AbYKXKgg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2008 05:36:36 -0500
Received: (qmail invoked by alias); 24 Nov 2008 10:36:34 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp021) with SMTP; 24 Nov 2008 11:36:34 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+zpGAOufyz6Fo4gaCxjb9ADxkq7LfHd2S10ItoWs
	yuWYb5DYP9LlqX
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1227497000-8684-5-git-send-email-deskinm@umich.edu>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101597>

Hi,

On Sun, 23 Nov 2008, Deskin Miller wrote:

> When git fetch downloads signed tag objects, make it verify them right 
> then.  This extends the output summary of fetch to include "(good 
> signature)" for valid tags and "(BAD SIGNATURE)" for invalid tags.  If 
> the user does not have the correct key in the gpg keyring, gpg returns 
> 2, verify_tag_sha1 returns -2 and nothing additional is output about the 
> tag's validity.

This must be turned off by default, IMO.  You cannot expect each and every 
developer to have gpg _and_ all those public keys installed.

Ciao,
Dscho
