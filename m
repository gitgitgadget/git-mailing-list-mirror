From: Bill Lear <rael@zopyra.com>
Subject: Re: pull into dirty working tree
Date: Wed, 13 Jun 2007 11:30:30 -0500
Message-ID: <18032.7078.656285.877958@lisa.zopyra.com>
References: <18031.64456.948230.375333@lisa.zopyra.com>
	<Pine.LNX.4.64.0706131559210.4059@racer.site>
	<200706131640.22588.andyparkins@gmail.com>
	<18032.5016.716192.939675@lisa.zopyra.com>
	<Pine.LNX.4.64.0706131702020.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jun 13 18:31:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyVko-0004QE-5k
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 18:31:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758548AbXFMQaf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 12:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758588AbXFMQae
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 12:30:34 -0400
Received: from mail.zopyra.com ([65.68.225.25]:61380 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758512AbXFMQae (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 12:30:34 -0400
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l5DGUVm18821;
	Wed, 13 Jun 2007 11:30:31 -0500
In-Reply-To: <Pine.LNX.4.64.0706131702020.4059@racer.site>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50091>

On Wednesday, June 13, 2007 at 17:07:20 (+0100) Johannes Schindelin writes:
>Hi,
>
>On Wed, 13 Jun 2007, Bill Lear wrote:
>
>> I wonder, also, if there could be a way to alert users that their 
>> working tree is dirty before all the git pull blather comes out, scaring 
>> their poor little souls?
>
>Well, it's their fault, isn't it?

Yes, it is.  But that's no reason not to try to produce a nicer warning.

>> fatal: Entry 'src/netlist/EocCompiler.cc' not uptodate. Cannot merge.
>
>Sorry, this is the first time Git can realize that the dirty working 
>directory conflicts with the changes about to be applied.

Ah, this makes sense.  It has to do all the other stuff first and only
when it comes across one that won't "fit" does it complain.  This makes
more sense now...



Bill
