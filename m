From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCHv3 2/2] git submodule: Fix adding of submodules at paths
 with ./, .. and //
Date: Tue, 3 Mar 2009 15:29:29 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903031529040.6399@intel-tinevez-2-302>
References: <7vtz6ht9ho.fsf@gitster.siamese.dyndns.org> <1236083989-20526-1-git-send-email-git@drmicha.warpmail.net> <1236083989-20526-2-git-send-email-git@drmicha.warpmail.net> <1236083989-20526-3-git-send-email-git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Andrei Thorp <garoth@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Mar 03 15:31:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeVeC-0000sF-Nv
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 15:31:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751929AbZCCO3f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 09:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbZCCO3e
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 09:29:34 -0500
Received: from mail.gmx.net ([213.165.64.20]:55603 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750719AbZCCO3e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 09:29:34 -0500
Received: (qmail invoked by alias); 03 Mar 2009 14:29:31 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp013) with SMTP; 03 Mar 2009 15:29:31 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+9mXg+ZqG9IVqNO/GOIWcEc4QQrjODrgXbMEGywD
	IDA5ndKmuwe9QV
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <1236083989-20526-3-git-send-email-git@drmicha.warpmail.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.72
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112076>

Hi,

On Tue, 3 Mar 2009, Michael J Gruber wrote:

> Make 'git submodule add' normalize the submodule path in the
> same way as 'git ls-files' does, so that 'git submodule init' looks up
> the information in .gitmodules with the same key under which 'git
> submodule add' stores it.
> 
> This fixes 4 known breakages.

Maybe it is time to turn this into a builtin?

Ciao,
Dscho
