From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: denying branch creation in a shared repository
Date: Mon, 19 Oct 2009 11:57:58 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0910191155310.4985@pacific.mpi-cbg.de>
References: <ee22b09e0910190132u20931fb4i6a98fb87582a9e56@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Mohit Aron <mohit.aron@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 19 11:55:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzoxT-0002oh-Qb
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 11:55:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754523AbZJSJzG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2009 05:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753898AbZJSJzG
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 05:55:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:34553 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752512AbZJSJzE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2009 05:55:04 -0400
Received: (qmail invoked by alias); 19 Oct 2009 09:55:08 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp014) with SMTP; 19 Oct 2009 11:55:08 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18CHThpi3ICZeOZsemzRIQN4FLT7kVaY7iipB5Wfn
	nNsZwwBCTggioj
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <ee22b09e0910190132u20931fb4i6a98fb87582a9e56@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130685>

Hi,

On Mon, 19 Oct 2009, Mohit Aron wrote:

> I'm setting up a shared repository and I'd like to prevent users from 
> creating branches in it (they can of course create local branches in 
> their own clone of this repository). How can I accomplish this ? I 
> looked at 'git help config' and it seems I need something similar to the 
> parameter receive.denyDeletes - this prevents deletion of branches.

The easiest way to accomplish things is to look who had the same problem 
and solved it:

http://repo.or.cz/w/repo.git?a=blob;f=update-hook;h=98b419ecad61f6c80f;hb=6f92e96db0d605bed50db99029172607af301792#l16

Hth,
Dscho
