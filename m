From: Mike Hommey <mh@glandium.org>
Subject: Re: git pack-objects input list
Date: Sat, 1 Dec 2007 23:38:49 +0100
Organization: glandium.org
Message-ID: <20071201223849.GA15110@glandium.org>
References: <20071201104502.GA1457@glandium.org> <alpine.LFD.0.9999.0712010933370.8458@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Dec 01 23:39:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyazR-0001Bw-Px
	for gcvg-git-2@gmane.org; Sat, 01 Dec 2007 23:39:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751903AbXLAWix (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2007 17:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbXLAWix
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Dec 2007 17:38:53 -0500
Received: from smtp28.orange.fr ([80.12.242.99]:26055 "EHLO smtp28.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750720AbXLAWiw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2007 17:38:52 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2801.orange.fr (SMTP Server) with ESMTP id C6C6B7000090
	for <git@vger.kernel.org>; Sat,  1 Dec 2007 23:38:50 +0100 (CET)
Received: from namakemono.glandium.org (APuteaux-153-1-85-180.w86-205.abo.wanadoo.fr [86.205.43.180])
	by mwinf2801.orange.fr (SMTP Server) with ESMTP id A0A53700008E;
	Sat,  1 Dec 2007 23:38:50 +0100 (CET)
X-ME-UUID: 20071201223850658.A0A53700008E@mwinf2801.orange.fr
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1Iyaz3-0004jP-Ol; Sat, 01 Dec 2007 23:38:49 +0100
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.9999.0712010933370.8458@woody.linux-foundation.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66741>

On Sat, Dec 01, 2007 at 09:49:00AM -0800, Linus Torvalds wrote:
> Hope that clarified something.

Thanks, that helped me understand my observations when trying to pack
with and without file names in pack-objects input on different kind of
datasets, where some would be best packed with and others would be without.

I'll try to add some words about the pack-objects input format in the
documentation. I don't know if it's worth adding information about the
packing process itself in the manual page. Or maybe that should be added
to a more technical document about git (a bit like "git for computer
scientists")

Mike
