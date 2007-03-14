From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Make gc a builtin.
Date: Wed, 14 Mar 2007 02:05:11 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703140203250.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: 20070312144312.GE15150@spearce.org
 <11738270273757-git-send-email-jbowes@dangerouslyinc.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, spearce@spearce.org, junkio@cox.net
To: James Bowes <jbowes@dangerouslyinc.com>
X-From: git-owner@vger.kernel.org Wed Mar 14 02:05:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRHvc-0002V3-NR
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 02:05:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752678AbXCNBFR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Mar 2007 21:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752679AbXCNBFQ
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Mar 2007 21:05:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:53844 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752678AbXCNBFO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2007 21:05:14 -0400
Received: (qmail invoked by alias); 14 Mar 2007 01:05:12 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp023) with SMTP; 14 Mar 2007 02:05:12 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+QIsppx4yQ/o5dj68IrEtUuZ6CfDLtZCU2YaMFuS
	7YYQqDHBwj6W2V
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <11738270273757-git-send-email-jbowes@dangerouslyinc.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42160>

Hi,

On Tue, 13 Mar 2007, James Bowes wrote:

> Take 3. The changes are pretty much all of Shawn's suggestions. If a 
> command fails this code just returns -1, rather than calling error(), so 
> that two duplicate error messages aren't printed out.

If you say "return error(...);", there is _no_ way that multiple error 
messages are printed out.

If you say "return -1;", however, the user is likely to _never_ know that 
git-gc failed. (I, for one, do not check $? after running a program which 
does not say _anything_.)

Ciao,
Dscho
