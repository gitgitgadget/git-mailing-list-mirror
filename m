From: Charles Bailey <charles@hashpling.org>
Subject: Re: git archive problem with 1.6.0.3 (maybe regression?)
Date: Fri, 31 Oct 2008 22:37:10 +0000
Message-ID: <490B8896.6040007@hashpling.org>
References: <200810312213.32224.ag@alessandroguido.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alessandro Guido <ag@alessandroguido.name>
X-From: git-owner@vger.kernel.org Fri Oct 31 23:38:30 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw2dR-0002TN-D7
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 23:38:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752532AbYJaWhP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 18:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750866AbYJaWhO
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 18:37:14 -0400
Received: from pih-relay04.plus.net ([212.159.14.17]:44259 "EHLO
	pih-relay04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751893AbYJaWhN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 18:37:13 -0400
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay04.plus.net with esmtp (Exim) id 1Kw2cA-000356-Lu; Fri, 31 Oct 2008 22:37:10 +0000
Received: from [192.168.76.29] (heisenberg2.hashpling.org [192.168.76.29])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id m9VMbAYN012404;
	Fri, 31 Oct 2008 22:37:10 GMT
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
In-Reply-To: <200810312213.32224.ag@alessandroguido.name>
X-Plusnet-Relay: 54c132cb0c0580eb5e1a08a5633ad90f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99663>

Alessandro Guido wrote:
> [please CC: me on replies]
> 
> Hi everybody.
> 
> With git 1.6.0.3, I get the  following error when trying to "git archive" on a 
> bare clone of the Linux kernel repo:
> 
> ~ $ cd Kernel/
> ~/Kernel $ ls
> branches  config  description  FETCH_HEAD  HEAD  hooks  info  logs  objects  
> packed-refs  refs
> ~/Kernel $ git archive 721d5df > /dev/null
> fatal: Not a valid object name
> 
> With git 1.6.0.2, on the same tree, it works fine.

http://git.kernel.org/?p=git/git.git;a=commit;h=ddff8563510a2c5c675d488a02e2642306430fc1
