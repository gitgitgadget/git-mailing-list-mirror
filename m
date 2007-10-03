From: Kyle McMartin <kyle@mcmartin.ca>
Subject: Re: Clone corruption to G4 MacOSX
Date: Wed, 3 Oct 2007 01:28:34 -0400
Message-ID: <20071003052834.GC13738@fattire.cabal.ca>
References: <82638874-6766-4DCD-BF5B-3893F9B5046F@cs.indiana.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Perry Wagle <wagle@cs.indiana.edu>
X-From: git-owner@vger.kernel.org Wed Oct 03 07:28:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Icwmr-0003BF-R9
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 07:28:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751562AbXJCF2i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 01:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751628AbXJCF2i
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 01:28:38 -0400
Received: from stout.engsoc.carleton.ca ([134.117.69.22]:54522 "EHLO
	stout.engsoc.carleton.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751530AbXJCF2h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 01:28:37 -0400
Received: from localhost (stout [127.0.0.1])
	by stout.engsoc.carleton.ca (Postfix) with ESMTP id 38C0A5840CE;
	Wed,  3 Oct 2007 01:28:36 -0400 (EDT)
Received: from fattire.cabal.ca (cabal.ca [134.117.69.58])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by stout.engsoc.carleton.ca (Postfix) with ESMTP id EC4025840C8;
	Wed,  3 Oct 2007 01:28:34 -0400 (EDT)
Received: by fattire.cabal.ca (Postfix, from userid 1000)
	id 88F1E23E02; Wed,  3 Oct 2007 01:28:34 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <82638874-6766-4DCD-BF5B-3893F9B5046F@cs.indiana.edu>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at engsoc.carleton.ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59787>

On Tue, Oct 02, 2007 at 09:29:07PM -0700, Perry Wagle wrote:
> If I clone Linus's repository to a x86 machine, I get no corruption.
> 
> My wild ass guess is that being big-endian is causing trouble.
> 

The problem is MacOSX uses a case-insensitive filesystem by default...

Cheers,
	Kyle
