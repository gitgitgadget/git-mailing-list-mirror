From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] Add "--only-untracked" flag to status commands.
Date: Sat, 25 Aug 2007 16:42:10 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0708251639440.16728@wbgn129.biozentrum.uni-wuerzburg.de>
References: <4fcfda4a654b003f3ae3dc8d56424b5f59f48093.1187897406.git.v@pp.inet.fi>
 <20070823203246.GB3516@steel.home> <6D8BA2E0-50CD-4B7B-84D3-3D9A61421131@pp.inet.fi>
 <7v8x81s7d1.fsf@gitster.siamese.dyndns.org> <fann62$f5q$2@sea.gmane.org>
 <7v7inkcz2o.fsf@gitster.siamese.dyndns.org> <1529CBA9-860C-464D-AC78-BF75D0196894@pp.inet.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: =?ISO-8859-1?Q?V=E4in=F6_J=E4rvel=E4?= <v@pp.inet.fi>
X-From: git-owner@vger.kernel.org Sat Aug 25 16:42:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOwq8-0000OY-7d
	for gcvg-git@gmane.org; Sat, 25 Aug 2007 16:42:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759997AbXHYOmN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Aug 2007 10:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759964AbXHYOmN
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Aug 2007 10:42:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:48862 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755548AbXHYOmM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Aug 2007 10:42:12 -0400
Received: (qmail invoked by alias); 25 Aug 2007 14:42:10 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp001) with SMTP; 25 Aug 2007 16:42:10 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/NkElCCbTNyIGaPcdh8zbPAVn54Q/dzVWyajDEGf
	sjhEktCoWZFKd5
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <1529CBA9-860C-464D-AC78-BF75D0196894@pp.inet.fi>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56638>

Hi,

On Sat, 25 Aug 2007, V?in? J?rvel wrote:

> An example would be in game development, where I have a directory full 
> of images, and I wish to try out different images in the place of one. I 
> usually create different versions of the images with different names, 
> filling up the image directory under VCS.

I have a similar use case, funnily enough also with images.  I created a 
tmp/ directory and put the images there, cp'ing or ln -s'ing the current 
one into the cwd.  Then, "/tmp/" is put into .gitignore and all is well.

Especially the fact that I no longer forget to check in the images that I 
_do_ want to track.

Ciao,
Dscho
