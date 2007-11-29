From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] scripts: do not get confused with HEAD in work tree
Date: Thu, 29 Nov 2007 08:02:57 +0100
Organization: glandium.org
Message-ID: <20071129070257.GB5144@glandium.org>
References: <7vbq9d29h3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 08:03:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxdQf-0000cs-Kp
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 08:03:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751931AbXK2HDB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 02:03:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751987AbXK2HDA
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 02:03:00 -0500
Received: from smtp28.orange.fr ([80.12.242.100]:61376 "EHLO smtp28.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751719AbXK2HDA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 02:03:00 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2808.orange.fr (SMTP Server) with ESMTP id 3F31580000B7
	for <git@vger.kernel.org>; Thu, 29 Nov 2007 08:02:58 +0100 (CET)
Received: from namakemono.glandium.org (APuteaux-153-1-85-180.w86-205.abo.wanadoo.fr [86.205.43.180])
	by mwinf2808.orange.fr (SMTP Server) with ESMTP id 25F5380000B2;
	Thu, 29 Nov 2007 08:02:58 +0100 (CET)
X-ME-UUID: 20071129070258155.25F5380000B2@mwinf2808.orange.fr
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1IxdQH-0001pf-NC; Thu, 29 Nov 2007 08:02:57 +0100
Content-Disposition: inline
In-Reply-To: <7vbq9d29h3.fsf@gitster.siamese.dyndns.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66508>

On Wed, Nov 28, 2007 at 04:15:04PM -0800, Junio C Hamano wrote:
> When you have a file called HEAD in your work tree, many commands that
> our scripts feed "HEAD" to would complain about the rev vs path
> ambiguity.  A solution is to form command line more carefully by
> appending -- to them, which makes it clear that we mean HEAD rev not
> HEAD file.

Shouldn't this be done for anything else, then ? You could have a file
with the same name as a branch and have some commands using branch names
fail too.

Mike
