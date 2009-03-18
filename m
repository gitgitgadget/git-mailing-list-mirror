From: Andreas Gruenbacher <agruen@suse.de>
Subject: Re: [PATCH] Introduce %<branch> as shortcut to the tracked branch
Date: Wed, 18 Mar 2009 22:41:44 +0100
Organization: SUSE Labs / Novell
Message-ID: <200903182241.44388.agruen@suse.de>
References: <200903181448.50706.agruen@suse.de> <20090318182603.GM8940@machine.or.cz> <alpine.DEB.1.00.0903182210310.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 18 22:45:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lk3ZG-0002Ts-0X
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 22:44:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757574AbZCRVmz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 17:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757118AbZCRVmy
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 17:42:54 -0400
Received: from ns2.suse.de ([195.135.220.15]:34400 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757435AbZCRVmw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 17:42:52 -0400
Received: from Relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 7D2298730A;
	Wed, 18 Mar 2009 22:42:50 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0903182210310.10279@pacific.mpi-cbg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113684>

On Wednesday, 18 March 2009 22:12:19 Johannes Schindelin wrote:
> Suggested by Pasky.

Doesn't work here with git e986ceb, unfortunately. On branch master which is 
tracking origin/master, I get this:

	$ git log %..
	fatal: ambiguous argument '%..': unknown revision or path not in the
		working tree.

(There also is a trivial reject in hunk one as well.)

Thanks,
Andreas
