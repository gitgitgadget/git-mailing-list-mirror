From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: copy selected history between repostories
Date: Sat, 19 Jul 2008 03:12:55 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807190311440.3064@eeepc-johanness>
References: <18533605.post@talk.nabble.com> <20080719010122.GA12047@mail.local.tull.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: luisgutz <luis@xmos.com>, git@vger.kernel.org
To: Nick Andrew <nick@nick-andrew.net>
X-From: git-owner@vger.kernel.org Sat Jul 19 03:13:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KK10X-0003vX-IU
	for gcvg-git-2@gmane.org; Sat, 19 Jul 2008 03:13:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756727AbYGSBMM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 21:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758636AbYGSBMM
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 21:12:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:44209 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758629AbYGSBMK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 21:12:10 -0400
Received: (qmail invoked by alias); 19 Jul 2008 01:12:08 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp061) with SMTP; 19 Jul 2008 03:12:08 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1++TpMsZ1y+ytbe+w/aWSiZaiZyfJDQOibEZwXACP
	RCM1EYka2FiPOI
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080719010122.GA12047@mail.local.tull.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.74
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89093>

Hi,

On Sat, 19 Jul 2008, Nick Andrew wrote:

> 	myfilter scripts=bin perllib=lib < mbox > mbox2

Note that if your repository only contains text files, "git fast-export | 
my-filter | git fast-import --force" would have worked faster, probably.

But I am glad you figured out how to do what you wanted to do.

Ciao,
Dscho
