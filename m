From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH] mergetool: support absolute paths to tools by git config merge.<tool>path
Date: Tue, 9 Oct 2007 00:00:25 +0200
Message-ID: <20071008220025.GZ31659@planck.djpig.de>
References: <11918785613855-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Ts'o <tytso@mit.edu>, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Tue Oct 09 00:00:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1If0ed-0005Du-EC
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 00:00:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752828AbXJHWAj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2007 18:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752823AbXJHWAj
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Oct 2007 18:00:39 -0400
Received: from planck.djpig.de ([85.10.192.180]:2056 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752496AbXJHWAi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2007 18:00:38 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id 516D788231;
	Tue,  9 Oct 2007 00:00:36 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DRTlVQjrgbUV; Tue,  9 Oct 2007 00:00:26 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id 063FC88232; Tue,  9 Oct 2007 00:00:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <11918785613855-git-send-email-prohaska@zib.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60344>

On Mon, Oct 08, 2007 at 11:22:40PM +0200, Steffen Prohaska wrote:
> This commit adds a mechanism to provide absolute paths to the
> commands called by 'git mergetool'. A path can be specified
> in the configuation variable merge.<toolname>path.

Why not merge.<toolname>.path?
This would it make easy to introduce new variables of the form
merge.<toolname>.<var> later if needed. I also think it is more
consistent with names of existing configuration variables.
(think branch.<name>.<var> or remote.<name>.<var>)

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
