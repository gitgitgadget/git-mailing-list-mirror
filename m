From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add a remote.<foo>.mirror configuration option
Date: Sat, 19 Apr 2008 18:33:50 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804191832080.20708@eeepc-johanness>
References: <S1755276AbYDQLcT/20080417113219Z+797@vger.kernel.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Sat Apr 19 20:12:00 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JnGxO-0006zy-Ko
	for gcvg-git-2@gmane.org; Sat, 19 Apr 2008 19:34:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751509AbYDSRdf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2008 13:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754696AbYDSRdf
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Apr 2008 13:33:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:47773 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750918AbYDSRde (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Apr 2008 13:33:34 -0400
Received: (qmail invoked by alias); 19 Apr 2008 17:33:32 -0000
Received: from R2c2d.r.pppool.de (EHLO eeepc-johanness.st-andrews.ac.uk) [89.54.44.45]
  by mail.gmx.net (mp009) with SMTP; 19 Apr 2008 19:33:32 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19vmtEIuzpv/vZtmwc854zKCI+laOeZEP/88wuZrm
	locLHkXiprS6PS
X-X-Sender: user@eeepc-johanness
In-Reply-To: <S1755276AbYDQLcT/20080417113219Z+797@vger.kernel.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79907>

Hi,

On Thu, 17 Apr 2008, Paolo Bonzini wrote:

> This patch adds a remote.<foo>.mirror configuration option that,
> when set, automatically puts git-push in --mirror mode for that
> remote.

Would it not be more logical to have remote.<nick>.pushOptions? (This 
would be in line with the branch.<name>.mergeOptions config setting...

Ciao,
Dscho
