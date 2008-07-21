From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH for master] Rename path_list to string_list
Date: Tue, 22 Jul 2008 01:33:45 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807220131590.3407@eeepc-johanness>
References: <alpine.DEB.1.00.0807211858330.8986@racer> <alpine.DEB.1.00.0807211904090.8986@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jul 22 01:33:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KL4t9-0008AM-1e
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 01:33:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbYGUXc4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 19:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750939AbYGUXc4
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 19:32:56 -0400
Received: from mail.gmx.net ([213.165.64.20]:56481 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750728AbYGUXcz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 19:32:55 -0400
Received: (qmail invoked by alias); 21 Jul 2008 23:32:53 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness) [88.107.142.10]
  by mail.gmx.net (mp068) with SMTP; 22 Jul 2008 01:32:53 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+7alBAiJS7Kv47qfsIPjA6XzhZ875zhjXMSkuMoA
	A8Gu4wB8s/5wV3
X-X-Sender: user@eeepc-johanness
In-Reply-To: <alpine.DEB.1.00.0807211904090.8986@racer>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.75
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89417>

Hi,

On Mon, 21 Jul 2008, Johannes Schindelin wrote:

>  my-prepare-patch.sh                         |    2 +-

As was pointed out to me privately, this should not have been part of the 
interdiff.  It is the script I used to prepare the interdiff, and it 
needed fixing in order to run without "git-apply" in the PATH.  That is 
how this change slipped in.

Please just ignore that file,
Dscho
