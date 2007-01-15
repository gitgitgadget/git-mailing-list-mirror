From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Commit signing
Date: Mon, 15 Jan 2007 11:59:00 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701151149030.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200701151000.58609.andyparkins@gmail.com> <20070115101529.GB12257@spearce.org>
 <200701151042.12753.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jan 15 20:04:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@m.gmane.org
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6W2R-0000Sr-06
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 18:54:31 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1H6V9i-0003eK-Kx
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 17:57:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbXAOK7E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 05:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932218AbXAOK7E
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 05:59:04 -0500
Received: from mail.gmx.net ([213.165.64.20]:58730 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932214AbXAOK7C (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 05:59:02 -0500
Received: (qmail invoked by alias); 15 Jan 2007 10:59:00 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp036) with SMTP; 15 Jan 2007 11:59:00 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Andy Parkins <andyparkins@gmail.com>
In-Reply-To: <200701151042.12753.andyparkins@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36857>

Hi,

On Mon, 15 Jan 2007, Andy Parkins wrote:

> As an example of why this would be useful: let's say we have a developer 
> committing to a maintainer repository who then merges those changes into 
> mainline and pushes up to the central repository (like what happens with 
> Linux).  The commits to the central repository are made using the ssh 
> login of the maintainer, but they are adding commits by someone else.  
> What if that someone else isn't allowed to commit to the central?  With 
> signed commits the option is available to exclude them.

IMHO the thinko is the old CVS one. With git we _discourage_ a central 
repository where everybody pushes into. We _encourage_ local repositories, 
which are controlled by _one_ person.

If you need a central repository with one "official" version, then 
designate a release officer. This officer is responsible to keep the 
repository clean. And I _guarantee_ you that she can tell where she pulled 
bad commits from: it is written down in the "Merge from" message.

And BTW you have no option to exclude unsigned commits when pushing to a 
repository. It is either all in or all out.

Ciao,
Dscho
