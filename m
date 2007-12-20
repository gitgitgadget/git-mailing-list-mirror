From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Serious bug with pretty format strings & empty bodies?
Date: Thu, 20 Dec 2007 13:37:13 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0712201336200.14355@wbgn129.biozentrum.uni-wuerzburg.de>
References: <57518fd10712190632o490af924n61326fddf1819014@mail.gmail.com> 
 <20071219184457.GC3015@steel.home>  <57518fd10712191437s6f192feds50d006fdfc624444@mail.gmail.com>
  <4769A7FB.1070904@lsrfire.ath.cx> <57518fd10712200244o656c7f44j426cc71c89515de3@mail.gmail.com>
 <476A5DFF.40803@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jonathan del Strother <maillist@steelskies.com>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu Dec 20 13:37:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5Kej-0000zP-Hi
	for gcvg-git-2@gmane.org; Thu, 20 Dec 2007 13:37:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758804AbXLTMhS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2007 07:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758777AbXLTMhR
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Dec 2007 07:37:17 -0500
Received: from mail.gmx.net ([213.165.64.20]:58919 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753538AbXLTMhQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2007 07:37:16 -0500
Received: (qmail invoked by alias); 20 Dec 2007 12:37:13 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp007) with SMTP; 20 Dec 2007 13:37:13 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/DA7wb7EjDm01GKU4HjksA527PS+30+29WnCQbEf
	5dGVdjHHGUJ/x2
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <476A5DFF.40803@lsrfire.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69002>

Hi,

On Thu, 20 Dec 2007, Ren? Scharfe wrote:

> The second chunk keeps the body offset from being incremented by the for 
> loop if we've already found a terminating NUL.

Ah!  I missed that one *writethisdownintothebook*

Thanks,
Dscho
